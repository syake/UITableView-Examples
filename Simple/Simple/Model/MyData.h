//
//  MyData.h
//  Simple
//
//  Created by Hiroaki Komatsu on 12/09/11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface MyData : NSObject
{
    NSString *_identifier;
    NSString *_title;
}

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, retain) NSString *title;

@end
