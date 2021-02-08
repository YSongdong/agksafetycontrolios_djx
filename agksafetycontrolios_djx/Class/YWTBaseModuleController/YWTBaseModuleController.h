//
//  BaseModuleController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/5.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    showBaseModuleEducationType = 0,  // 教育培训
    showBaseModuleSafetyManageType,   // 安全管理
}showBaseModuleType;

#import "SDBaseController.h"


@interface YWTBaseModuleController : SDBaseController
// 标题名称
@property (nonatomic,strong) NSString *titleStr;
// 类型
@property (nonatomic,assign) showBaseModuleType moduleType;
// 模块数据源
@property (nonatomic,strong) NSMutableArray *dataArr;

@end


