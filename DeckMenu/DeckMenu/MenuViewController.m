//
//  MenuViewController.m
//  DeckMenu
//
//  Created by Hiroaki Komatsu on 2013/01/05.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic, assign) NSArray *data;

@end

@implementation MenuViewController

@synthesize data = _data;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.separatorColor = [UIColor blackColor];
        self.view.backgroundColor = [UIColor colorWithRed:0.141 green:0.141 blue:0.141 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配列リテラル
    NSDictionary *dc1 = @{@"label": @"その１", @"tag": [NSNumber numberWithInt:ContentType_1]};
    NSDictionary *dc2 = @{@"label": @"その２", @"tag": [NSNumber numberWithInt:ContentType_2]};
    NSDictionary *dc3 = @{@"label": @"その３", @"tag": [NSNumber numberWithInt:ContentType_3]};
    self.data = @[@[dc1, dc2, dc3]];
    
    [self.tableView reloadData];
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
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.data != nil) {
        return [[self.data objectAtIndex:section] count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        // ハイライト色を変更
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:0.110 green:0.455 blue:0.922 alpha:1.0];
        cell.selectedBackgroundView = backgroundView;
    }
    
    NSDictionary *dc = [self dictionaryForRowAtIndexPath:indexPath];
    if (dc != nil) {
        cell.textLabel.text = [dc objectForKey:@"label"];
        cell.tag = [[dc objectForKey:@"tag"] intValue];
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - get NSDictionary

- (NSDictionary *)dictionaryForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.data != nil) {
        NSArray *arr = (NSArray *) [self.data objectAtIndex:indexPath.section];
        if (arr != nil) {
            return (NSDictionary *) [arr objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

@end
