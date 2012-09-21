//
//  DetailViewController.h
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController : UIViewController
{
	NSDictionary *_data;
	UIImageView *imageView;
	UILabel *nameLabel;
	UILabel *screenNameLabel;
	UITextView *tweetText;
}

@property (nonatomic, assign) NSDictionary *data;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *screenNameLabel;
@property (nonatomic, retain) UITextView *tweetText;

@end
