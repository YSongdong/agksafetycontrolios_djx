//
//  BaseTableViewController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showViewControllerSafetyType = 0,  //安全检查
    showViewControllerMeetingType ,    // 会议
    showViewControllerViolationType ,  // 违章
    showViewControllerTechnoloType ,   // 技术
}showViewControllerType;

typedef enum {
    showBaseAddSoucreType = 0,    // 添加
    showBaseAlterSoucreType,       // 修改
}showBaseSoucreType;

typedef enum {
    showBaseSaveDataAlterType = 0,      // 数据存入草稿 和 提交
    showBaseSaveDataSubmitType ,        // 数据提交
}showBaseSaveDataType;


@interface YWTBaseTableViewController : SDBaseController
// 类型
@property (nonatomic,assign) showViewControllerType veiwBaseType;
// 数据源显示类型
@property (nonatomic,assign) showBaseSoucreType scoureType;
// 显示存入数据类型
@property (nonatomic,assign) showBaseSaveDataType saveDataType;
// 存入草稿 编辑中 请求详情的 IdStr
@property (nonatomic,strong) NSString *editIdStr;
// 修改数据源
@property (nonatomic,strong) NSMutableArray *alterDataArr;;
// 模块名称
@property (nonatomic,strong) NSString *moduleNameStr;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
@end


