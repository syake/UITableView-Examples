//
//  IndicatorViewCell.m
//  Twitter
//
//  Created by Hiroaki Komatsu on 12/09/13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndicatorViewCell.h"

@implementation IndicatorViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Custom initialization
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
		spinner.contentMode = UIViewContentModeCenter;
		[self addSubview: spinner];
		[spinner startAnimating];
	}
	return self;
}

- (void)dealloc
{
	[spinner removeFromSuperview];
	[spinner release], spinner = nil;
	
	[super dealloc];
}

#pragma mark - View lifecycle

- (void)drawRect:(CGRect)rect
{
	CGSize size = self.bounds.size;
	spinner.frame = CGRectMake(0, 0, size.width, size.height);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
