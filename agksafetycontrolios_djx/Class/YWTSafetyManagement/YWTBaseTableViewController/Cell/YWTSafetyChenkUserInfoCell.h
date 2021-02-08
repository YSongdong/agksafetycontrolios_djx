//
//  SafetyChenkUserInfoCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showBaseCellSafetyType = 0 ,  // 安全检查
    showBaseCellMeetingType ,     // 班前班后会
}showBaseCellType;

@interface YWTSafetyChenkUserInfoCell : UITableViewCell
// 类型
@property (nonatomic,assign) showBaseCellType cellType;

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
