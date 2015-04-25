//
//  MainVC.m
//  AustinFreeNet
//
//  Created by Lauren McKenna on 4/13/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (strong, nonatomic) UIAlertController *alertController;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	for (UIButton *button in self.buttons) {
		button.layer.cornerRadius = 10.0;
		[button.layer setMasksToBounds:YES];
		
		[button centerVerticallyWithPadding:30.0f];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressVolunteerButton:(UIButton *)sender {
	[self presentViewController:self.alertController animated:YES completion:nil];
}

- (UIAlertController *)alertController
{
	if (!_alertController) {
		_alertController = [UIAlertController alertControllerWithTitle:@"Volunteer" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
		UIAlertAction *signInAction = [UIAlertAction actionWithTitle:@"Sign In" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			[self performSegueWithIdentifier:SIGN_IN_SEGUE sender:self];
		}];
		
		UIAlertAction *signUpAction = [UIAlertAction actionWithTitle:@"Sign Up" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			[self performSegueWithIdentifier:SIGN_UP_SEGUE sender:self];
		}];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
			
		}];
		[_alertController addAction:signInAction];
		[_alertController addAction:signUpAction];
		[_alertController addAction:cancelAction];
	}
	return _alertController;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	self.navigationController.navigationBarHidden = NO;
	if ([segue.identifier isEqualToString:SIGN_IN_SEGUE]) {
		BrowserViewController *browserVC = (BrowserViewController *)segue.destinationViewController;
		browserVC.url = [NSURL URLWithString:VOLUNTEER_SIGN_IN];
	} else if ([segue.identifier isEqualToString:SIGN_UP_SEGUE]) {
		BrowserViewController *browserVC = (BrowserViewController *)segue.destinationViewController;
		browserVC.url = [NSURL URLWithString:VOLUNTEER_SIGN_UP];
	}
}


@end
