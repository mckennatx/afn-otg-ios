//
//  DonateViewController.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/19/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@end

@implementation DonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// navigation controller
	self.title = @"Donate";
	UIBarButtonItem *AFNButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_logo"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickAFNButton)];
	[self.navigationItem setRightBarButtonItem:AFNButton];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
	self.navigationItem.leftBarButtonItem = backButton;
	
	// donate button
	[self.donateButton.imageView setBackgroundColor:UIColorFromRGB(0x3e96c7)];
	[self.donateButton.imageView setImage:[UIImage imageNamed:@"l2_banner_donate"]];
	[self.donateButton formatWithDetailAccessory];
	[self.donateButton addTopBorderWithColor:UIColorFromRGB(0xc7c7cc)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickAFNButton
{
	[self performSegueWithIdentifier:HOMEPAGE_SEGUE sender:self];
}

- (IBAction)didPressDonateButton:(UIButton *)sender {
	UIApplication *mySafari = [UIApplication sharedApplication];
	NSURL *url = [NSURL URLWithString:DONATE_URL];
	[mySafari openURL:url];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	if ([segue.destinationViewController isKindOfClass:[BrowserViewController class]]) {
		BrowserViewController *browserVC = (BrowserViewController *)segue.destinationViewController;
		if ([segue.identifier isEqualToString:HOMEPAGE_SEGUE]) {
			browserVC.url = [NSURL URLWithString:HOMEPAGE_URL];
		}
	}
}

- (void)goBack
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
