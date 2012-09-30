//
//  RootViewController.m
//  CustomCell
//
//  Created by Hiroaki Komatsu on 12/09/24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "CustomViewCell.h"


@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [_datas release], _datas = nil;
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // タイトル
    self.navigationItem.title = @"CustomCell";
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // データを生成
    _datas = [[NSArray alloc] initWithObjects:
              [NSDictionary dictionaryWithObjectsAndKeys:@"01609", @"id", @"公園からサグラダ・ファミリアを", @"title", @"サグラダ・ファミリア（聖家族教会）", @"location", @"2img_2788.jpg", @"image", @"2010-01-01", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"01530", @"id", @"案山子とコスモス", @"title", @"白川郷", @"location", @"1img_9973.jpg", @"image", @"2009-09-21", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"01440", @"id", @"カルタジローネの街中", @"title", @"カルタジローネ", @"location", @"1img_9579.jpg", @"image", @"2009-08-13", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"01395", @"id", @"アルベロベッロの夜景　その４", @"title", @"アルベロベッロの街中", @"location", @"1img_9093.jpg", @"image", @"2009-08-12", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"00490", @"id", @"清滝川をさらに奥まで進む", @"title", @"高雄山の錦雲峡", @"location", @"CRW_5446_JFR.jpg", @"image", @"2004-08-15", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"01369", @"id", @"海岸沿いを船で", @"title", @"アマルフィー海岸", @"location", @"1img_8859.jpg", @"image", @"2009-08-11", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"01351", @"id", @"ボートでの1周も終え", @"title", @"青の洞窟（Grotta Azzurra）", @"location", @"1img_8691.jpg", @"image", @"2009-08-10", @"date", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"00212", @"id", @"夕焼け時の黄金色の海の写真", @"title", @"かりゆしビーチ付近", @"location", @"DSC00330.jpg", @"image", @"2003-08-11", @"date", nil],
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
    return YES;
}

// デバイスを回転させたとき
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [self.tableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  76.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomViewCell *cell = (CustomViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // 中身を生成
    NSDictionary *data = [_datas objectAtIndex:indexPath.row];
    cell.titleLabel.text = [data objectForKey:@"title"];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ %@", [data objectForKey:@"id"], [data objectForKey:@"date"]];
    cell.locationLabel.text = [data objectForKey:@"location"];
    cell.imageView.image = [UIImage imageNamed:[data objectForKey:@"image"]];
    
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
    // Navigation logic may go here. Create and push another view controller.
    UIViewController *detailViewController = [[UIViewController alloc] init];
    
    // データを受け渡す
    NSDictionary *data = [_datas objectAtIndex:indexPath.row];
    detailViewController.title = [data objectForKey:@"name"];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
