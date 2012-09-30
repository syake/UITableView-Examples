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

@synthesize titleLabel, dateLabel, locationLabel;

// セル全体の上マージン
#define CELL_TOP_MARGIN 6

// セル全体の下マージン
#define CELL_BOTTOM_MARGIN 6

// セル全体の左マージン
#define CELL_LEFT_MARGIN 10

// セル全体の右マージン
#define CELL_RIGHT_MARGIN 14

// 画像の横サイズ
#define IMAGE_WIDTH 90

// 画像の縦サイズ
#define IMAGE_HEIGHT 60

// 水平のマージン
#define HORIZONTAL_MARGIN 8

// コンテンツ幅計算用の差分値
#define CONTENT_DIFFERENTIAL_WIDTH (CELL_LEFT_MARGIN + CELL_RIGHT_MARGIN + IMAGE_WIDTH + HORIZONTAL_MARGIN)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        
        contentView = [[CustomViewCellContent alloc] initWithFrame:CGRectZero];
        contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentView];
        
        // imageViewに影を付ける
        self.imageView.layer.shadowOpacity = 0.5;
        self.imageView.layer.shadowOffset = CGSizeMake(2, 2);
        self.imageView.layer.shadowRadius = 2.0;
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:12];
        
        locationLabel = [[UILabel alloc] init];
        locationLabel.font = [UIFont systemFontOfSize:14];
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
    [titleLabel release];
    [dateLabel release];
    [locationLabel release];
    [contentView removeFromSuperview];
    [contentView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void) layoutSubviews
{
    [super layoutSubviews];
    float y = CELL_TOP_MARGIN;
    float x = self.bounds.size.width - (IMAGE_WIDTH + CELL_RIGHT_MARGIN);
    self.imageView.frame = CGRectMake(x, y, IMAGE_WIDTH, IMAGE_HEIGHT);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)drawRectContent:(CGRect)rect
{
    float content_width = rect.size.width - CONTENT_DIFFERENTIAL_WIDTH;
    float y = CELL_TOP_MARGIN;
    float x = CELL_LEFT_MARGIN;
    
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
    s = titleLabel.text;
    size = [s sizeWithFont:titleLabel.font forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
    r = CGRectMake(x, y, size.width, size.height);
    [s drawInRect:r withFont:titleLabel.font lineBreakMode:UILineBreakModeTailTruncation];
    
    y += r.size.height + 2;
    
    [blackColor set];
    s = dateLabel.text;
    size = [s sizeWithFont:dateLabel.font forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
    r = CGRectMake(x, y, size.width, size.height);
    [s drawInRect:r withFont:dateLabel.font];
    
    y += r.size.height + 8;
    
    [grayColor set];
    s = locationLabel.text;
    size = [s sizeWithFont:locationLabel.font forWidth:content_width - 20 lineBreakMode:UILineBreakModeTailTruncation];
    r = CGRectMake(x + 20, y, size.width, size.height);
    [s drawInRect:r withFont:locationLabel.font lineBreakMode:UILineBreakModeTailTruncation];
    
    // 画像描画
    UIImage *image = [UIImage imageNamed:@"86-camera.png"];
    CGRect frame = CGRectMake(x, y + 3, 16, 12);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // 上下反転
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.d = -1.0f;
    transform.ty = frame.origin.y * 2.0 + frame.size.height;
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(context, frame, image.CGImage);
    UIGraphicsEndImageContext();
}

@end
