//
//  MapVC.h
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
#import "BrowserViewController.h"
#import "UIButton+DetailAccessory.h"
#import "UIButton+TopBorder.h"
#import "AppDelegate.h"

@interface MapVC : UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate, UIActionSheetDelegate>
//#define QUESTION_URL @"http://form.jotform.us/form/50925791023151"
@end
