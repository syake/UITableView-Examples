//
//  RootViewController.m
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "AccountViewController.h"
#import "AddAccountViewController.h"


@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [notificationSwitch removeFromSuperview];
    [notificationSwitch release];
    [badgeSwitch removeFromSuperview];
    [badgeSwitch release];
    [soundSwitch removeFromSuperview];
    [soundSwitch release];
    [_difficultyList release], _difficultyList = nil;
    [_difficulty release], _difficulty = nil;
    [_accounts release], _accounts = nil;
    [super dealloc];
}

#pragma mark - actions

- (void)notificationSwitchChanged:(id)selector
{
    _isNotification = [selector isOn];
}

- (void)badgeSwitchChanged:(id)selector
{
    _isBadge = [selector isOn];
}

- (void)soundSwitchChanged:(id)selector
{
    _isSound = [selector isOn];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // タイトル
    self.navigationItem.title = @"Setting";
    
    // スイッチ作成
    notificationSwitch = [[UISwitch alloc] init];
    [notificationSwitch addTarget:self action:@selector(notificationSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    badgeSwitch = [[UISwitch alloc] init];
    [badgeSwitch addTarget:self action:@selector(badgeSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    soundSwitch = [[UISwitch alloc] init];
    [soundSwitch addTarget:self action:@selector(soundSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    // データを生成
    _difficultyList = [[NSArray alloc] initWithObjects:
              [NSDictionary dictionaryWithObjectsAndKeys:@"EASY", @"name", @"easy", @"key", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"MEDIUM", @"name", @"medium", @"key", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"HARD", @"name", @"hard", @"key", nil],
              nil];
    _difficulty = @"easy";
    
    _isNotification = YES;
    _isBadge = YES;
    _isSound = YES;
    
    _accounts = [[NSMutableArray alloc] initWithObjects:
               [NSMutableDictionary dictionaryWithObjectsAndKeys:@"syake", @"id", @"guest", @"password", nil],
               nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [_difficultyList count];
            break;
        case 1:
            return 3;
            break;
        case 2:
            return [_accounts count] + 1;
            break;
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Difficulty:";
            break;
        case 1:
            return @"Notification:";
            break;
        case 2:
            return @"Account:";
            break;
    }
    return @"";
}

- (void)updateCheckmarkCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
    // チェックマーク選択のセルを更新
    NSDictionary *data = [_difficultyList objectAtIndex:indexPath.row];
    if ([_difficulty isEqualToString:[data objectForKey:@"key"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSMutableDictionary *data;
    int section = [indexPath section];
    int row = [indexPath row];
    switch (section) {
        case 0:
            data = [_difficultyList objectAtIndex:row];
            cell.textLabel.text = [data objectForKey:@"name"];
            [self updateCheckmarkCell:cell atIndexPath:indexPath];
            break;
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (row) {
                case 0:
                    cell.textLabel.text = @"通知センター";
                    notificationSwitch.on = _isNotification;
                    cell.accessoryView = notificationSwitch;
                    break;
                case 1:
                    cell.textLabel.text = @"バッジ表示";
                    badgeSwitch.on = _isBadge;
                    cell.accessoryView = badgeSwitch;
                    break;
                case 2:
                    cell.textLabel.text = @"サウンド";
                    soundSwitch.on = _isSound;
                    cell.accessoryView = soundSwitch;
                    break;
                default:
                    break;
            }
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row < [_accounts count]) {
                data = [_accounts objectAtIndex:row];
                cell.textLabel.text = [data objectForKey:@"id"];
            } else {
                cell.textLabel.text = @"アカウントを追加";
            }
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data;
    int section = [indexPath section];
    int row = [indexPath row];
    switch (section) {
        case 0:
            // 単一選択グループ
            
            data = [_difficultyList objectAtIndex:row];
            _difficulty = [data objectForKey:@"key"];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            int n = [_difficultyList count];
            for (int i = 0; i < n; i++) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:index];
                [self updateCheckmarkCell:cell atIndexPath:index];
            }
            break;
        case 2:
            // アカウント関連グループ
            
            if (indexPath.row < [_accounts count]) {
                // 登録されているアカウントのセル
                
                // Navigation logic may go here. Create and push another view controller.
                AccountViewController *accountViewController = [[[AccountViewController alloc] init] autorelease];
                accountViewController.datas = _accounts;
                accountViewController.index = row;
                
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:accountViewController animated:YES];
                
            } else {
                // アカウントを追加するためのセル
                
                // Navigation logic may go here. Create and push another view controller.
                AddAccountViewController *addAccountViewController = [[[AddAccountViewController alloc] init] autorelease];
                addAccountViewController.datas = _accounts;
                
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:addAccountViewController animated:YES];
            }
            break;
    }
}

@end
