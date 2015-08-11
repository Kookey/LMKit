//
//  LMWebViewController.m
//  LMWebViewController
//
//  Created by 李蒙 on 15/8/11.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMWebViewController.h"
#import "LMKit.h"

@interface LMWebViewController () <UIWebViewDelegate>

@property(strong, nonatomic) UIProgressView *progressView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LMWebViewController

+ (instancetype)webViewControllerLoadRequestsURL:(NSString *)URLString {
    
    return [[self alloc] initWithRequestsURL:URLString];
}

+ (instancetype)webViewControllerLoadLocalHtml:(NSString *)htmlName {
    
    return [[self alloc] initWithRequestsURL:htmlName];
}

- (UIWebView *)lm_webView {
    
    if (!_lm_webView) {
        
        self.lm_webView = [[UIWebView alloc] init];
        self.lm_webView.delegate = self;
        self.lm_webView.frame  = self.view.bounds;
        [self.lm_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.lm_webView setScalesPageToFit:YES];
        
        [self.view addSubview:self.lm_webView];
    }
    
    return _lm_webView;
}

- (UIProgressView *)progressView {
    
    if (!_progressView) {
        
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        self.progressView.progressTintColor = self.lm_progressBarTintColor;
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.frame = CGRectMake(0, self.navigationController.navigationBar ? 64.0f : 0, self.view.frame.size.width, self.progressView.frame.size.height);
        [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
        
        [self.view addSubview:self.progressView];
    }
    
    return _progressView;
}

- (instancetype)initWithRequestsURL:(NSString *)URLString {
    
    if (self = [super init]) {
        
        [self.lm_webView lm_loadRequestURL:URLString];
    }
    
    return self;
}

- (instancetype)initWithLocalHtml:(NSString *)htmlName {
    
    if (self = [super init]) {
        
        [self.lm_webView lm_loadLocalHtml:htmlName];
    }
    
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.lm_progressBarTintColor) {
        
        if (self.timer && self.timer.isValid) {
            
            [self.timer invalidate];
            self.timer = nil;
        }
        
        [self.progressView removeFromSuperview];
    }
}

- (BOOL)lm_navigationShouldPopOnBackButton
{
    if (self.lm_showGoBack) {
        
        if ([self.lm_webView canGoBack]) {
            
            [self.lm_webView goBack];
            
        } else {
            
            return YES;
        }
        
        return NO;
    }
    
    return YES;
}

- (void)fire:(id)sender
{
    CGFloat increment = 0.005 / (self.progressView.progress + 0.2f);
    
    if ([self.lm_webView isLoading]) {
        
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        
        if (self.progressView.progress < 0.9) {
            
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

- (void)startProgressViewLoading
{
    [self.progressView setAlpha:1.0f];
    
    if (!self.timer) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 / 60.0f target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    }
}

- (void)stopProgressBarLoading
{
    if (self.timer && self.timer.isValid) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self.progressView setProgress:1.0f animated:YES];
    
    [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.progressView setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
        [self.progressView setProgress:0.0f animated:NO];
    }];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (self.lm_progressBarTintColor) {
        
        [self startProgressViewLoading];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.lm_showHtmlTitle) {
        
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    if (self.lm_progressBarTintColor) {
        
        [self stopProgressBarLoading];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.lm_progressBarTintColor) {
        
        [self stopProgressBarLoading];
    }
}

@end
