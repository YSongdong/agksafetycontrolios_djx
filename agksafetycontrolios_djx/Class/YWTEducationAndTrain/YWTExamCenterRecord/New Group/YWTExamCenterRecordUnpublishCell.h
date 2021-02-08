//
//  ExamCenterRecordUnpublishCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamCenterRecordUnpublishCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

// 计算高度
+(CGFloat) getWithRecordCellHeight:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
