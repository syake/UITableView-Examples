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
              [NSDictionary dictionaryWithObjectsAndKeys:@"銅鉱", @"name", @"ore01.png", @"image", @"金属の銅を含有する鉱石。", @"description", @"10G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"鉄鉱石", @"name", @"ore02.png", @"image", @"金属の鉄を含有する鉱石。", @"description", @"900G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"亜鉛鉱", @"name", @"ore03.png", @"image", @"貴金属の亜鉛を含有する鉱石。", @"description", @"500G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"銀鉱", @"name", @"ore04.png", @"image", @"貴金属の銀を含有する鉱石。", @"description", @"1,800G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"金鉱", @"name", @"ore05.png", @"image", @"貴金属の金を含有する鉱石。", @"description", @"9,100G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"ボーキサイト", @"name", @"ore06.png", @"image", @"酸化アルミニウムを含有する鉱石。", @"description", @"4,200G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"ブロンズインゴット", @"name", @"ingot01.png", @"image", @"精錬した銅のかたまり。", @"description", @"200G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"アイアンインゴット", @"name", @"ingot02.png", @"image", @"精錬した鉄のかたまり。", @"description", @"3,600G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"ブラスインゴット", @"name", @"ingot03.png", @"image", @"精錬した黄銅のかたまり。", @"description", @"2,200G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"シルバーインゴット", @"name", @"ingot04.png", @"image", @"精錬した銀のかたまり。", @"description", @"7,500G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"ゴールドインゴット", @"name", @"ingot05.png", @"image", @"精錬した金のかたまり。", @"description", @"37,200G", @"price", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"アルミインゴット", @"name", @"ingot06.png", @"image", @"精錬したアルミニウムのかたまり。", @"description", @"21,000G", @"price", nil],
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
    return  60.0f;
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
    cell.nameLabel.text = [data objectForKey:@"name"];
    cell.descriptionLabel.text = [data objectForKey:@"description"];
    cell.priceLabel.text = [data objectForKey:@"price"];
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
