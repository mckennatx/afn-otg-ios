//
//  MapVC.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "MapVC.h"

@interface MapVC()
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation MapVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationController.title = @"Connect";
	
	self.mapView.myLocationEnabled = YES;
	self.mapView.settings.myLocationButton = YES;
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingLocation];
	
	NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
	NSLog(@"Location: %@", theLocation);
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:30.269932													longitude:-97.715876
														 zoom:12];
	
	self.mapView.camera = camera;
	
	NSArray *locs = [MapVC AFNLocations];
	for (NSDictionary *dict in locs) {
//		NSLog(@"%@",dict);
		GMSMarker *m = [[GMSMarker alloc] init];
		m.position = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
//		NSLog(@"%f, %f",m.position.latitude, m.position.longitude);
		m.snippet = dict[@"name"];
		m.appearAnimation = kGMSMarkerAnimationPop;
		m.map = self.mapView;
	}
	}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"yo");
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:12.0];
	[self.mapView animateToCameraPosition:camera];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	NSLog(@"hey");
}

- (CLLocationManager *)locationManager
{
	if (!_locationManager) {
		_locationManager = [CLLocationManager new];
		_locationManager.distanceFilter = kCLDistanceFilterNone;
		_locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	}
	return _locationManager;
}

+ (NSArray *)AFNLocations
{
	return @[@{@"name": @"AFN Rosewood", @"latitude":[NSNumber numberWithDouble:30.269932], @"longitude":[NSNumber numberWithDouble:-97.715876]},@{@"name":@"ARCH", @"latitude":[NSNumber numberWithDouble:30.26787], @"longitude":[NSNumber numberWithDouble:-97.737584]},@{@"name":@"Blackland Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.280945], @"longitude":[NSNumber numberWithDouble:-97.722188]},@{@"name":@"Conley-Guerrero Senior Activity Center", @"latitude":[NSNumber numberWithDouble:30.265868], @"longitude":[NSNumber numberWithDouble:-97.710984]},@{@"name":@"Rosewood Zaragosa Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.265391], @"longitude":[NSNumber numberWithDouble:-97.710594]},@{@"name":@"South Austin Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.239574], @"longitude":[NSNumber numberWithDouble:-97.760286]},@{@"name":@"St. John's Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.3328231], @"longitude":[NSNumber numberWithDouble:-97.6937014]},@{@"name":@"Trinity  Center", @"latitude":[NSNumber numberWithDouble:30.2685762], @"longitude":[NSNumber numberWithDouble:-97.7397648]}];
}

@end
