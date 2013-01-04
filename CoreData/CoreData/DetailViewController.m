//
//  DetailViewController.m
//  CoreData
//
//  Created by Hiroaki Komatsu on 2013/01/03.
//
//

#import "DetailViewController.h"
#import "Entity.h"

@interface DetailViewController ()

@property (nonatomic, retain) UITextField *textField;

- (void)save:(id)sender;
- (void)updateInterface;
- (void)updateRightBarButtonItemState;
- (void)textFieldEditingChanged:(id)sender;

@end


@implementation DetailViewController

@synthesize entity = _entity;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 背景設定
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    // テキストフィールド作成
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.font = [UIFont systemFontOfSize:18.0];
    self.textField.textAlignment = UITextAlignmentLeft;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.adjustsFontSizeToFitWidth = YES;
    self.textField.textColor = [UIColor blackColor];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = NSLocalizedString(@"display name for text", @"");
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.textField];
    
    self.textField.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, 36);
    
    if ([self class] == [DetailViewController class]) {
        self.navigationItem.title = @"Text";
        
        // [Save]ボタン作成
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Redisplay the data.
    [self updateInterface];
    [self updateRightBarButtonItemState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action operations

- (void)commit
{
    [self.entity setValue:self.textField.text forKey:@"text"];
    [self.entity setValue:[NSDate date] forKey:@"pubdate"];
    if (self.entity.timestamp == nil) {
        [self.entity setValue:[NSDate date] forKey:@"timestamp"];
    }
}

- (void)save:(id)sender
{
    [self commit];
    
    NSError *error;
    if (![self.entity.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateInterface
{
    self.textField.text = self.entity.text;
}

- (void)updateRightBarButtonItemState
{
    BOOL enabled = YES;
    if ([self.textField.text length] == 0) {
        enabled = NO;
    }
    
    self.navigationItem.rightBarButtonItem.enabled = enabled;
}

#pragma mark - textfield delegate

- (void)textFieldEditingChanged:(id)sender
{
    [self updateRightBarButtonItemState];
}


@end
