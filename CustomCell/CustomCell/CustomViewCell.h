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
    UILabel *nameLabel;
    UILabel *descriptionLabel;
    
    UILabel *priceLabel;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UILabel *priceLabel;

- (void)drawRectContent:(CGRect)rect;

@end
