//
//  ModuleVC.h
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowserViewController.h"
@import MediaPlayer;

@interface ModuleVC : UIViewController<UIWebViewDelegate>
@property NSDictionary *moduleInfo;
#define AFN_PAGE_SEGUE @"Homepage Segue"
@end
