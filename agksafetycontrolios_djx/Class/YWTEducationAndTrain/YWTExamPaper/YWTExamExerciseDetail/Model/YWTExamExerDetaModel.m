//
//  ExamExerDetaModel.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamExerDetaModel.h"

@implementation YWTExamExerDetaModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"desc":@"description"
             };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"libaryList" : [libaryListModel class]
             
             };
    
}
@end

@implementation libaryListModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"Id":@"id"
             };
}

@end
