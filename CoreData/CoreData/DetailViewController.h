//
//  DetailViewController.h
//  CoreData
//
//  Created by Hiroaki Komatsu on 2013/01/03.
//
//

#import <UIKit/UIKit.h>

@class Entity;

@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Entity *entity;

@end


@interface DetailViewController (Private)

- (void)commit;

@end
