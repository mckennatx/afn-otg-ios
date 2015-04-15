//
//  ModuleVC.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/14/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "ModuleVC.h"

@interface ModuleVC()
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@end

@implementation ModuleVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = self.moduleInfo[@"name"];
	if([self.moduleInfo[@"type"] isEqualToString:@"YouTube"]) {
		[self embedVideo];
	}
}

- (void)embedVideo
{
	NSURL *fileURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=9bZkp7q19f0"];
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
	 NSString* html = [NSString stringWithFormat:embedHTML, fileURL, self.videoView.frame.size.width, self.videoView.frame.size.height];

	 [self.videoView loadHTMLString:html baseURL:nil];
}

@end
