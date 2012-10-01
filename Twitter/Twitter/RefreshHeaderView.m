//
//  RefreshHeaderView.m
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/10/01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RefreshHeaderView.h"

@implementation RefreshHeaderView

#define PULLDOWN_MARGIN 60.0

- (void)setState:(RefreshHeaderViewState)state
{
    switch (state) {
        case RefreshHeaderViewStateHidden:
            [activityIndicatorView stopAnimating];
            [arrowLayer setHidden:NO];
            [arrowLayer removeAllAnimations];
            arrowLayer.transform = CATransform3DIdentity;
            break;
        case RefreshHeaderViewStatePulling:
            [activityIndicatorView stopAnimating];
            [arrowLayer setHidden:NO];
            statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh...");
            if (_state != RefreshHeaderViewStatePulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.18f];
                arrowLayer.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            break;
        case RefreshHeaderViewStateOveredThreshold:
            [activityIndicatorView stopAnimating];
            [arrowLayer setHidden:NO];
            statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh...");
            if (_state == RefreshHeaderViewStatePulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.18f];
                arrowLayer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
                [CATransaction commit];
            }
            break;
        case RefreshHeaderViewStateLoading:
            [activityIndicatorView startAnimating];
            [arrowLayer setHidden:YES];
            statusLabel.text = NSLocalizedString(@"Loading...", @"Loading...");
            break;
    }
    
    _state = state;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        statusLabel = [[UILabel alloc] init];
        statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        statusLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.textAlignment = UITextAlignmentLeft;
        statusLabel.textColor = [UIColor grayColor];
        [self addSubview:statusLabel];
        
        arrowLayer = [CALayer layer];
        arrowLayer.contentsGravity = kCAGravityResizeAspect;
        arrowLayer.contents = (id)[UIImage imageNamed:@"grayArrow.png"].CGImage;
        [[self layer] addSublayer:arrowLayer];
        
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:activityIndicatorView];
        
        [self setState:RefreshHeaderViewStateHidden];
        
    }
    return self;
}

- (void)dealloc
{
    [statusLabel removeFromSuperview];
    [statusLabel release];
    [activityIndicatorView removeFromSuperview];
    [activityIndicatorView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void) layoutSubviews
{
    [super layoutSubviews];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    float x = (width - 110.0f) / 2;
    float y = height - 40.0f;
    statusLabel.frame = CGRectMake(x, y, width - x, 20.0f);
    arrowLayer.frame = CGRectMake(x - 28.0f, y - 2.0f, 14.0f, 28.0f);
    activityIndicatorView.frame = CGRectMake(x - 28.0f, y + 2.0f, 18.0f, 18.0f);
}

#pragma mark - readonly method

- (BOOL)isLoading
{
    return (_state == RefreshHeaderViewStateLoading);
}

- (void)refreshLoading:(UIScrollView *)scrollView
{
    self.state = RefreshHeaderViewStateLoading;
    
    // オフセット切り替え
    CGFloat topOffset = PULLDOWN_MARGIN - self.frame.size.height;
    scrollView.contentInset = UIEdgeInsetsMake(topOffset, 0.0f, 0.0f, 0.0f);
}

#pragma mark - UIScrollView method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == RefreshHeaderViewStateLoading) {
        return;
    }
    
    CGFloat threshold = self.frame.size.height;
    CGFloat margin = threshold - PULLDOWN_MARGIN;
    if (margin <= scrollView.contentOffset.y && scrollView.contentOffset.y < threshold) {
        self.state = RefreshHeaderViewStatePulling;
    } else if (margin > scrollView.contentOffset.y) {
        self.state = RefreshHeaderViewStateOveredThreshold;
    } else {
        self.state = RefreshHeaderViewStateHidden;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_state == RefreshHeaderViewStateOveredThreshold && decelerate) {
        self.state = RefreshHeaderViewStateLoading;
        
        // オフセット切り替え
        CGFloat topOffset = PULLDOWN_MARGIN - self.frame.size.height;
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationDuration:0.2f];
        scrollView.contentInset = UIEdgeInsetsMake(topOffset, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
    }
}

- (void)scrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    self.state = RefreshHeaderViewStateHidden;
    
    // オフセット切り替え
    CGFloat topOffset = 0 - self.frame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.3f];
    scrollView.contentInset = UIEdgeInsetsMake(topOffset, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
}

@end
