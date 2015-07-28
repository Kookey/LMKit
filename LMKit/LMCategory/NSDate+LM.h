//
//  NSDate+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /**
     *  e.g.2014-03-04 13:23:35:67
     */
    LMDateFormatWithAll,
    /**
     *  e.g.2014-03-04 13:23:35
     */
    LMDateFormatWithDateAndTime,     //
    /**
     *  e.g.13:23:35
     */
    LMDateFormatWithTime,
    /**
     *  e.g.13:23
     */
    LMDateFormatWithTimeHourMinute,
    /**
     *  e.g.13:23:35:67
     */
    LMDateFormatWithPreciseTime,
    
    /**
     *  e.g.2014-03-04
     */
    LMDateFormatWithYearMonthDay,
    /**
     *  e.g.2014-03
     */
    LMDateFormatWithYearMonth,
    /**
     *  e.g.03-04
     */
    LMDateFormatWithMonthDay,
    /**
     *  e.g.2014
     */
    LMDateFormatWithYear,
    /**
     *  e.g.03
     */
    LMDateFormatWithMonth,
    /**
     *  e.g.04
     */
    LMDateFormatWithDay,
} LMDateFormat;

@interface NSDate (LM)

/**
 *  将NSDate转为NSString
 *
 *  @param format LMDateFormat
 *
 *  @return NSString
 */
- (NSString *)lm_stringWithDateFormat:(LMDateFormat)format;

/**
 *  取出年、月、日
 *
 *  @return e.g.2015-01-02
 */
- (NSDate *)lm_subDateWithYearMothDay;

/**
 *  是否为今天
 *
 *  @return 是/不是
 */
- (BOOL)lm_isToday;

/**
 *  是否为昨天
 *
 *  @return 是/不是
 */
- (BOOL)lm_isYesterday;

/**
 *  是否为今年
 *
 *  @return 是/不是
 */
- (BOOL)lm_isThisYear;

/**
 *  获得与当前时间的差距
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *)lm_deltaWithNow;

@end

@interface NSString (LMDateFormat)

/**
 *  将NSString转为NSDate
 *
 *  @param format LMDateFormat
 *
 *  @return NSDate
 */
- (NSDate *)lm_dateWithDateFormat:(LMDateFormat)format;

@end
