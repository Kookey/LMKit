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

#pragma mark 随机Integer

- (NSInteger)lm_randomInteger:(NSInteger)fromNum to:(NSInteger)toNum
{
    return (NSInteger)(MIN(fromNum, toNum) + (arc4random() % (MAX(fromNum, toNum) - MIN(fromNum, toNum) + 1)));
}

#pragma mark 随机大写字母

- (NSString *)lm_randomEnglish:(NSUInteger)length
{
    char data[length];
    
    for (NSUInteger x = 0; x < length; data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

#pragma mark 随机汉字

- (NSString *)lm_randomChinese:(NSUInteger)length
{
    NSString *string = @"";
    
    for (NSUInteger i = 0; i < length; i++) {
        
        NSUInteger randomH = 0xA1 + arc4random() % (0xFE - 0xA1 + 1);
        NSUInteger randomL = 0xB0 + arc4random() % (0xF7 - 0xB0 + 1);
        
        NSUInteger number = (randomH << 8) + randomL;
        
        string = [string stringByAppendingString:[[NSString alloc] initWithData:[NSData dataWithBytes:&number length:2] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
    }
    
    return string;
}

#pragma mark 自定义对象归档

- (BOOL)lm_archiverDataWriteToFile:(NSString *)path forKey:(NSString *)key
{
    return [self lm_archiverDataWriteToFile:path forKey:key AESKey:nil];
}

- (BOOL)lm_archiverDataWriteToFile:(NSString *)path forKey:(NSString *)key AESKey:(NSString *)AESkey
{
    NSMutableData *data = [NSMutableData new];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self forKey:key];
    
    [archiver finishEncoding];
    
    return [AESkey.length ? [data lm_AES256EncryptWithKey:AESkey] : data writeToFile:path atomically:YES];
}

#pragma mark 自定义对象解档

+ (id)lm_unarchiverFile:(NSString *)path decodeObjectForKey:(NSString *)key
{
    return [self lm_unarchiverFile:path decodeObjectForKey:key AESKey:nil];
}

+ (id)lm_unarchiverFile:(NSString *)path decodeObjectForKey:(NSString *)key AESKey:(NSString *)AESkey
{
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    
    if (!data) {
        
        return nil;
    }
    
    @try {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:AESkey.length ? [data lm_AES256DecryptWithKey:AESkey] : data];
        
        id archivingData = [unarchiver decodeObjectForKey:key];
        
        [unarchiver finishDecoding];
        
        return archivingData;
    }
    @catch (NSException *exception) {
#if DEBUG
        NSLog(@"Exception: %@", exception);
#endif
    }
    
    return nil;
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

#pragma mark - associated

- (id)lm_getAssociatedObject:(SEL)selector
{
    return objc_getAssociatedObject(self, selector);
}

- (void)lm_setAssociated_ASSOCIATION_ASSIGN:(id)object selector:(SEL)selector
{
    objc_setAssociatedObject(self, selector, object, OBJC_ASSOCIATION_ASSIGN);
}

- (void)lm_setAssociated_ASSOCIATION_RETAIN_NONATOMIC:(id)object selector:(SEL)selector
{
    objc_setAssociatedObject(self, selector, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lm_setAssociated_ASSOCIATION_COPY_NONATOMIC:(id)object selector:(SEL)selector
{
    objc_setAssociatedObject(self, selector, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)lm_setAssociated_ASSOCIATION_RETAIN:(id)object selector:(SEL)selector
{
    objc_setAssociatedObject(self, selector, object, OBJC_ASSOCIATION_RETAIN);
}

- (void)lm_setAssociated_ASSOCIATION_COPY:(id)object selector:(SEL)selector
{
    objc_setAssociatedObject(self, selector, object, OBJC_ASSOCIATION_COPY);
}

#pragma mark - swizzle

+ (void)lm_swizzle:(SEL)original with:(SEL)replacement
{
    [self _swizzle:original with:replacement class:object_getClass([self class])];
}

- (void)lm_swizzle:(SEL)original with:(SEL)replacement
{
    [self _swizzle:original with:replacement class:[self class]];
}

- (void)_swizzle:(SEL)original with:(SEL)replacement class:(Class)class
{
    Method originalMethod = class_getInstanceMethod(class, original);
    Method replacementMethod = class_getInstanceMethod(class, replacement);
    
    if (class_addMethod(class, original, method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
        
        class_replaceMethod(class, replacement, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    } else {
        
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
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
