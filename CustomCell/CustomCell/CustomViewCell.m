//
//  CustomViewCell.m
//  CustomCell
//
//  Created by Hiroaki Komatsu on 12/09/24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"


@interface CustomViewCellContent:UIView
@end
@implementation CustomViewCellContent
- (void)drawRect:(CGRect)rect {
    [(CustomViewCell*)self.superview drawRectContent:rect];
}
@end


@implementation CustomViewCell

@synthesize nameLabel, descriptionLabel, priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        
        contentView = [[CustomViewCellContent alloc] initWithFrame:CGRectZero];
        contentView.opaque = YES;
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        [self addSubview:self.imageView];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        
        descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font = [UIFont systemFontOfSize:14];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:12];
        
//        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
//        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
//        priceLabel.frame = CGRectMake(40, 40, 500, 20);
//        [self addSubview:priceLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [nameLabel release];
    [descriptionLabel release];
    [priceLabel release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void) layoutSubviews {
    [super layoutSubviews];
    
//    self.textLabel.font = [UIFont boldSystemFontOfSize:14];
//    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    //self.imageView.frame = CGRectMake(CELL_LEFT_MARGIN, CELL_TOP_MARGIN, IMAGE_SIZE, IMAGE_SIZE);
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //self.imageView.layer.masksToBounds = YES;
    //self.imageView.layer.cornerRadius = 5.0;
}

- (void)drawRect:(CGRect)rect
{
    
}

- (void)drawRectContent:(CGRect)rect
{
    
}

@end
