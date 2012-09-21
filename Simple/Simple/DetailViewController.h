//
//  DetailViewController.h
//  Simple
//
//  Created by Hiroaki Komatsu on 12/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyData.h"

@interface DetailViewController : UIViewController
{
	MyData *data;
	UILabel *titleLabel;
}

@property (nonatomic, assign) MyData *data;
@property (nonatomic, retain) UILabel *titleLabel;

@end
