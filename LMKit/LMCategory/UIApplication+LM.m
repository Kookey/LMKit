//
//  UIApplication+LM.m
//  LMKit
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIApplication+LM.h"
#import "LMKit.h"

#define kLMFirstOpenedApp @"LMFirstOpenedApp"
#define kLMFirstOpenedBuild @"LMFirstOpenedBuild"
#define kLMFirstOpenedVersion @"LMFirstOpenedVersion"

@implementation UIApplication (LM)

#pragma mark 是否首次打开这个应用

+ (void)lm_firstOpenedApp:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:kLMFirstOpenedApp flag:block];
}

#pragma mark 是否首次打开这个build

+ (void)lm_firstOpenedBuild:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:[kLMFirstOpenedBuild stringByAppendingString:LMAppBuild] flag:block];
}

#pragma mark 是否首次打开这个Version

+ (void)lm_firstOpenedVersion:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:[kLMFirstOpenedVersion stringByAppendingString:LMAppVersion] flag:block];
}

#pragma mark 是否首次打开

+ (void)lm_firstOpenedKey:(NSString *)key flag:(void (^)(BOOL isFirstOpened))block
{
    BOOL firstOpened = LMGetUserDefaults(key).boolValue;
    
    if(!firstOpened) {
        
        LMSaveUserDefaults(@"1", key);
    }
    
    block(!firstOpened);
}

@end
