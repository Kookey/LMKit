//
//  NSArray+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LMArrayWithOrderTime(day,begin,end) [NSArray orderTimeWithDay:day beginHour:begin endHour:end]

@interface NSArray (LM)

+ (NSArray *)orderTimeWithDay:(NSUInteger)day beginHour:(NSTimeInterval)begin endHour:(NSTimeInterval)end;

@end
