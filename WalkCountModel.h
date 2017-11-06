//
//  WalkCountModel.h
//  OGP phone patrol
//
//  Created by 张建伟 on 16/11/28.
//  Copyright © 2016年 张建伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
@interface WalkCountModel : NSObject
@property (nonatomic, strong) HKHealthStore *healthStore;
/**
 *  获取步数的方法
 *
 *  @return 步数
 */
- (BOOL)getAuthority;
@end
