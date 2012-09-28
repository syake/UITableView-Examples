//
//  AccountViewController.m
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccountViewController.h"


@implementation AccountViewController

@synthesize datas, index;

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
    [super dealloc];
}

#pragma mark - actions

- (void)doneButtonPushed:(id)selector
{
    // [完了]ボタンが押されたときに、入力されているデータに書き換えて１つ上の画面へ戻る。
    [_data setObject:idTextField.text forKey:@"id"];
    [_data setObject:passwordTextField.text forKey:@"password"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)removeButtonPushed:(id)selector
{
    // [アカウントを削除]ボタンが押されたときに、アクションシートを表示して実行を確認する。
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"このアカウントを削除しますか？" delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:@"アカウントを削除" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // タイトル
    self.navigationItem.title = @"アカウント";
    
    // [完了]ボタン作成
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPushed:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    // [アカウントを削除]ボタン作成
    float width = self.view.bounds.size.width - 20;
    float height = 44;
    
    UIButton *removeButton = [UIButton buttonWithType:115];
    removeButton.frame = CGRectMake(0, 20, width, height);
    [removeButton addTarget:self action:@selector(removeButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [removeButton setTitle:@"アカウントを削除" forState:UIControlStateNormal];
    
    UIView *footerView = [[[UIView alloc] initWithFrame:CGRectMake(10, 0, width, height)] autorelease];
    [footerView addSubview:removeButton];
    self.tableView.tableFooterView = footerView;
    
    // テキストフィールド作成
    idTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    idTextField.font = [UIFont systemFontOfSize:18.0];
    idTextField.textAlignment = UITextAlignmentLeft;
    idTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    idTextField.adjustsFontSizeToFitWidth = YES;
    idTextField.textColor = [UIColor colorWithRed:59.0/255.0 green:85.0/255.0 blue:133.0/255.0 alpha:1.0];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    passwordTextField.font = [UIFont systemFontOfSize:18.0];
    passwordTextField.textAlignment = UITextAlignmentLeft;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.textColor = [UIColor colorWithRed:59.0/255.0 green:85.0/255.0 blue:133.0/255.0 alpha:1.0];
    passwordTextField.secureTextEntry = YES;
    
    // データを取得
    if (datas && [datas count] > index) {
        _data = [datas objectAtIndex:index];
    }
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
{    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    int row = [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
    switch (row) {
        case 0:
            cell.textLabel.text = @"ユーザ名";
            idTextField.frame = CGRectMake(120, 0, cell.frame.size.width - 140, cell.frame.size.height);
            idTextField.text = [_data objectForKey:@"id"];
            cell.accessoryView = idTextField;
            break;
        case 1:
            cell.textLabel.text = @"パスワード";
            passwordTextField.frame = CGRectMake(120, 0, cell.frame.size.width - 140, cell.frame.size.height);
            passwordTextField.text = [_data objectForKey:@"password"];
            cell.accessoryView = passwordTextField;
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

#pragma mark - UIActionSheet delegate

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // [アカウントを削除]ボタンの実行の確認が許可されたら、データからアカウントを削除して１つ上の画面へ戻る。
        [datas removeObjectAtIndex:index];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
