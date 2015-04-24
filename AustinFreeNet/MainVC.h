//
//  MainVC.h
//  AustinFreeNet
//
//  Created by Lauren McKenna on 4/13/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+VerticalLayout.h"
#import "BrowserViewController.h"

@interface MainVC : UIViewController
#define VOLUNTEER_SIGN_UP @"https://ctk.apricot.info/auth/autologin/org_id/1643/hash/ec0b5d74087f76195cdeb3a30ab1a6195a17f541"
#define VOLUNTEER_SIGN_IN @"https://ctk.apricot.info"
#define VOLUNTEER_BTN_INDEX 0
#define LEARN_BUTTON_INDEX 1
#define CONNECT_BUTTON_INDEX 2
#define DONATE_BUTTON_INDEX 3
#define SIGN_IN_SEGUE @"Sign In"
#define SIGN_UP_SEGUE @"Sign Up"
@end
