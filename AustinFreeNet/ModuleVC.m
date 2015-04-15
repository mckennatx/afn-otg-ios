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
	self.title = self.moduleInfo[@"name"];
	NSURL *fileURL = [NSURL URLWithString:self.moduleInfo[@"data"]];
	[self.spinner startAnimating];
	if([self.moduleInfo[@"type"] isEqualToString:@"YouTube"]) {
		[self embedVideo:fileURL];
	} else if ([self.moduleInfo[@"type"] isEqualToString:@"PDF"]) {
		[self embedPDF:fileURL];
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
					[self.spinner stopAnimating];
				});
				
			}
		}
	}];
	[task resume];
//	[self.webView loadRequest:request];
}

@end
