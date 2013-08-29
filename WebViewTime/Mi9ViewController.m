//
//  Mi9ViewController.m
//  WebViewTime
//
//  Created by Daphne Chong on 28/08/13.
//  Copyright (c) 2013 Daphne Chong. All rights reserved.
//

#import "Mi9ViewController.h"

@interface Mi9ViewController ()

@property NSString *callback;
@end

@implementation Mi9ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://ios-codeschool.bilue.com.au/samples/v3/native.html"];
    
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
        return [self handleNativeRequest:request.URL];
    }
    
    return YES;
}

- (BOOL) handleNativeRequest:(NSURL *)url
{
    NSString *query = [url query];
    self.callback = [query componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="]][1];

#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(url.host) withObject:url];
#   pragma clang diagnostic pop
    return NO;
}


- (IBAction) displayCamera {
    UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction) pollAccelerometer {
    
    NSString *javascript = [NSString stringWithFormat:@"window.%@(%@,%@,%@)", self.callback, @"1", @"2", @"3"];
    [self.webView stringByEvaluatingJavaScriptFromString:javascript];
}
@end
