//
//  BaseShowListModel.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "BaseShowListModel.h"

@implementation BaseShowListModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"Id":@"id"
             };
}


@end
