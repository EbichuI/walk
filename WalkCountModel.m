//
//  WalkCountModel.m
//  OGP phone patrol
//
//  Created by 张建伟 on 16/11/28.
//  Copyright © 2016年 张建伟. All rights reserved.
//

#import "WalkCountModel.h"

@implementation WalkCountModel
{
    BOOL count;
}

-(HKHealthStore *)healthStore
{
    if (!_healthStore) {
        _healthStore=[[HKHealthStore alloc]init];
    }
    return _healthStore;
}
- (BOOL)getAuthority
{
    //查看healthKit在设备上是否可用，iPad上不支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        NSLog(@"该设备不支持HealthKit");
    }
    //创建healthStore对象
    self.healthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限 这里仅设置了步数
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepType, nil];
    
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            count=YES;
        }
        else
        {
            NSLog(@"获取步数权限失败");
            count=NO;
        }
    }];
    return count;
}
//- (int)readStepCount
//{
//    //查询采样信息
//    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    //NSSortDescriptor来告诉healthStore怎么样将结果排序
//    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
//    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
//    //获取当前时间
//    NSDate *now = [NSDate date];
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
//    int hour = (int)[dateComponent hour];
//    int minute = (int)[dateComponent minute];
//    int second = (int)[dateComponent second];
//    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
//    //时间结果与想象中不同是因为它显示的是0区
//    NSLog(@"今天%@",nowDay);
//    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
//    NSLog(@"明天%@",nextDay);
//    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
//    
//    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标 ，这里我们需要查询的步数是一个HKSample类所以对应的查询类是HKSampleQuery。下面的limit参数传1表示查询最近一条数据，查询多条数据只要设置limit的参数值就可以了*/
//    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
//        //设置一个int型变量来作为步数统计
//        allStepCount = 0;
//        for (int i = 0; i < results.count; i ++) {
//            //把结果转换为字符串类型
//            HKQuantitySample *result = results[i];
//            HKQuantity *quantity = result.quantity;
//            NSMutableString *stepCount = (NSMutableString *)quantity;
//            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
//            //获取51 count此类字符串前面的数字
//            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
//            int stepNum = [str intValue];
//            NSLog(@"%d",stepNum);
//            //把一天中所有时间段中的步数加到一起
//            allStepCount = allStepCount + stepNum;
//        }
//        NSLog(@"今天的总步数＝＝＝＝%d",allStepCount);
//        [USERDEFAULT setObject:[NSNumber numberWithInt:allStepCount] forKey:@"walkcount"];
//    }];
//    //执行查询
//    [self.healthStore executeQuery:sampleQuery];
//    return allStepCount;
//}
@end
