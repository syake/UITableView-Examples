//
//  AddAccountViewController.m
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddAccountViewController.h"


@implementation AddAccountViewController

@synthesize datas;

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
    [idTextField removeFromSuperview];
    [idTextField release];
    [passwordTextField removeFromSuperview];
    [passwordTextField release];
    [indicatorView removeFromSuperview];
    [indicatorView release];
    [titleView removeFromSuperview];
    [titleView release];
    [super dealloc];
}

#pragma mark - actions

- (void)respondsToEditingChanged:(id)selector
{
    // テキストフィールドに入力されている文字数を動的に確認する。
    if (idTextField.text.length == 0 || passwordTextField.text.length == 0) {
        [self.tableView setAllowsSelection:NO];
        signinCell.textLabel.textColor = [UIColor grayColor];
    } else {
        [self.tableView setAllowsSelection:YES];
        signinCell.textLabel.textColor = [UIColor blackColor];
    }
}

- (void)singingSuccess
{
    // サインインが成功したときに、入力したデータを追加して１つ上の画面へ戻る。
    self.navigationItem.titleView = nil;
    self.navigationItem.title = @"アカウントを追加";
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:idTextField.text, @"id", passwordTextField.text, @"password", nil];
    [datas addObject:dictionary];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // タイトル
    self.navigationItem.title = @"アカウントを追加";
    
    // テキストフィールド作成
    idTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    idTextField.font = [UIFont systemFontOfSize:18.0];
    idTextField.textAlignment = UITextAlignmentLeft;
    idTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    idTextField.adjustsFontSizeToFitWidth = YES;
    idTextField.textColor = [UIColor colorWithRed:59.0/255.0 green:85.0/255.0 blue:133.0/255.0 alpha:1.0];
    [idTextField addTarget:self action:@selector(respondsToEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    passwordTextField.font = [UIFont systemFontOfSize:18.0];
    passwordTextField.textAlignment = UITextAlignmentLeft;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.textColor = [UIColor colorWithRed:59.0/255.0 green:85.0/255.0 blue:133.0/255.0 alpha:1.0];
    passwordTextField.secureTextEntry = YES;
    [passwordTextField addTarget:self action:@selector(respondsToEditingChanged:) forControlEvents:UIControlEventEditingChanged];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    int section = [indexPath section];
    int row = [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch (section) {
        case 0:
            // アカウント入力グループ
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (row) {
                case 0:
                    cell.textLabel.text = @"ユーザ名";
                    idTextField.frame = CGRectMake(120, 0, cell.frame.size.width - 140, cell.frame.size.height);
                    idTextField.placeholder = @"名前";
                    cell.accessoryView = idTextField;
                    break;
                case 1:
                    cell.textLabel.text = @"パスワード";
                    passwordTextField.frame = CGRectMake(120, 0, cell.frame.size.width - 140, cell.frame.size.height);
                    passwordTextField.placeholder = @"必須";
                    cell.accessoryView = passwordTextField;
                    break;
            }
            break;
        case 1:
            // サインイン
            signinCell = cell;
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"サインイン";
            [self respondsToEditingChanged:nil];
            break;
        default:
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
    int section = [indexPath section];
    int row = [indexPath row];
    
    switch (section) {
        case 1:
            switch (row) {
                case 0:
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    
                    if (indicatorView == nil) {
                        // インジケーター作成
                        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                    }
                    
                    if (titleView == nil) {
                        // タイトルビュー作成
                        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(indicatorView.bounds.size.width + 7, -2, 0, 0)];
                        titleLabel.backgroundColor = [UIColor clearColor];
                        titleLabel.textColor = [UIColor whiteColor];
                        titleLabel.font = [UIFont boldSystemFontOfSize:20];
                        titleLabel.text = @"確認中";
                        [titleLabel sizeToFit];
                        
                        titleView = [[UIView alloc] init];
                        [titleView addSubview:indicatorView];
                        [titleView addSubview:titleLabel];
                        titleView.frame = CGRectMake(0, 0, titleLabel.bounds.size.width + 7 + titleLabel.bounds.size.width, indicatorView.bounds.size.height);
                        [titleLabel release];
                    }
                    
                    // タイトル
                    [self.navigationItem setTitleView:titleView];
                    [indicatorView startAnimating];
                    
                    // 全ての選択を無効
                    [self.tableView setAllowsSelection:NO];
                    [idTextField setEnabled:NO];
                    [passwordTextField setEnabled:NO];
                    
                    // 遅延実行
                    [self performSelector:@selector(singingSuccess) withObject:nil afterDelay:5.0];
                    break;
            }
            break;
    }
}

@end
