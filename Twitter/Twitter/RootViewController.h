//
//  RootViewController.h
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface RootViewController : UITableViewController
{
	BOOL loaded;
	NSArray *statuses;
	NSCache *imageCache;
}

@end
