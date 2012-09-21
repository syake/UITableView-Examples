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
- (void)drawRect:(CGRect)rect {
	[(TweetViewCell*)self.superview drawRectContent:rect];
}
@end


@implementation TweetViewCell

@synthesize contentView, nameLabel, screenNameLabel, tweetLabel;

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

// 名前フォント
static UIFont *_nameFont = nil;
+ (UIFont*)nameFont
{
	if (!_nameFont) {
		_nameFont = [UIFont boldSystemFontOfSize:14];
	}
	return _nameFont;
}

// スクリーン名フォント
static UIFont *_screenNameFont = nil;
+ (UIFont*)screenNameFont
{
	if (!_screenNameFont) {
		_screenNameFont = [UIFont systemFontOfSize:12];
	}
	return _screenNameFont;
}

// テキストフォント
static UIFont *_tweetFont = nil;
+ (UIFont*)tweetFont
{
	if (!_tweetFont) {
		_tweetFont = [UIFont systemFontOfSize:14];
	}
	return _tweetFont;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Custom initialization
		self.accessoryType = UITableViewCellAccessoryNone;
		
		contentView = [[TweetViewCellContent alloc] initWithFrame:CGRectZero];
		contentView.opaque = YES;
		contentView.backgroundColor = [UIColor clearColor];
		[self addSubview:contentView];
		
		nameLabel = [[UILabel alloc] init];
		screenNameLabel = [[UILabel alloc] init];
		tweetLabel = [[UILabel alloc] init];
		[self addSubview:self.imageView];
	}
	return self;
}

- (void)dealloc
{
	[nameLabel release];
	[screenNameLabel release];
	[tweetLabel release];
	
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
	size = [s sizeWithFont:[TweetViewCell nameFont] forWidth:content_width lineBreakMode:UILineBreakModeTailTruncation];
	nameRect = CGRectMake(x, y, size.width, size.height);
	
	// スクリーン名
	dx = nameRect.size.width + 4;
	s = screenNameLabel.text;
	size = [s sizeWithFont:[TweetViewCell screenNameFont] forWidth:(content_width - dx) lineBreakMode:UILineBreakModeTailTruncation];
	screenNameRect = CGRectMake(x + dx, y, size.width, size.height);
	
	// つぶやき
	y += nameRect.size.height;
	s = tweetLabel.text;
	size = [s sizeWithFont:[TweetViewCell tweetFont] constrainedToSize:CGSizeMake(content_width, 10000) lineBreakMode:UILineBreakModeWordWrap];
	tweetRect = CGRectMake(x, y, size.width, size.height);
	
	// 全体の高さ
	y += tweetRect.size.height;
	float cellHeight = y + CELL_BOTTOM_MARGIN;
	if (cellHeight < CELL_MIN_HEIGHT) cellHeight = CELL_MIN_HEIGHT;
	return cellHeight;
}

#pragma mark - View lifecycle

- (void) layoutSubviews {
	[super layoutSubviews];
	self.imageView.frame = CGRectMake(CELL_LEFT_MARGIN, CELL_TOP_MARGIN, IMAGE_SIZE, IMAGE_SIZE);
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.layer.masksToBounds = YES;
	self.imageView.layer.cornerRadius = 5.0;
}

- (void)drawRect:(CGRect)rect
{
	// 背景描画
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
	[s drawInRect:nameRect withFont:[TweetViewCell nameFont]];
	
	[grayColor set];
	s = screenNameLabel.text;
	[s drawInRect:screenNameRect withFont:[TweetViewCell screenNameFont]];
	
	[blackColor set];
	s = tweetLabel.text;
	[s drawInRect:tweetRect withFont:[TweetViewCell tweetFont]];
	
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

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[contentView setNeedsDisplay];
}

- (void)setFrame:(CGRect)rect
{
	[super setFrame:rect];
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected == NO) {
		[self setNeedsDisplay];
	}
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	if (highlighted == NO) {
		[self setNeedsDisplay];
	}
}

@end
