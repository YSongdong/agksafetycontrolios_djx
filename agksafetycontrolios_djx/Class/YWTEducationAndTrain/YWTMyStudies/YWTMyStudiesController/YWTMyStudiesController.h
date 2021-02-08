//
//  MyStudiesController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTMyStudiesController : SDBaseController
// 模块名称
@property (nonatomic,strong) NSString *moduleNameStr;
// 搜索参数
@property (nonatomic,strong) NSString *titleStr;
// 资源id
@property (nonatomic,strong) NSString *resourceIdStr;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;

@end

