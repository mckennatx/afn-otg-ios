//
//  BrowserViewController.h
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/20/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import <UIKit/UIKit.h>
@import WebKit;

@interface BrowserViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) NSURL *url;
@end
