//
//  LibayExerDetaModel.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLibayExerDetaModel.h"

@implementation YWTLibayExerDetaModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"Id" : @"id",
             @"descr":@"description"
             };
}

@end
