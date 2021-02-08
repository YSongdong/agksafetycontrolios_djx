//
//  AttendanceRecordCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTCheckRecordTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;
// 查看备注
@property (nonatomic,copy) void(^addMark)(void);

@end

NS_ASSUME_NONNULL_END
