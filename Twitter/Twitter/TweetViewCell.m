//
//  TweetViewCell.m
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetViewCell.h"


@interface TweetViewCellContent:UIView
@end
@implementation TweetViewCellContent
- (void)drawRect:(CGRect)rect
{
    [(TweetViewCell*)self.superview.superview drawRectContent:rect];
}
@end


@implementation TweetViewCell

@synthesize nameLabel, screenNameLabel, tweetLabel;

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
        
        contentView = [[TweetViewCellContent alloc] initWithFrame:CGRectZero];
        contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentView];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        
        screenNameLabel = [[UILabel alloc] init];
        screenNameLabel.font = [UIFont systemFontOfSize:12];
        
        tweetLabel = [[UILabel alloc] init];
        tweetLabel.font = [UIFont systemFontOfSize:14];
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
    [screenNameLabel release];
    [tweetLabel release];
    [contentView removeFromSuperview];
    [contentView release];
    [super dealloc];
}

#pragma mark - Calculations

- (float)calculateGeometries:(CGRect)rect
{
    float content_width = (rect.size.width - CONTENT_LEFT - CELL_RIGHT_MARGIN);
    float y = CELL_TOP_MARGIN;
    float x = CONTENT_LEFT;
    float dx;
    
    NSString *s;
    CGSize size;
    
    // 名前
    s = nameLabel.text;
    size = [s sizeWithFont:nameLabel.font forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
    nameRect = CGRectMake(x, y, size.width, size.height);
    
    // スクリーン名
    dx = nameRect.size.width + 4;
    s = screenNameLabel.text;
    size = [s sizeWithFont:screenNameLabel.font forWidth:(content_width - dx) lineBreakMode:UILineBreakModeTailTruncation];
    screenNameRect = CGRectMake(x + dx, y, size.width, size.height);
    
    // つぶやき
    y += nameRect.size.height;
    s = tweetLabel.text;
    size = [s sizeWithFont:tweetLabel.font constrainedToSize:CGSizeMake(content_width, 10000) lineBreakMode:UILineBreakModeWordWrap];
    tweetRect = CGRectMake(x, y, size.width, size.height);
    
    // 全体の高さ
    y += tweetRect.size.height;
    float cellHeight = y + CELL_BOTTOM_MARGIN;
    if (cellHeight < CELL_MIN_HEIGHT) cellHeight = CELL_MIN_HEIGHT;
    return cellHeight;
}

#pragma mark - View lifecycle

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(CELL_LEFT_MARGIN, CELL_TOP_MARGIN, IMAGE_SIZE, IMAGE_SIZE);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 5.0;
}

- (void)drawRectContent:(CGRect)rect
{
    // サイズ計算
    [self calculateGeometries:rect];
    
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
    
    [blackColor set];
    s = nameLabel.text;
    [s drawInRect:nameRect withFont:nameLabel.font];
    
    [grayColor set];
    s = screenNameLabel.text;
    [s drawInRect:screenNameRect withFont:screenNameLabel.font];
    
    [blackColor set];
    s = tweetLabel.text;
    [s drawInRect:tweetRect withFont:tweetLabel.font];
    
    // 角丸矩形
    CGRect imageRect = self.imageView.frame;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, imageRect);
    if (self.imageView.image == nil) {
        [[UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0] set];
        CGFloat lx = CGRectGetMinX(imageRect);
        CGFloat cx = CGRectGetMidX(imageRect);
        CGFloat rx = CGRectGetMaxX(imageRect);
        CGFloat by = CGRectGetMinY(imageRect);
        CGFloat cy = CGRectGetMidY(imageRect);
        CGFloat ty = CGRectGetMaxY(imageRect);
        CGContextMoveToPoint(context, lx, cy);
        CGContextAddArcToPoint(context, lx, by, cx, by, 5.0);
        CGContextAddArcToPoint(context, rx, by, rx, cy, 5.0);
        CGContextAddArcToPoint(context, rx, ty, cx, ty, 5.0);
        CGContextAddArcToPoint(context, lx, ty, lx, cy, 5.0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end
