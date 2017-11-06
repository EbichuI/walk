//
//  HKHealthStore+WLPLExtensions.h
//  GymJT
//
//  Created by 王亮 on 16/11/7.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import <HealthKit/HealthKit.h>

@interface HKHealthStore (WLPLExtensions)
// Fetches the single most recent quantity of the specified type.
- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion;


- (void)aapl_zonghe_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(double num, NSError *))completion;
@end
