//
//  DetailViewController.m
//  SimpleARC
//
//  Created by Hiroaki Komatsu on 2013/01/09.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.frame = CGRectMake(10, 10, (self.view.bounds.size.width-20), 25);
        [self.view addSubview:self.textLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
