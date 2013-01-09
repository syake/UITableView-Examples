//
//  MenuViewController.m
//  DeckMenu
//
//  Created by Hiroaki Komatsu on 2013/01/05.
//  Copyright (c) 2013年 Hiroaki Komatsu. All rights reserved.
//

#import "MenuViewController.h"


@interface SectionView : UIView

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SectionView

@synthesize textLabel = _textLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, frame.size.width - 10, frame.size.height)];
        self.textLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 塗り
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.129 green:0.149 blue:0.149 alpha:1.0].CGColor);
    CGContextFillRect(context, rect);
    
    // 上の線
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextStrokePath(context);
    
    // 下の線
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);
}

@end


@interface MenuViewCell : UITableViewCell

@end

@implementation MenuViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        self.textLabel.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 塗り
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.196 green:0.224 blue:0.227 alpha:1.0].CGColor);
    CGContextFillRect(context, rect);
    
    // 上の線
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextStrokePath(context);
    
    // 下の線
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);
}

@end


@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.192 blue:0.192 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配列リテラル
    NSDictionary *dc1 = @{@"label": @"その１", @"tag": [NSNumber numberWithInt:ContentType_1]};
    NSDictionary *dc2 = @{@"label": @"その２", @"tag": [NSNumber numberWithInt:ContentType_2]};
    NSDictionary *dc3 = @{@"label": @"その３", @"tag": [NSNumber numberWithInt:ContentType_3]};
    _datas = @[@[dc1, dc2], @[dc3]];
    _titles = @[@"", @"section"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_datas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_datas objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MenuViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // ハイライト色を変更
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:0.110 green:0.455 blue:0.922 alpha:1.0];
        cell.selectedBackgroundView = backgroundView;
    }
    
    NSDictionary *dc = [self dictionaryForRowAtIndexPath:indexPath];
    if (dc != nil) {
        cell.textLabel.text = [dc objectForKey:@"label"];
        cell.tag = [[dc objectForKey:@"tag"] intValue];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *CellIdentifier = @"header";
    
    SectionView *cell = (id)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, tableView.sectionFooterHeight)];
    }
    
    NSString *title = ([_titles count] > section) ? [_titles objectAtIndex:section] : @"";
    if (![title isEqualToString:@""]) {
        cell.textLabel.text = title;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *title = ([_titles count] > section) ? [_titles objectAtIndex:section] : @"";
    if (![title isEqualToString:@""]) {
        return tableView.sectionHeaderHeight;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - getter

- (NSDictionary *)dictionaryForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_datas count] > indexPath.section) {
        NSArray *arr = (NSArray *) [_datas objectAtIndex:indexPath.section];
        if ([arr count] > indexPath.row) {
            return (NSDictionary *) [arr objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

@end
