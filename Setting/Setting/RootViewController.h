//
//  RootViewController.h
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController
{
    UISwitch *notificationSwitch;
    UISwitch *badgeSwitch;
    UISwitch *soundSwitch;
    
    NSArray *_difficultyList;
    NSString *_difficulty;
    
    BOOL _isNotification;
    BOOL _isBadge;
    BOOL _isSound;
    
    NSMutableArray *_accounts;
}

@end
