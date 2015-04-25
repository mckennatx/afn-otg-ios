//
//  UIButton+TopBorder.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/24/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "UIButton+TopBorder.h"

@implementation UIButton (TopBorder)
- (void)addTopBorderWithColor:(UIColor *)color
{
	UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
	borderView.backgroundColor = color;
	[self addSubview:borderView];
}
@end
