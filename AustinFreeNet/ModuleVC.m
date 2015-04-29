//
//  ModuleVC.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "ModuleVC.h"

@interface ModuleVC()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ModuleVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// navigation controller
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
	self.navigationItem.leftBarButtonItem = backButton;
	
	UIBarButtonItem *AFNButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_logo"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickAFNButton)];
	[self.navigationItem setRightBarButtonItem:AFNButton];
	
	// get data
	self.webView.delegate = self;
	self.title = self.moduleInfo[@"name"];
	NSURL *fileURL = [NSURL URLWithString:self.moduleInfo[@"data"]];
	[self.spinner startAnimating];
	if([self.moduleInfo[@"type"] isEqualToString:@"YouTube"]) {
		[self embedVideo:fileURL];
	} else if ([self.moduleInfo[@"type"] isEqualToString:@"PDF"]) {
		[self embedPDF:fileURL];
	} else {
		[self embedWebsite:fileURL];
	}
}

- (void)embedVideo:(NSURL *)url
{
	NSString* embedHTML = @"\
	<html><head>\
 <style type=\"text/css\">\
 body {\
	 background-color: transparent;\
 color: white;\
 }\
 </style>\
 </head><body style=\"margin:0\">\
	<embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
 width=\"%0.0f\" height=\"%0.0f\"></embed>\
	</body></html>";
	 NSString* html = [NSString stringWithFormat:embedHTML, url, self.webView.frame.size.width, self.webView.frame.size.height];

	 [self.webView loadHTMLString:html baseURL:nil];
}

- (void)embedPDF:(NSURL *)url
{
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
	NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
		if (!error) {
			if ([request.URL isEqual:url]) {
				NSData *data = [NSData dataWithContentsOfURL:location];
				dispatch_async(dispatch_get_main_queue(), ^{
					[self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
				});
				
			}
		}
	}];
	[task resume];
//	[self.webView loadRequest:request];
}

- (void)embedWebsite:(NSURL *)url
{
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:request];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

#pragma mark - UIWebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self.spinner stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self.spinner startAnimating];
}

#pragma mark - Navigation

- (void)goBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickAFNButton
{
	[self performSegueWithIdentifier:AFN_PAGE_SEGUE sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:AFN_PAGE_SEGUE]) {
		BrowserViewController *browserVC = (BrowserViewController *)segue.destinationViewController;
		browserVC.url = AFN_URL;
	}
}

@end
