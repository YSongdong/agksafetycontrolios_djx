//
//  RecordMoreTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTRecordMoreTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,strong) NSIndexPath *indexPath;
// 点击详情
@property (nonatomic,copy) void(^detailBlock)(void);

@end

NS_ASSUME_NONNULL_END
