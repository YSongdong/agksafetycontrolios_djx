//
//  BaseShowListController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showControllerRiskListType = 0,   // 风险展示
    showControllerExposureListType ,   // 曝光台
}showControllerListType;

@interface YWTBaseShowListController : SDBaseController
// 类型
@property (nonatomic,assign) showControllerListType listType;
// 模块名称
@property (nonatomic,strong) NSString *moduleNameStr;
// 搜索
@property (nonatomic,strong) NSString *titleStr;
@end


