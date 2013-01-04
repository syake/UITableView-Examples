//
//  Entity.h
//  CoreData
//
//  Created by Hiroaki Komatsu on 12/12/18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * check;
@property (nonatomic, retain) NSDate * update;

@end
