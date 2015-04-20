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
@property (strong, nonatomic) UIActionSheet *actionSheet;
@end

@implementation MapVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationController.title = @"Connect";
	
	self.mapView.myLocationEnabled = YES;
	self.mapView.delegate = self;
	self.mapView.settings.myLocationButton = YES;
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingLocation];
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:30.269932													longitude:-97.715876
														 zoom:12];
	
	self.mapView.camera = camera;
	
	NSArray *locs = [MapVC AFNLocations];
	for (NSDictionary *dict in locs) {
		GMSMarker *m = [[GMSMarker alloc] init];
		m.position = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
		m.title = dict[@"name"];
		m.snippet = dict[@"snippet"];
		m.appearAnimation = kGMSMarkerAnimationPop;
		m.tappable = YES;
		m.infoWindowAnchor = CGPointMake(0.50f, 0.55);
		m.userData = dict[@"address"];
		m.map = self.mapView;
	}
}

- (void)openActionSheet
{
	[self.actionSheet showInView:self.view];
}

- (UIActionSheet *)actionSheet
{
	if (!_actionSheet) {
		_actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open in Maps" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
	}
	return _actionSheet;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	GMSMarker *marker = self.mapView.selectedMarker;
	if (buttonIndex == 0) {
		// Apple Maps
		MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:marker.position addressDictionary:nil];
		MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
		item.name = marker.title;
		[item openInMapsWithLaunchOptions:nil];
	} else {
		// Google Maps
		if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
			NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?q=%@&ll=%f,%f&zoom=14", marker.userData, marker.position.latitude, marker.position.longitude]];
			NSLog(@"%@", url);
			[[UIApplication sharedApplication] openURL:url];
		}
	}
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"yo");
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:12.0];
	[self.mapView animateToCameraPosition:camera];
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

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
	[self openActionSheet];
}

+ (NSArray *)AFNLocations
{
	return @[
			 @{@"name": @"AFN Rosewood", @"latitude":[NSNumber numberWithDouble:30.269932], @"longitude":[NSNumber numberWithDouble:-97.715876], @"address":@"DeWitty+Job+Training+and+Employment+Center"},
			 @{@"name":@"ARCH", @"snippet":@"Austin Resource Center for the Homeless", @"latitude":[NSNumber numberWithDouble:30.26787], @"longitude":[NSNumber numberWithDouble:-97.737584], @"address":@"Austin+Resource+Center+for+the+Homeless"},
			 @{@"name":@"Blackland Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.280945], @"longitude":[NSNumber numberWithDouble:-97.722188], @"address":@"Blackland+Neighborhood+Center"},
			 @{@"name":@"Conley-Guerrero Senior Activity Center", @"latitude":[NSNumber numberWithDouble:30.265868], @"longitude":[NSNumber numberWithDouble:-97.710984], @"address":@"Conley-Guerrero+Senior+Activity+Center"},
			 @{@"name":@"Rosewood-Zaragosa Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.265391], @"longitude":[NSNumber numberWithDouble:-97.710594], @"address":@"Rosewood-Zaragosa+Neighborhood+Center"},
			 @{@"name":@"South Austin Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.239574], @"longitude":[NSNumber numberWithDouble:-97.760286], @"address":@"South+Austin+Neighborhood+Center"},
			 @{@"name":@"St. John's Neighborhood Center", @"latitude":[NSNumber numberWithDouble:30.3328231], @"longitude":[NSNumber numberWithDouble:-97.6937014], @"address":@"St+Johns+Community+Center+WIC"},
			 @{@"name":@"Trinity  Center", @"latitude":[NSNumber numberWithDouble:30.2685762], @"longitude":[NSNumber numberWithDouble:-97.7397648], @"address":@"304+E+7th+Street+78701"}];
}

@end
