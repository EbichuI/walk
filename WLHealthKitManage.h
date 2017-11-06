//
//  WLHealthKitManage.h
//  GymJT
//
//  Created by 王亮 on 16/11/7.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>

#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
//#define CustomHealthErrorDomain @"com.sdqt.healthError"

@interface WLHealthKitManage : NSObject
@property (nonatomic, strong) HKHealthStore *healthStore;


+(id)shareInstance;
/*!
 *  @author Lcong, 15-04-20 18:04:38
 *
 *  @brief  获取当天实时步数
 *
 *  @param handler 回调
 */
- (void)getRealTimeStepCountCompletionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:34
 *
 *  @brief  获取一定时间段步数
 *
 *  @param predicate 时间段
 *  @param handler   回调 返回的是每天的数据
 */
- (void)getStepCount:(NSPredicate *)predicate completionHandler:(void(^)(NSArray *value, NSError *error))handler;



- (void)getSeparateStepCount:(NSPredicate *)predicate completionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:32
 *
 *  @brief  获取卡路里
 *
 *  @param predicate    时间段
 *  @param quantityType 样本类型
 *  @param handler      回调
 */
- (void)getKilocalorieUnit:(NSPredicate *)predicate quantityType:(HKQuantityType*)quantityType completionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:17
 *
 *  @brief  当天时间段
 *
 *  @return ,,,
 */
+ (NSPredicate *)predicateForSamplesToday;
/**
 获取自定时间段
 
 @param fromData 开始时间
 @param toDate   结束时间
 
 @return 时间段
 */
+ (NSPredicate *)predicateForFrom:(NSDate *)fromData To:(NSDate *)toDate;
@end
