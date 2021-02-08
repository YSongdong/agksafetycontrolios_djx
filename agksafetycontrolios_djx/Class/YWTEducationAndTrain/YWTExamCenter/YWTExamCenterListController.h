//
//  ExamCenterListController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    showViewControllerExamCenterListStatu = 0 , // 考试列表
    showViewControllerExamRoomListStatu,        // 考场列表
} showViewControllerStatu;

#import "SDBaseController.h"

@interface YWTExamCenterListController : SDBaseController
// 列表
@property (nonatomic,assign) showViewControllerStatu viewControStatu;
// 考试id
@property (nonatomic,strong) NSString *examIdStr;
// 标题名称
@property (nonatomic,strong) NSString *titleStr;
@end


