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
 *  自定义对象归档
 *
 *  @param file 文件名
 *  @param key  key
 *  @param AESkey AES密钥(加密、解密密钥必须一致)
 *
 *  @return 是否成功
 */
- (BOOL)lm_archiverDataWriteToFile:(NSString *)file forKey:(NSString *)key AESKey:(NSString *)AESkey;

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
 *  自定义对象解档
 *
 *  @param file 文件名
 *  @param key  key
 *  @param AESkey AES密钥(加密、解密密钥必须一致)
 *
 *  @return 自定义对象
 */
+ (id)lm_unarchiverFile:(NSString *)file decodeObjectForKey:(NSString *)key AESKey:(NSString *)AESkey;

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

/**
 *  对象转为字典
 *
 *  @return NSDictionary(空值忽略)
 */
- (NSDictionary *)lm_dictionaryProperty;

/**
 *  计算需要耗费的时间(秒)
 *
 *  @param block  方法
 *  @param prefix 方法标识
 */
- (NSTimeInterval)lm_logTimeToRunBlock:(void (^)(void))block withPrefix:(NSString *)prefix;

@end
