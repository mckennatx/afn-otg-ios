//
//  MapVC.h
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapVC : UIViewController<CLLocationManagerDelegate>
+(NSArray *)AFNLocations;

@end
