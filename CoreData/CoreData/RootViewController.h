//
//  RootViewController.h
//  CoreData
//
//  Created by Hiroaki Komatsu on 12/12/18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate, AddViewControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
