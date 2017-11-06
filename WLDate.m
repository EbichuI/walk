//
//  WLDate.m
//  GKPiPhoneBusiness
//
//  Created by BigRiceBraise on 16/6/29.
//  Copyright © 2016年 gfeng. All rights reserved.
//

#import "WLDate.h"

@implementation WLDate
//获取当前系统的时间戳
+(CGFloat)getTimeSp{
    CGFloat time;
    NSDate *fromdate=[NSDate date];
    time=(CGFloat)[fromdate timeIntervalSince1970];
    return time;
}
//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}
//将时间戳转换成NSDate,加上时区偏移
+(NSDate*)zoneChange:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return localeDate;
}
//将NSDate转换成NSDate,加上时区偏移
+(NSDate*)zoneChangeDate:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
//比较给定NSDate与当前时间的时间差，返回相差的秒数
+(long)timeDifference:(NSDate *)date{
    NSDate *localeDate = [NSDate date];
    long difference =fabs([localeDate timeIntervalSinceDate:date]);
    return difference;
}
//将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
+(NSString*)nsdateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}
//将NSDate按yyyyMMddHHmmss格式时间输出
+(NSString*)dateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}
//将yyyyMMddHHmmss 按 dd HH:mm:ss 格式时间输出
+(NSString*)time:(NSString *)time FromFormat:(NSString *)fromFormat ToFormat:(NSString *)toFormat{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:fromFormat];
    NSDate *fromdate=[dateFormat dateFromString:time];
    [dateFormat setDateFormat:toFormat];
    NSString *string=[dateFormat stringFromDate:fromdate];
    return string;
}
//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+(NSString *)changeTimeToTimeSp:(NSString *)timeStr{
    NSString *time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= [NSString stringWithFormat:@"%.0f",[fromdate timeIntervalSince1970]];
    return time;
}
//获取当前系统的yyyy-MM-dd HH:mm:ss格式时间
+(NSString *)getTime{
    NSDate *fromdate=[NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:fromdate];
    return string;
}
+ (BOOL)isTodayFromeData:(NSDate *)fromeData ToData:(NSDate *)toData{
    
    NSDate *now = fromeData;
    NSDate *date = toData;
    NSTimeInterval time = [now timeIntervalSinceDate:date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowComponents = [calendar components:NSYearCalendarUnit | NSHourCalendarUnit fromDate:now];
    //    NSDateComponents *dateComponets = [calendar components:NSYearCalendarUnit fromDate:date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar: [NSCalendar autoupdatingCurrentCalendar]];
    int nowHour = (int)[nowComponents hour];
    int days_ago = ((int)time + 3600*(24-nowHour))/(3600*24);
    if (days_ago == 0){
        return YES;
    }else  {
        return NO;
    }
}
#pragma mark - date

#pragma mark -  根据时间差获取时间  -
+(NSDate *)difference:(NSInteger )diff{
    NSInteger dis = diff; //前后的天数
    
    NSDate*nowDate = [NSDate date];
    NSDate*theDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    
    CGFloat x = [self timeDifference:startDate];

    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    theDate = [nowDate initWithTimeIntervalSinceNow:(oneDay * dis) - x];

    NSDate *date = [self zoneChangeDate:theDate];
    
    return theDate;
}

#pragma mark -  获取当月第一天的Date  -
+ (NSDate *)monthOneDay:(NSDate *)date{
    NSDate * theDate;
    NSInteger dis = [self day:date] - 1;
    theDate = [self difference:-dis];
    return theDate;
}

#pragma mark -  获取当月第一天的Date  -
+ (NSDate *)monthFinalDay:(NSDate *)date{
    NSDate * theDate;
    NSInteger day= [self day:date];
    NSInteger dis = [self totaldaysInThisMonth:date];
    theDate = [self difference: dis - day];
    return theDate;
}

#pragma mark - 获取是这个月的第几天
+ (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

#pragma mark - 获取这是第几个月
+ (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
#pragma mark - 获取这是第几年
+ (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
#pragma mark - 获取时间XXXX-XX
+ (NSString *)TimeStamp:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [NSString stringWithFormat:@"%ld%ld",(long)[components year],(long)[components month]];
}
#pragma mark - 在这个月的总天数
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
#pragma mark - 这个月是从星期几天开始的
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
#pragma mark - 上个月
+ (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
#pragma mark - 下个月
+ (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//转换成时分秒
+ (NSString *)timeFormatted:(NSString *)totalSeconds{
    int x = [totalSeconds intValue];
    int seconds = x % 60;
    int minutes = (x / 60) % 60;
    int hours = x / 3600;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}
@end
