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
@property (strong, nonatomic) UIBarButtonItem *forwardButton;
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
	if ([self.url isEqual:AFN_URL]) {
		UIBarButtonItem *AFNItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_logo"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHomepage)];
		self.navigationItem.rightBarButtonItems = @[shareItem, AFNItem];
	} else {
		self.navigationItem.rightBarButtonItem = shareItem;
	}
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
	self.navigationItem.leftBarButtonItems = @[backButton, self.forwardButton];
}

- (UIBarButtonItem *)forwardButton
{
	if (!_forwardButton) {
		_forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_forward"] style:UIBarButtonItemStylePlain target:self.webView action:@selector(goForward)];
		_forwardButton.enabled = NO;
	}
	return _forwardButton;
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

- (void)backToHomepage
{
	NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
	[self.webView loadRequest:request];
}

- (void)shareURL
{
	NSURL *url = self.webView.request.URL;
	if (url) {
		UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
		[self presentViewController:activityController animated:YES completion:nil];
	}
}

- (void)back
{
	if ([self.webView canGoBack]) {
		[self.webView goBack];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self.spinner stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	self.forwardButton.enabled = [self.webView canGoForward];
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
