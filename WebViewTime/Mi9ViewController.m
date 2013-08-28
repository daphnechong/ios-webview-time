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
    
    NSURL *url = [NSURL URLWithString:@"http://mi9.com.au/article.aspx?id=8363165"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scalesPageToFit = YES;
 
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
}

@end
