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
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *questionButton;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (nonatomic) CGRect containerFrame;
@end

@implementation MapVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// navigation controller
	self.navigationController.title = @"Connect";
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
	self.navigationItem.leftBarButtonItem = backButton;
	
	// question button
	[self.questionButton formatWithDetailAccessory];
	[self.questionButton addTopBorderWithColor:UIColorFromRGB(0xc7c7cc)];
	[self.questionButton.imageView setBackgroundColor:UIColorFromRGB(0x3e96c7)];
	
	// container view
	_containerFrame = CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
	
	// map view
	self.mapView.myLocationEnabled = YES;
	self.mapView.delegate = self;
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingLocation];
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:30.269932													longitude:-97.715876
														 zoom:12];
	
	self.mapView.camera = camera;
	
	NSArray *locs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AFN Locations" ofType:@"plist"]];
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
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveStartSearchNotification:) name:@"Start Search" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(receiveFinishedSearchNotification:) name:@"Finish Search" object:nil];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)openActionSheet
{
	[self.actionSheet showInView:self.view];
}

- (UIActionSheet *)actionSheet
{
	if (!_actionSheet) {
		_actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open in Maps" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
	}
	return _actionSheet;
}

- (void)receiveStartSearchNotification:(NSNotification *)notification
{
	CGRect newFrame = CGRectMake(0.0, self.mapView.frame.origin.y, self.view.frame.size.width, self.questionButton.frame.origin.y);
	[UIView animateWithDuration:0.3 animations:^{
		[self.mapView setHidden:YES];
		[self.containerView setFrame:newFrame];
	}];
}

- (void)receiveFinishedSearchNotification:(NSNotification *)notification
{
	[UIView animateWithDuration:0.3 animations:^{
		[self.mapView setHidden:NO];
		[self.containerView setFrame:self.containerFrame];
	}];
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
			[[UIApplication sharedApplication] openURL:url];
		}
	}
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
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

#pragma mark - Navigation
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.destinationViewController isKindOfClass:[BrowserViewController class]]) {
		BrowserViewController *browserVC = (BrowserViewController *)segue.destinationViewController;
		NSURL *questionUrl = [NSURL URLWithString:@"http://form.jotform.us/form/50925791023151"];
		browserVC.url = questionUrl;
	}
}

- (void)goBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
