//
//  BaseAnnexCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showAnnexCellAddType = 0,  //添加模式
    showAnnexCellAlterType,    // 修改模式
}showAnnexCellType;

typedef enum {
    showBaseAnnexCellNomalType = 0 ,  // 正常
    showBaseAnnexCellViolationType ,     // 违规处理
}showBaseAnnexCellType;


@interface YWTBaseAnnexCell : UITableViewCell

@property (nonatomic,assign) showAnnexCellType cellType;

@property (nonatomic,assign) showBaseAnnexCellType annexCellType;

// 附件数据源
@property (nonatomic,strong) NSMutableArray *annexArr;
// 记录 必录描述文字
@property (nonatomic,strong) NSString *infoRemorkStr;
// 添加附件按钮
@property (nonatomic,copy) void(^baseAddAnnex)(void);
// 删除数据源
@property (nonatomic,copy) void(^selectDelBtn)(NSInteger index);
// 播放视频
@property (nonatomic,copy) void(^selectVodplay)(NSDictionary *annexDict);

@end

NS_ASSUME_NONNULL_END
