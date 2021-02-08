//
//  AnnexTypeTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showAnnexTableCellAddType = 0,  //添加模式
    showAnnexTableCellAlterType,    // 修改模式
}showAnnexTableCellType;

@interface YWTAnnexTypeTableViewCell : UITableViewCell

@property (nonatomic,assign) showAnnexTableCellType cellType;

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,copy) void(^selectDelBtn)(void);

@end

NS_ASSUME_NONNULL_END
