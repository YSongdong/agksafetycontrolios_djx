//
//  SpecialTrainingController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTSpecialTrainingController : SDBaseController
//题库ID
@property (nonatomic,strong) NSString *libaryIdStr;
// 数据源
@property (nonatomic,strong) NSDictionary *dataDict;

@end


