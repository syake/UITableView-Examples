//
//  RootViewController.h
//  SimpleARC
//
//  Created by Hiroaki Komatsu on 2013/01/09.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface RootViewController : UITableViewController {
    __strong NSMutableArray *_datas;
    __strong DetailViewController *_detailViewController;
}

@end
