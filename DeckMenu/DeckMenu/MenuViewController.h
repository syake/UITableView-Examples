//
//  MenuViewController.h
//  DeckMenu
//
//  Created by Hiroaki Komatsu on 2013/01/05.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ContentType_1,
    ContentType_2,
    ContentType_3,
};
typedef NSUInteger ContentType;


@protocol MenuViewControllerDelegate

@optional

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MenuViewController : UITableViewController {
    __strong NSArray *_datas;
    __strong NSArray *_titles;
}

@property (nonatomic, assign) id <MenuViewControllerDelegate> delegate;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end

