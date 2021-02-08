//
//  AnnexLookOverJSController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTAnnexLookOverJSController : SDBaseController
// fileType=2  代表学习中心过来  其他代表普通 文件
@property (nonatomic,strong) NSString *fileType;
// id
@property (nonatomic,strong) NSString *mIdStr;
// 文件名称
@property (nonatomic,strong) NSString *fileNameStr;

// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
// 人脸规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;

@end

