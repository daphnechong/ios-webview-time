//
//  Mi9ViewController.m
//  WebViewTime
//
//  Created by Daphne Chong on 28/08/13.
//  Copyright (c) 2013 Daphne Chong. All rights reserved.
//

#import "Mi9ViewController.h"
#import <CoreMotion/CoreMotion.h>


@interface Mi9ViewController ()
@property CMMotionManager *motionManager;
@property NSString *callback;

@end

@implementation Mi9ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scalesPageToFit = YES;
 
    self.motionManager =[[CMMotionManager alloc]init];
    [self startDeviceMotionUpdates];
    //[self startAccelerometerUpdate];

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

- (void)startAccelerometerUpdate
{
    __block float x;
    __block float y;
    __block float z;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMAccelerometerData *data, NSError *error) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     // Collecting data
                                                     x = data.acceleration.x;
                                                     y = data.acceleration.y;
                                                     z = data.acceleration.z;
                                                     
                                                     NSLog(@"%f %f %f", x, y, z);
                                                 });
                                             }
     
     ];
    
}

- (void)startDeviceMotionUpdates
{
    [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     // Collecting data
                                                     
                                                     NSLog(@"%f", motion.attitude.roll);
                                                 });
                                             }
     
     ];
    
}
@end
