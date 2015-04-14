//
//  MapVC.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "MapVC.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation MapVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:30.269932
													longitude:-97.715876
														 zoom:12];
	
	GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
	
	GMSMarker *marker = [[GMSMarker alloc] init];
	marker.position = camera.target;
	marker.snippet = @"AFN Headquarters";
	marker.appearAnimation = kGMSMarkerAnimationPop;
	marker.map = mapView;

	self.view = mapView;
}

@end
