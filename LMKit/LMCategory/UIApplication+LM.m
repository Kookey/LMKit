//
//  UIApplication+LM.m
//  LMKit
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIApplication+LM.h"
#import "LMKit.h"

#define kLMFirstOpened @"LMFirstOpened"

@implementation UIApplication (LM)

#pragma mark 是否首次打开应用

+ (void)lm_firstOpenedApp:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:kLMFirstOpened flag:block];
}

#pragma mark 是否首次打开某个页面

+ (void)lm_firstOpenedKey:(NSString *)key flag:(void (^)(BOOL isFirstOpened))block
{
    BOOL firstOpened = LMGetUserDefaults(key).boolValue;
    if(!firstOpened) {
        LMSaveUserDefaults(@"1", key);
    }
    
    block(!firstOpened);
}

@end
