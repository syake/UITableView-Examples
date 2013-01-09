//
//  RootViewController.m
//  DeckMenu
//
//  Created by Hiroaki Komatsu on 2013/01/05.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIViewController *viewController1;
@property (nonatomic, strong) UIViewController *viewController2;
@property (nonatomic, strong) UIViewController *viewController3;

@end

@implementation RootViewController

@synthesize isOpen = _isOpen;
@synthesize leftBarButtonItem = _leftBarButtonItem;
@synthesize viewController1 = _viewController1;
@synthesize viewController2 = _viewController2;
@synthesize viewController3 = _viewController3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // menu table view
    MenuViewController *menuTableViewController = [[MenuViewController alloc] init];
    menuTableViewController.delegate = self;
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50, self.view.frame.size.height)];
    [menuTableViewController.view setFrame:dummyView.frame];
    
    [self addChildViewController:menuTableViewController];
    [menuTableViewController didMoveToParentViewController:self];
    [self.view addSubview:menuTableViewController.view];
    
    // navigationController
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    [self addChildViewController:navigationController];
    [navigationController didMoveToParentViewController:self];
    [self.view addSubview:navigationController.view];
    
    // shadow
    UIBezierPath* newShadowPath = [UIBezierPath bezierPathWithRect:navigationController.view.bounds];
    navigationController.view.layer.masksToBounds = NO;
    navigationController.view.layer.shadowRadius = 10;
    navigationController.view.layer.shadowOpacity = 0.5;
    navigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    navigationController.view.layer.shadowOffset = CGSizeZero;
    navigationController.view.layer.shadowPath = [newShadowPath CGPath];
    
    // create viewController1
    self.viewController1 = [[UIViewController alloc] init];
    self.viewController1.view.backgroundColor = [UIColor whiteColor];
    self.viewController1.navigationItem.title = @"その１";
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.view.bounds.size.width - 20), 25)];
    titleLabel1.text = @"その１";
    [self.viewController1.view addSubview:titleLabel1];
    
    // create viewController2
    self.viewController2 = [[UIViewController alloc] init];
    self.viewController2.view.backgroundColor = [UIColor whiteColor];
    self.viewController2.navigationItem.title = @"その２";
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.view.bounds.size.width - 20), 25)];
    titleLabel2.text = @"その２";
    [self.viewController2.view addSubview:titleLabel2];
    
    // create viewController3
    self.viewController3 = [[UIViewController alloc] init];
    self.viewController3.view.backgroundColor = [UIColor whiteColor];
    self.viewController3.navigationItem.title = @"その３";
    UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.view.bounds.size.width - 20), 25)];
    titleLabel3.text = @"その３";
    [self.viewController3.view addSubview:titleLabel3];
    
    // first view
    [self setFirstViewController:self.viewController1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - firstViewController

-(void)setFirstViewController:(UIViewController *)viewController
{
    if (self.leftBarButtonItem == nil) {
        self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list"] style:UIBarButtonItemStylePlain target:self action:@selector(slide:)];
    }
    
    [viewController.navigationItem setLeftBarButtonItem:self.leftBarButtonItem];
    UINavigationController *navigationController = [self.childViewControllers lastObject];
    [navigationController setViewControllers:[NSArray arrayWithObjects:viewController, nil]];
}

-(void)removeFirstViewController
{
    UINavigationController *navigationController = [self.childViewControllers lastObject];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:navigationController.viewControllers];
    [viewControllers removeAllObjects];
    navigationController.viewControllers = viewControllers;
}

#pragma mark - action operations

-(void)slide:(id)sender
{
    _isOpen = !_isOpen;
    
    UINavigationController *firstNavigationController = [self.childViewControllers objectAtIndex:1];
    UIView *firstView = firstNavigationController.view;
    CGRect offset = firstView.frame;
    offset.origin.x = _isOpen ? offset.size.width - 80 : 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        firstView.frame = offset;
    } completion:^(BOOL finished){
        
    }];
}

- (void)switchView:(UIViewController *)viewController
{
    [self removeFirstViewController];
    [self setFirstViewController:viewController];
    [self slide:nil];
}

#pragma mark - MenuViewController delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case ContentType_1:
            [self switchView:self.viewController1];
            break;
        case ContentType_2:
            [self switchView:self.viewController2];
            break;
        case ContentType_3:
            [self switchView:self.viewController3];
            break;
            
        default:
            break;
    }
}

@end
