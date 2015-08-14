//
//  LMMacro.h
//  LMKitDemo
//
//  Created by 李蒙 on 15/8/14.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#ifndef LMKitDemo_LMMacro_h
#define LMKitDemo_LMMacro_h


#pragma mark - -.-

#ifndef __OPTIMIZE__

#define LMLog(format, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(format), ##__VA_ARGS__])

#else

#define LMLog(...)

#endif

#define LMScreenWidth [UIScreen mainScreen].bounds.size.width
#define LMScreenHeight [UIScreen mainScreen].bounds.size.height
#define LMScreenSize [UIScreen mainScreen].bounds.size
#define LMScreenBounds [UIScreen mainScreen].bounds

#define LMiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define LMiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define LMScreenMax (MAX(LMScreenWidth, LMScreenHeight))
#define LMScreenMin (MIN(LMScreenWidth, LMScreenHeight))

#define LMiPhone4 (LMiPhone && LMScreenMax == 480.0)
#define LMiPhone5 (LMiPhone && LMScreenMax == 568.0)
#define LMiPhone6 (LMiPhone && LMScreenMax == 667.0)
#define LMiPhone6Plus (LMiPhone && LMScreenMax == 736.0)

#define LMiOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define LMBlock_Safe_Run(block, ...) block ? block(__VA_ARGS__) : nil

#pragma mark - -.-

#define LMSingletonInterface(className) + (instancetype)shared##className;

#if __has_feature(objc_arc)
#define LMSingletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
#define LMSingletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}

#endif

@import UIKit;

static inline BOOL LMIsEmpty(id objcet) {
    
    return objcet == nil || [objcet isEqual:[NSNull null]] || ([objcet respondsToSelector:@selector(length)] && [(NSData *)objcet length] == 0) || ([objcet respondsToSelector:@selector(count)] && [(NSArray *)objcet count] == 0);
}

static inline BOOL LMIsNoEmpty(id objct) {
    
    return !LMIsEmpty(objct);
}

static inline NSString *LMStringWithObject(id object) {
    
    if (object == nil || [object isEqual:[NSNull null]]) {
        
        return @"";
        
    } else if ([object isKindOfClass:[NSString class]]) {
        
        return object;
        
    } else if ([object respondsToSelector:@selector(stringValue)]){
        
        return [object stringValue];
        
    } else {
        
        return [object description];
    }
}

#endif
