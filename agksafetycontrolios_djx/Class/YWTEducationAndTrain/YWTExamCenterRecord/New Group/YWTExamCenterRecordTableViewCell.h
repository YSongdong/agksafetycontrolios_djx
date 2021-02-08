//
//  ExamCenterRecordTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamCenterRecordTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;
// 计算高度
+(CGFloat) getWithRecordCellHeight:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
