//
//  MyData.m
//  Simple
//
//  Created by Hiroaki Komatsu on 12/09/11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyData.h"

@implementation MyData

@synthesize identifier = _identifier;
@synthesize title = _title;

- (id)init
{
    // 初期化メソッド
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // 識別子を作成する
    CFUUIDRef uuid;
    uuid = CFUUIDCreate(NULL);
    _identifier = (NSString*)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return self;
}

@end
