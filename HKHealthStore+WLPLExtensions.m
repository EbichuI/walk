//
//  HKHealthStore+WLPLExtensions.m
//  GymJT
//
//  Created by 王亮 on 16/11/7.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "HKHealthStore+WLPLExtensions.h"

@implementation HKHealthStore (WLPLExtensions)
- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *, NSError *))completion {
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        if (completion) {
            // If quantity isn't in the database, return nil in the completion block.
            NSLog(@"results ---- > = %@",results);
            completion(results, error);
        }
    }];
    
    [self executeQuery:query];
}

- (void)aapl_zonghe_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(double num, NSError *))completion {
    HKStatisticsQuery* min = [[HKStatisticsQuery alloc ]initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error){
        
        HKUnit *stepType = [[HKUnit countUnit ]unitDividedByUnit:[HKUnit countUnit]];

        if (!result) {
            if (completion) {
                completion(0, error);
            }
            return;
        }
        
        if (completion) {
            // If quantity isn't in the database, return nil in the completion block.
            NSLog(@"results ---- > = %@",result);
            completion([[result sumQuantity] doubleValueForUnit:stepType], error);
        }
        NSLog(@"%f" , [[result sumQuantity] doubleValueForUnit:stepType]);
    }];
    
    [self executeQuery:min];

}
@end
