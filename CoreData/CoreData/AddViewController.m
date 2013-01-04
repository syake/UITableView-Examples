//
//  AddViewController.m
//  CoreData
//
//  Created by Hiroaki Komatsu on 2013/01/03.
//
//

#import "AddViewController.h"

@interface AddViewController ()

- (void)cancel:(id)sender;
- (void)save:(id)sender;

@end


@implementation AddViewController

@synthesize delegate = _delegate;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // タイトル
    self.navigationItem.title = @"New Text";
    
    // [Save]ボタン作成
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
    // [cancel]ボタン作成
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - action operations

- (void)cancel:(id)sender
{
    [self.delegate addViewController:self didFinishWithSave:NO];
}

- (void)save:(id)sender
{
    [self commit];
    [self.delegate addViewController:self didFinishWithSave:YES];
}

@end
