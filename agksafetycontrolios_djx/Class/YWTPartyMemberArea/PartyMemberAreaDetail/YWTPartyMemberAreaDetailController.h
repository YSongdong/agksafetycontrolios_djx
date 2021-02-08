//
//  YWTPartyMemberAreaDetailController.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"
typedef enum {
    partyAreaDetailMineType = 0, // 我的文章
    partyAreaDetailOtherType     // 列表文章
}partyAreaDetailType;

@interface YWTPartyMemberAreaDetailController : SDBaseController
// 类型
@property (nonatomic,assign) partyAreaDetailType detailType;

@property (nonatomic,strong) NSString *idStr;
// 是否滚动到评论
@property (nonatomic,assign) BOOL isComment;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
@end


