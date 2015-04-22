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
    // Do any additional setup after loading the view.
	[self.view addSubview:self.webView];
	[self.view addSubview:self.spinner];
	[self makeRequest];
}

- (void)makeRequest
{
	NSURL *url = [NSURL URLWithString:@"http://form.jotform.us/form/50925791023151"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
//	UIWebView *webView = (UIWebView *)self.view;
	[self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
