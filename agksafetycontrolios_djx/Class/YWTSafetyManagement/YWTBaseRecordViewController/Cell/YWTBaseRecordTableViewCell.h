//
//  BaseRecordTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showBaseRecordCellSafetyType = 0,  //安全检查
    showBaseRecordCellMeetingType ,    // 会议
    showBaseRecordCellViolationType ,  // 违章
    showBaseRecordCellTechnoloType ,   // 技术
}showBaseRecordCellType;

@interface YWTBaseRecordTableViewCell : UITableViewCell
// 类型
@property (nonatomic,assign) showBaseRecordCellType cellType;

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
