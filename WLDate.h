//
//  WLDate.h
//  GKPiPhoneBusiness
//
//  Created by BigRiceBraise on 16/6/29.
//  Copyright © 2016年 gfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDate : NSObject
/**
 *  获取当前系统的时间戳
 */
+(CGFloat)getTimeSp;
/**
 *  将时间戳转换成NSDate
 */
+(NSDate *)changeSpToTime:(NSString*)spString;
/**
 *  将时间戳转换成NSDate,加上时区偏移
 */
+(NSDate*)zoneChange:(NSString*)spString;
+(NSDate*)zoneChangeDate:(NSDate *)date;
/**
 *  比较给定NSDate与当前时间的时间差，返回相差的秒数
 */
+(long)timeDifference:(NSDate *)date;
/**
 *  将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
 */
+(NSString*)nsdateToString:(NSDate *)date;
//将NSDate按yyyyMMddHHmmss格式时间输出
+(NSString*)dateToString:(NSDate *)date;


/**
 时间格式转换

 @param time       须有修改的时间  需要和fromFormat 格式一样
 @param fromFormat time 格式
 @param toFormat   需要转换的格式

 @return 返回时间
 */
+(NSString*)time:(NSString *)time FromFormat:(NSString *)fromFormat ToFormat:(NSString *)toFormat;
/**
 *  将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
 */
+(NSString *)changeTimeToTimeSp:(NSString *)timeStr;
/**
 *  获取当前系统的yyyy-MM-dd HH:mm:ss格式时间
 */
+(NSString *)getTime;
/**
 将秒 转换成时分秒
 */
+ (NSString *)timeFormatted:(NSString *)totalSeconds;


/**
 获取时间差
 
 @param diff 与今天的时间天数差值
 @return 时间
 */
+(NSDate *)difference:(NSInteger )diff;
/**
 *  判断时间是不是同一天
 *
 *  @param timeStr 传入的时间
 *
 *  @return YES 是今天 ，NO不是今天
 */
+ (BOOL)isTodayFromeData:(NSDate *)fromeData ToData:(NSDate *)toData;

#pragma mark - 获取这个月的第一天
+ (NSDate *)monthOneDay:(NSDate *)date;
#pragma mark - 获取这个月的最后一天
+ (NSDate *)monthFinalDay:(NSDate *)date;
#pragma mark - 获取是这个月的第几天
+ (NSInteger)day:(NSDate *)date;
#pragma mark - 获取这是第几个月
+ (NSInteger)month:(NSDate *)date;
#pragma mark - 获取这是第几年
+ (NSInteger)year:(NSDate *)date;
#pragma mark - 获取时间XXXX-XX
+ (NSString *)TimeStamp:(NSDate *)date;
#pragma mark - 在这个月的总天数
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;
#pragma mark - 这个月是从星期几开始的
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
#pragma mark - 上个月
+ (NSDate *)lastMonth:(NSDate *)date;
#pragma mark - 下个月
+ (NSDate*)nextMonth:(NSDate *)date;


@end
