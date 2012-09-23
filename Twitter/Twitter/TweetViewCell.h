//
//  TweetViewCell.h
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TweetViewCell : UITableViewCell
{
    UIView *contentView;
    UILabel *nameLabel;
    UILabel *screenNameLabel;
    UILabel *tweetLabel;
    
    CGRect nameRect;
    CGRect screenNameRect;
    CGRect tweetRect;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *screenNameLabel;
@property (nonatomic, retain) UILabel *tweetLabel;

- (void)drawRectContent:(CGRect)rect;
- (float)calculateGeometries:(CGRect)rect;

@end
