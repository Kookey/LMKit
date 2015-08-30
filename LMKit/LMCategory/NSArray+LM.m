//
//  NSArray+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSArray+LM.h"

@implementation NSArray (LM)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

+ (NSArray *)orderTimeWithDay:(NSUInteger)day beginHour:(NSTimeInterval)begin endHour:(NSTimeInterval)end
{
    NSMutableArray *orderDateTimeList = [NSMutableArray array];
    
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:60];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    for (NSUInteger index = 0; index < day; index++) {
        
        NSMutableArray *periodList = [NSMutableArray array];
        
        NSTimeInterval beginHour = begin;
        NSTimeInterval endHour = end;
        
        [dateFormatter setDateFormat:@"EEEE MM-dd"];
        
        NSString *date = [dateFormatter stringFromDate:now];
        
        if (index == 0) {

            [dateFormatter setDateFormat:@"HH"];
            
            NSTimeInterval hour = [dateFormatter stringFromDate:now].doubleValue;
            
            [dateFormatter setDateFormat:@"mm"];
            
            NSTimeInterval min = [dateFormatter stringFromDate:now].doubleValue;
            
            if (min != 0) {
                
                min = min - 1;
            }
            
            if (min == 0) {
                
                beginHour = hour;
                
            } else if (min <= 30 ){
                
                beginHour = hour + 0.5;
                
            } else {
                
                beginHour = hour + 1;
            }
        }
        
        for (; beginHour < endHour && beginHour >= begin; beginHour += 0.5) {
            
            NSUInteger beginMin = 0;
            NSUInteger endMin = 0;
            NSTimeInterval endHour = 0;
            
            NSUInteger skip = beginHour * 10;
            skip = skip % 10;
            
            if (skip != 0 ) {
                
                beginMin = 30;
            }
            
            if (beginMin == 0) {
                
                endMin = 30;
                
            } else {
                
                endMin = 0;
            }
            
            endHour = beginHour + 0.5;
            
            NSString *time = [NSString stringWithFormat:@"%02zd:%02zd-%02zd:%02zd", (NSUInteger)beginHour, beginMin, (NSUInteger)endHour, endMin];
            [periodList addObject:time];
        }
        
        if (periodList.count) {
            
            [orderDateTimeList addObject:@{@"date": date, @"time": periodList}];
        }
        
        NSDate *nextDate = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:now];
        
        now = nextDate;
    }
    
    return orderDateTimeList;
}

@end
