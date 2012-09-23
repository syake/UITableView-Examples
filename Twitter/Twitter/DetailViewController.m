//
//  DetailViewController.m
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize data = _data;
@synthesize imageView, nameLabel, screenNameLabel, tweetText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        float y = 10;
        
        // イメージ
        imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, y, 48, 48);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5.0;
        [self.view addSubview:imageView];
        
        // 名前
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        nameLabel.frame = CGRectMake(68, y, (self.view.bounds.size.width-78), 20);
        [self.view addSubview:nameLabel];
        
        // スクリーン名
        screenNameLabel = [[UILabel alloc] init];
        screenNameLabel.font = [UIFont systemFontOfSize:12];
        screenNameLabel.textColor = [UIColor grayColor];
        screenNameLabel.frame = CGRectMake(68, y + 20, (self.view.bounds.size.width-78), 20);
        [self.view addSubview:screenNameLabel];
        
        // つぶやき
        y += 48;
        tweetText = [[UITextView alloc] init];
        tweetText.font = [UIFont systemFontOfSize:14];
        tweetText.frame = CGRectMake(2, y, (self.view.bounds.size.width-4), 10);
        tweetText.dataDetectorTypes = UIDataDetectorTypeLink;
        tweetText.editable = NO;
        [self.view addSubview:tweetText];
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
    [imageView removeFromSuperview];
    [imageView release];
    [nameLabel removeFromSuperview];
    [nameLabel release];
    [screenNameLabel removeFromSuperview];
    [screenNameLabel release];
    [tweetText removeFromSuperview];
    [tweetText release];
    [super dealloc];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setData:(NSDictionary *)data
{
    _data = data;
    
    // 中身を生成
    NSDictionary *user = [_data objectForKey:@"user"];
    
    // タイトル
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"@%@", [user objectForKey:@"screen_name"]];
    
    // イメージ
    NSString *imageUrl = [user objectForKey:@"profile_image_url"];
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q_global, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
        dispatch_async(dispatch_get_main_queue(), ^{            
            imageView.image = image;
        });
    });
    
    // 名前
    nameLabel.text = [[NSString alloc] initWithFormat:@"%@", [user objectForKey:@"name"]];
    
    // スクリーン名
    screenNameLabel.text = [[NSString alloc] initWithFormat:@"@%@", [user objectForKey:@"screen_name"]];
    
    // ツイート
    tweetText.text = [[NSString alloc] initWithFormat:@"%@", [_data objectForKey:@"text"]];
    CGRect frame = tweetText.frame;
    frame.size.height = tweetText.contentSize.height;
    tweetText.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
