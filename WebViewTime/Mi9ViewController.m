//
//  Mi9ViewController.m
//  WebViewTime
//
//  Created by Daphne Chong on 28/08/13.
//  Copyright (c) 2013 Daphne Chong. All rights reserved.
//

#import "Mi9ViewController.h"

@interface Mi9ViewController ()

@end

@implementation Mi9ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://ios-codeschool.bilue.com.au/samples/v2/camera-button.html"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    //self.webView.scalesPageToFit = YES;
 
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.URL.scheme isEqualToString: @"native"]) {
        if ([request.URL.host isEqualToString:@"displayCamera"]) {
            UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        return NO;
    }
    
    return YES;
}

@end
