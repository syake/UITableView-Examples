//
//  CustomViewCell.h
//  CustomCell
//
//  Created by Hiroaki Komatsu on 12/09/24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomViewCell : UITableViewCell
{
    UIView *contentView;
    UILabel *titleLabel;
    UILabel *dateLabel;
    UILabel *locationLabel;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *locationLabel;

- (void)drawRectContent:(CGRect)rect;

@end
