//
//  RootViewController.m
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "IndicatorViewCell.h"
#import "TweetViewCell.h"
#import "DetailViewController.h"

#define CELL_HEIGHT 56.0f

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		
		// 画像キャッシュ
		imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadTimeline
{
	loaded = false;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	// 公開タイムライン取得
	NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"];
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setObject:@"20" forKey:@"count"];
	[params setObject:@"1" forKey:@"include_entities"];
	[params setObject:@"1" forKey:@"include_rts"];
	
	TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:params requestMethod:TWRequestMethodGET];
	[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
	{
		loaded = true;
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
		if (responseData) {
			NSError *jsonError;
			statuses = [[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError] retain];
			if (statuses) {
				dispatch_async(dispatch_get_main_queue(), ^{
					[self.tableView reloadData];
				});
			}
		}
	}];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// タイトル
	self.navigationItem.title = @"public_timeline";
	
	// タイムラインを読み込む
	[self loadTimeline];
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
	if (!loaded) {
		return 1;
	}
	return [statuses count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TweetViewCell *cell = (TweetViewCell*) [self tableView:tableView cellForRowAtIndexPath:indexPath];
	if ([cell isKindOfClass:[TweetViewCell class]]) {
		return [cell calculateGeometries:self.view.bounds];
	}
	return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// インジケーター読み込み
	if (!loaded) {
		static NSString *IndicatorCellIdentifier = @"IndicatorCell";
		IndicatorViewCell *indicatorCell = (IndicatorViewCell*) [tableView dequeueReusableCellWithIdentifier:IndicatorCellIdentifier];
		if (indicatorCell == nil) {
			indicatorCell = [[[IndicatorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IndicatorCellIdentifier] autorelease];
		}
		return indicatorCell;
	}
	
	// ツイート読み込み
	static NSString *CellIdentifier = @"Cell";
	TweetViewCell *cell = (TweetViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[TweetViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
    // 中身を生成
	NSDictionary *status = [statuses objectAtIndex:indexPath.row];
	NSDictionary *user = [status objectForKey:@"user"];
	cell.nameLabel.text = [user objectForKey:@"name"];
	cell.screenNameLabel.text = [[NSString alloc] initWithFormat:@"@%@", [user objectForKey:@"screen_name"]];
	cell.tweetLabel.text = [status objectForKey:@"text"];
	
	// 画像読み込み
	NSString *imageUrl = [user objectForKey:@"profile_image_url"];
	UIImage *image = [imageCache objectForKey:imageUrl];
	if (image) {
		cell.imageView.image = image;
	} else {
		cell.imageView.image = nil;
		
		dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		dispatch_async(q_global, ^{
			UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
			[imageCache setObject:image forKey:imageUrl];
			dispatch_async(dispatch_get_main_queue(), ^{            
				cell.imageView.image = image;
				[cell layoutSubviews];
			});
		});
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
    // Navigation logic may go here. Create and push another view controller.
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
	
	// データを受け渡す
	NSDictionary *data = [statuses objectAtIndex:indexPath.row];
	detailViewController.data = data;
	
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

@end
