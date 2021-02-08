//
//  BaseDetaUserInfoCell.h
//  PartyBuildingStar
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showBaseUserInfoSafetyType = 0,  //安全检查
    showBaseUserInfoMeetingType ,    // 会议
    showBaseUserInfoViolationType ,  // 违章
    showBaseUserInfoTechnoloType ,   // 技术
}showBaseUserInfoCellType;

@interface YWTBaseDetaUserInfoCell : UITableViewCell

// 类型
@property (nonatomic,assign) showBaseUserInfoCellType cellType;
// 数据源
@property (nonatomic,strong) NSDictionary *dict;

// 计算高度
+(CGFloat) getWithBaseDetaUserInfoHeightCell:(NSDictionary*)dict andCellType:(showBaseUserInfoCellType)cellType;

@end

NS_ASSUME_NONNULL_END
