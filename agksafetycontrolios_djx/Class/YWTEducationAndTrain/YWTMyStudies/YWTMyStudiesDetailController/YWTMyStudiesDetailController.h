//
//  MyStudiesDetailController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    showDetailViewFileType = 0,   // 文件
    showDetailViewPhotoType ,     // 图片
    showDetailViewAudioType ,     // 音频
    showDetailViewVideoType      //  视频
}showDetailViewType;

#import "SDBaseController.h"

@interface YWTMyStudiesDetailController : SDBaseController

@property (nonatomic,assign) showDetailViewType detaType;
// id
@property (nonatomic,strong) NSString *idStr;

// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
// 人脸规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;

@end


