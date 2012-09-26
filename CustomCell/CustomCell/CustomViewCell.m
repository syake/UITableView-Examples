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
- (void)drawRect:(CGRect)rect
{
    [(CustomViewCell*)self.superview.superview drawRectContent:rect];
}
@end


@implementation CustomViewCell

@synthesize nameLabel, descriptionLabel, priceLabel;

// セル全体の上マージン
#define CELL_TOP_MARGIN 4

// セル全体の下マージン
#define CELL_BOTTOM_MARGIN 4

// セル全体の左マージン
#define CELL_LEFT_MARGIN 6

// セル全体の右マージン
#define CELL_RIGHT_MARGIN 4

// コンテンツの左マージン
#define CONTENT_LEFT_MARGIN 8

// 画像の縦横サイズ
#define IMAGE_SIZE 48

// 最小のセルの高さ
#define CELL_MIN_HEIGHT (CELL_TOP_MARGIN + IMAGE_SIZE + CELL_BOTTOM_MARGIN)

// コンテンツの左位置
#define CONTENT_LEFT (CELL_LEFT_MARGIN + IMAGE_SIZE + CONTENT_LEFT_MARGIN)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        
        contentView = [[CustomViewCellContent alloc] initWithFrame:CGRectZero];
        contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentView];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        
        descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font = [UIFont systemFontOfSize:14];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (selected == NO) {
        [self setNeedsDisplay];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    // Configure the view for the highlighted state
    if (highlighted == NO) {
        [self setNeedsDisplay];
    }
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [contentView setFrame:self.bounds];
    [contentView setNeedsDisplay];
}

- (void)dealloc
{
    [nameLabel release];
    [descriptionLabel release];
    [priceLabel release];
    [contentView removeFromSuperview];
    [contentView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(CELL_LEFT_MARGIN, CELL_TOP_MARGIN, IMAGE_SIZE, IMAGE_SIZE);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)drawRectContent:(CGRect)rect
{
    float content_width = (rect.size.width - CONTENT_LEFT - CELL_RIGHT_MARGIN);
    float y = CELL_TOP_MARGIN;
    float x = CONTENT_LEFT;
    
    // フォントカラー設定
    UIColor *blackColor;
    UIColor *grayColor;
    if (self.selected || self.highlighted) {
        blackColor = grayColor = [UIColor whiteColor];
    } else {
        blackColor = [UIColor blackColor];
        grayColor = [UIColor grayColor];
    }
    
    // テキスト描画
    NSString *s;
    CGSize size;
    CGRect r;
    
    [blackColor set];
    s = nameLabel.text;
    size = [s sizeWithFont:nameLabel.font forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
    r = CGRectMake(x, y, size.width, size.height);
    [s drawInRect:r withFont:nameLabel.font];
    
    [blackColor set];
    y += r.size.height;
    s = descriptionLabel.text;
    size = [s sizeWithFont:descriptionLabel.font forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
    r = CGRectMake(x, y, size.width, size.height);
    [s drawInRect:r withFont:descriptionLabel.font];
    
    [grayColor set];
    y += r.size.height;
    s = priceLabel.text;
    size = [s sizeWithFont:priceLabel.font forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
    r = CGRectMake(x, y, size.width, size.height);
    [s drawInRect:r withFont:priceLabel.font];
}

@end
