//
//  RootViewController.m
//  SimpleARC
//
//  Created by Hiroaki Komatsu on 2013/01/09.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // タイトル
    self.navigationItem.title = @"Simple";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // データを生成
    _datas = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        NSDictionary *dc = @{@"label": [[NSString alloc] initWithFormat:@"%i番目の項目", i], @"tag": [NSNumber numberWithInt:i]};
        [_datas addObject:dc];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dc = [_datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [dc objectForKey:@"label"];
    cell.tag = [[dc objectForKey:@"tag"] intValue];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if (_detailViewController == nil) {
        _detailViewController = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
    }
        
    // データを受け渡す
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _detailViewController.navigationItem.title = [[NSString alloc] initWithFormat:@"%@", cell.textLabel.text];
    _detailViewController.textLabel.text = [[NSString alloc] initWithFormat:@"%@", cell.textLabel.text];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:_detailViewController animated:YES];
}

@end
