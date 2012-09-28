//
//  AddAccountViewController.h
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAccountViewController : UITableViewController
{
    UITextField *idTextField;
    UITextField *passwordTextField;
    UITableViewCell *signinCell;
    
    UIActivityIndicatorView *indicatorView;
    UIView *titleView;
}

@property (nonatomic, retain) NSMutableArray *datas;

@end
