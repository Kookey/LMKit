//
//  LMWebViewController.h
//  LMWebViewController
//
//  Created by 李蒙 on 15/8/11.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMWebViewController : UIViewController

@property (strong, nonatomic) UIWebView *lm_webView;

@property (assign, nonatomic) BOOL lm_showHtmlTitle;

@property (assign, nonatomic) BOOL lm_showGoBack;

@property (strong, nonatomic) UIColor *lm_progressBarTintColor;

+ (instancetype)webViewControllerLoadRequestsURL:(NSString *)URLString;

+ (instancetype)webViewControllerLoadLocalHtml:(NSString *)htmlName;

@end
