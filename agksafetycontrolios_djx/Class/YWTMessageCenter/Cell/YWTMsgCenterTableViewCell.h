//
//  MsgCenterTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/4.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTMsgCenterTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

//计算cell 高度
+(CGFloat) getWithCellHeight:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
