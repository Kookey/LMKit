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
- (void)lm_firstOpenedApp:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开这个build
 *
 *  @param block 是/不是
 */
- (void)lm_firstOpenedBuild:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开这个Version
 *
 *  @param block 是/不是
 */
- (void)lm_firstOpenedVersion:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开
 *
 *  @param key   key
 *  @param block 是/不是
 */
- (void)lm_firstOpenedKey:(NSString *)key flag:(void (^)(BOOL isFirstOpened))block;

/**
 *  请求Calendar权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)lm_requestAccessGrantedToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Contacts权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)lm_requestAccessGrantedToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Microphone权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)lm_requestAccessGrantedToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Photos权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)lm_requestAccessGrantedToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Reminders权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)lm_requestAccessGrantedToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Motion权限
 *
 *  @param accessGranted 授权成功
 */
- (void)lm_requestAccessGrantedToMotionWithSuccess:(void(^)())accessGranted;

/**
 *  请求Location权限(iOS8需要在Info.plist添加NSLocationWhenInUseUsageDescription)
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)lm_requestAccessGrantedToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

@end
