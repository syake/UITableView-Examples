//
//  RootViewController.h
//  Search
//
//  Created by Hiroaki Komatsu on 12/09/24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UISearchDisplayDelegate>
{
    NSArray* _datas;
    NSMutableArray* _filteredListContent;
}

@end
