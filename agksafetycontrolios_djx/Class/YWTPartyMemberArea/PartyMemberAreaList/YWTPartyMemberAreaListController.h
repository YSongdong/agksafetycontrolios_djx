//
//  YWTPartyMemberAreaController.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    partyAreaListMineType = 0, // 我的文章
    partyAreaListOtherType     // 列表文章
}partyAreaListType;

@interface YWTPartyMemberAreaListController : SDBaseController
// 类型
@property (nonatomic,assign) partyAreaListType listType;

@property (nonatomic,strong) NSString *moduleNameStr;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
@end


