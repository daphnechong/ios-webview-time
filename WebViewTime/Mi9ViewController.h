//
//  Mi9ViewController.h
//  WebViewTime
//
//  Created by Daphne Chong on 28/08/13.
//  Copyright (c) 2013 Daphne Chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mi9ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic) IBOutlet UIWebView *webView;

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end
