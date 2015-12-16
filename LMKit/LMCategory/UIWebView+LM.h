//
//  UIWebView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/8/10.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (LM)

/**
 *  请求URLString
 *
 *  @param URLString 网址
 */
- (void)lm_loadRequestURL:(NSString *)URLString;

/**
 *  加载本地Html
 *
 *  @param htmlName 文件名
 */
- (void)lm_loadLocalHtml:(NSString *)htmlName;

/**
 *  清除缓存
 */
+ (void)lm_clearCookies;

@end
