//
//  BaseDetailAnnexCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseDetailAnnexCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;
// 是否显示空白页  YES 是 NO 不是 默认NO
@property (nonatomic,assign) BOOL isShowSpace;

@end

NS_ASSUME_NONNULL_END
