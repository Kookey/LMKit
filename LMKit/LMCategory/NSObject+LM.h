//
//  NSObject+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/18.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LM)

/**
*  自定义对象归档
*
*  @param file 文件名
*  @param key  key
*
*  @return 是否成功
*/
- (BOOL)lm_archiverDataWriteToFile:(NSString *)file forKey:(NSString *)key;

/**
 *  自定义对象解档
 *
 *  @param file 文件名
 *  @param key  key
 *
 *  @return 自定义对象
 */
+ (id)lm_unarchiverFile:(NSString *)file decodeObjectForKey:(NSString *)key;

/**
 *  延时执行
 *
 *  @param block 方法
 *  @param delay 秒
 */
- (void)lm_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

/**
 *  延时执行
 *
 *  @param block  方法
 *  @param object 参数
 *  @param delay  秒
 */
- (void)lm_performBlock:(void (^)(id arg))block withObject:(id)object afterDelay:(NSTimeInterval)delay;

@end
