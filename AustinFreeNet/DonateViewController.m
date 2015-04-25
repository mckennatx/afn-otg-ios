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
	self.navigationController.title = @"Donate";
    // Do any additional setup after loading the view.
	[self.donateButton.imageView setBackgroundColor:UIColorFromRGB(0x3e96c7)];
	[self.donateButton.imageView setImage:[UIImage imageNamed:@"l2_banner_donate"]];
	[self.donateButton formatWithDetailAccessory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
