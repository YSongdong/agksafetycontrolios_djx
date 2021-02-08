//
//  YWTPartyMemberAreaAddController.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/6.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    partyAreaPhotoType = 0, // 图片
    partyAreaVideoType     // 视频
}partyAreaType;

@interface YWTPartyMemberAreaAddController : SDBaseController
// 类型
@property (nonatomic,assign) partyAreaType areaType;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;

@end


