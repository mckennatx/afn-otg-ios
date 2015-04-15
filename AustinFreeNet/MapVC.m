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
	marker.snippet = @"AFN Rosewood";
	marker.appearAnimation = kGMSMarkerAnimationPop;
	marker.map = mapView;
	
	NSArray *locs = [MapVC AFNLocations];
	for (NSDictionary *dict in locs) {
//		NSLog(@"%@",dict);
		GMSMarker *m = [[GMSMarker alloc] init];
		m.position = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
		NSLog(@"%f, %f",m.position.latitude, m.position.longitude);
		m.snippet = dict[@"name"];
		m.appearAnimation = kGMSMarkerAnimationPop;
		m.map = mapView;
	}
	
	self.view = mapView;
}

+ (NSArray *)AFNLocations
{
	return @[@{@"name":@"ARCH", @"latitude":[NSNumber numberWithDouble:30.26787], @"longitude":[NSNumber numberWithDouble:-97.737584]},@{@"name":@"Blackland Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.280945], @"longitude":[NSNumber numberWithDouble:-97.722188]},@{@"name":@"Conley-Guerrero Senior Activity Center", @"latitude":[NSNumber numberWithDouble:30.265868], @"longitude":[NSNumber numberWithDouble:-97.710984]},@{@"name":@"Rosewood Zaragosa Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.265391], @"longitude":[NSNumber numberWithDouble:-97.710594]},@{@"name":@"South Austin Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.239574], @"longitude":[NSNumber numberWithDouble:-97.760286]},@{@"name":@"St. John's Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.3328231], @"longitude":[NSNumber numberWithDouble:-97.6937014]},@{@"name":@"Trinity  Center", @"latitude":[NSNumber numberWithDouble:30.2685762], @"longitude":[NSNumber numberWithDouble:-97.7397648]}];
}

@end
