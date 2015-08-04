//
//  NSObject+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/18.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSObject+LM.h"
#import "LMKit.h"
#import <objc/runtime.h>

@implementation NSObject (LM)

#pragma mark 自定义对象归档

- (BOOL)lm_archiverDataWriteToFile:(NSString *)file forKey:(NSString *)key
{
    return [self lm_archiverDataWriteToFile:file forKey:key AESKey:nil];
}

- (BOOL)lm_archiverDataWriteToFile:(NSString *)file forKey:(NSString *)key AESKey:(NSString *)AESkey
{
    NSMutableData *data = [NSMutableData new];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self forKey:key];
    
    [archiver finishEncoding];
    
    return [AESkey.length ? [data lm_AES256EncryptWithKey:AESkey] : data writeToFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:file] atomically:YES];
}

#pragma mark 自定义对象解档

+ (id)lm_unarchiverFile:(NSString *)file decodeObjectForKey:(NSString *)key
{
    return [self lm_unarchiverFile:file decodeObjectForKey:key AESKey:nil];
}

+ (id)lm_unarchiverFile:(NSString *)file decodeObjectForKey:(NSString *)key AESKey:(NSString *)AESkey
{
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:file]];
    
    if (!data) {
        
        return nil;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:AESkey.length ? [data lm_AES256DecryptWithKey:AESkey] : data];
    
    id archivingData = [unarchiver decodeObjectForKey:key];
    
    [unarchiver finishDecoding];
    
    return archivingData;
}

#pragma mark - 延时执行

- (void)lm_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    if (!block) {
        
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)lm_performBlock:(void (^)(id arg))block withObject:(id)object afterDelay:(NSTimeInterval)delay
{
    if (!block) {
        
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        block(object);
    });
}

#pragma mark - 对象转为字典

- (NSDictionary *)lm_dictionaryProperty
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc] initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        
        if (propValue){
            
            [dict setObject:propValue forKey:propName];
        }
    }
    
    free(props);
    
    return dict;
}

#pragma mark 计算需要耗费的时间(秒)

- (NSTimeInterval)lm_logTimeToRunBlock:(void (^)(void))block withPrefix:(NSString *)prefix
{
    NSTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    
    if (block) {
        
        block();
    }
    
    NSTimeInterval elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
    
#if DEBUG
    if (prefix.length) {
        NSLog(@"%@->%f", prefix, elapsedTime);
    } else {
        NSLog(@"elapsedTime->%f", elapsedTime);
    }
#endif
    return elapsedTime;
    
}

@end
