//
//  ExamCenterListModel.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "ExamCenterListModel.h"

@implementation ExamCenterListModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"descr" : @"description"
             };
}


@end

