//
//  TaskCenterListModel.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "TaskCenterListModel.h"

@implementation TaskCenterListModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"descr" : @"description"
             };
}

@end
