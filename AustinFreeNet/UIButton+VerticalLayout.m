//
//  UIButton+VerticalLayout.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/21/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "UIButton+VerticalLayout.h"

@implementation UIButton (VerticalLayout)
- (void)centerVerticallyWithPadding:(float)padding
{
	CGSize imageSize = self.imageView.frame.size;
	CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
 
	CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
	
	NSLog(@"Total height %f button height %f", totalHeight, self.bounds.size.height);
	
	self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
											0.0f,
											0.0f,
											- titleSize.width);
 
	self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
											- imageSize.width,
											- (self.bounds.size.height - 11.0f - titleSize.height),
											0.0f);
}


- (void)centerVertically
{
	const CGFloat kDefaultPadding = 6.0f;
	
	[self centerVerticallyWithPadding:kDefaultPadding];
}
@end
