//
//  UIButton+DetailAccessory.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/24/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "UIButton+DetailAccessory.h"

@implementation UIButton (DetailAccessory)
- (void)formatWithDetailAccessory
{
	// align on the left
	self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	
	// space between image and title
	[self setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	
	// add detail accessory
	UIImageView *detailAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"l2_caret"]];
	detailAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	CGRect frame = detailAccessoryView.frame;
	frame.origin.x = self.frame.size.width - 20;
	frame.origin.y = self.frame.size.height / 2.0 - 6;
	detailAccessoryView.frame = frame;
	[self addSubview:detailAccessoryView];
}
@end
