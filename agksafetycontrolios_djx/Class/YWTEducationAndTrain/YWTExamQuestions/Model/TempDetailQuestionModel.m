//
//  TempDetailQuestionModel.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/24.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "TempDetailQuestionModel.h"

@implementation TempDetailQuestionModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"questionList" : [QuestionListModel class],
             @"sheet":[SheetModel class]
             };
    
}

@end

@implementation QuestionListModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"Id":@"id"
             };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"optionList" : [OptionListModel class]
             
             };
    
}
@end

@implementation OptionListModel


@end

@implementation SheetModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"list" : [ListModel class]
             
             };
    
}

@end
@implementation ListModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"Id":@"id"
             };
}

@end
