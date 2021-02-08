//
//  RecordListTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTRecordListTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;
// 选中
@property (nonatomic,strong) NSIndexPath *selectIndex;
// 选择按钮
@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) NSString *fliePath;

@property (nonatomic,copy) void(^selectIndexPath)(NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
