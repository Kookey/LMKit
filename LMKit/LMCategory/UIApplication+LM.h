//
//  UIApplication+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LM)

/**
 *  是否首次打开这个应用
 *
 *  @param block 是/不是
 */
+ (void)lm_firstOpenedApp:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开这个build
 *
 *  @param block 是/不是
 */
+ (void)lm_firstOpenedBuild:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开这个Version
 *
 *  @param block 是/不是
 */
+ (void)lm_firstOpenedVersion:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开
 *
 *  @param key   key
 *  @param block 是/不是
 */
+ (void)lm_firstOpenedKey:(NSString *)key flag:(void (^)(BOOL isFirstOpened))block;
@end
