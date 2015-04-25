//
//  BrowserViewController.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/20/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view addSubview:self.webView];
	[self.view addSubview:self.spinner];
	self.webView.delegate = self;
	[self makeRequest];
	
	// navigation controller
	UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareURL)];
	self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)makeRequest
{
	NSURLRequest *request = [NSURLRequest requestWithURL:self.url];

	[self.spinner startAnimating];
	[self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareURL
{
	NSURL *url = self.webView.request.URL;
	if (url) {
		UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
		[self presentViewController:activityController animated:YES completion:nil];
	}
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self.spinner stopAnimating];
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
