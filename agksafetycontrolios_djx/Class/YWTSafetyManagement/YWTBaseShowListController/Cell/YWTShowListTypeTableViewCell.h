//
//  ShowListTypeTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "BaseShowListModel.h"

@interface YWTShowListTypeTableViewCell : UITableViewCell

@property (nonatomic,strong) BaseShowListModel *model;

// 选择附件
@property (nonatomic,copy) void(^selectAnnex)(NSDictionary *annexDict);

@property (nonatomic,copy) void(^selectMoreBtn)(BaseShowListModel *heightModel);

@end


