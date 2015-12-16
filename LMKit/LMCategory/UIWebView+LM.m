//
//  UIWebView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/8/10.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIWebView+LM.h"
#import "NSString+LM.h"

@implementation UIWebView (LM)

- (void)lm_loadRequestURL:(NSString *)URLString
{
#if DEBUG
    NSLog(@"\n---------------------loadRequestURL--------------------\n%@\n---------------------loadRequestURL--------------------", URLString);
#endif
    [self loadRequest:[NSURLRequest requestWithURL:[URLString lm_urlEncode]]];
}

- (void)lm_loadLocalHtml:(NSString *)htmlName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

+ (void)lm_clearCookies
{
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSHTTPCookie *cookie in storage.cookies) {
        
        [storage deleteCookie:cookie];
    }
    
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
