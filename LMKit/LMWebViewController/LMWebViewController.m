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

@end

@implementation LMWebViewController

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

+ (instancetype)webViewControllerLoadRequestsURL:(NSString *)URLString {
    
    return [[self alloc] initWithRequestsURL:URLString];
}

+ (instancetype)webViewControllerLoadLocalHtml:(NSString *)htmlName {
    
    return [[self alloc] initWithRequestsURL:htmlName];
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.lm_showHtmlTitle) {
        
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
