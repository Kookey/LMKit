//
//  NSDate+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSDate+LM.h"

@implementation NSDate (LM)

#pragma mark 将NSDate转为NSString
 
- (NSString *)lm_stringWithDateFormat:(LMDateFormat)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:[NSDate formatString:format]];
    NSString *date_time = [NSString stringWithString:[dateFormatter stringFromDate:self]];
    
    return date_time;
}

+ (NSString *)formatString:(LMDateFormat)format
{
    NSString *formatString;
    switch (format) {
        case LMDateFormatWithAll:
            formatString = @"yyyy-MM-dd HH:mm:ss:SS";
            break;
        case LMDateFormatWithDateAndTime:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        case LMDateFormatWithTime:
            formatString = @"HH:mm:ss";
            break;
        case LMDateFormatWithTimeHourMinute:
            formatString = @"HH:mm";
            break;
        case LMDateFormatWithPreciseTime:
            formatString = @"HH:mm:ss:SS";
            break;
        case LMDateFormatWithYearMonthDay:
            formatString = @"yyyy-MM-dd";
            break;
        case LMDateFormatWithYearMonth:
            formatString = @"yyyy-MM";
            break;
        case LMDateFormatWithMonthDay:
            formatString = @"MM-dd";
            break;
        case LMDateFormatWithYear:
            formatString = @"yyyy";
            break;
        case LMDateFormatWithMonth:
            formatString = @"MM";
            break;
        case LMDateFormatWithDay:
            formatString = @"dd";
            break;
            
        default:
            break;
    }
    
    return formatString;
}

#pragma mark -.-

#pragma mark 取出年、月、日

- (NSDate *)lm_subDateWithYearMothDay
{
    return [[self lm_stringWithDateFormat:LMDateFormatWithYearMonthDay] lm_dateWithDateFormat:LMDateFormatWithYearMonthDay];
}

#pragma mark 是否为今天

- (BOOL)lm_isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day);
}

#pragma mark 是否为昨天

- (BOOL)lm_isYesterday
{
    NSDate *nowDate = [[NSDate date] lm_subDateWithYearMothDay];
    NSDate *selfDate = [self lm_subDateWithYearMothDay];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

#pragma mark 是否为今年

- (BOOL)lm_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitYear;
    

    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return nowComponents.year == selfComponents.year;
}

#pragma mark 获得与当前时间的差距

- (NSDateComponents *)lm_deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end

@implementation NSString (LMDateFormat)

#pragma mark 将NSString转为NSDate

- (NSDate *)lm_dateWithDateFormat:(LMDateFormat)format
{
    NSDateFormatter *LMDateFormatter = [[NSDateFormatter alloc] init];
    
    [LMDateFormatter setDateFormat:[NSDate formatString:format]];
    NSDate *date = [LMDateFormatter dateFromString:self];
    
    return date;
}

@end
