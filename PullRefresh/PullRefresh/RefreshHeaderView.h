//
//  RefreshHeaderView.h
//  PullRefresh
//
//  Created by Hiroaki Komatsu on 12/09/30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum
{
    RefreshHeaderViewStateHidden = 0,
    RefreshHeaderViewStatePulling,
    RefreshHeaderViewStateOveredThreshold,
    RefreshHeaderViewStateLoading
} RefreshHeaderViewState;

@interface RefreshHeaderView : UIView
{
    UILabel *statusLabel;
    CALayer *arrowLayer;
    UIActivityIndicatorView *activityIndicatorView;
    
    RefreshHeaderViewState _state;
}

- (BOOL)isLoading;
- (void)refreshLoading:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
