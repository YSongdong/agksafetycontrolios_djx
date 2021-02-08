//
//  libayExerciseController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTlibayExerciseController : SDBaseController
// 搜索参数
@property (nonatomic,strong) NSString *titleStr;
// 资源id 
@property (nonatomic,strong) NSString *resourceIdStr;
// 模块名称
@property (nonatomic,strong) NSString *moduleNameStr;

@end

