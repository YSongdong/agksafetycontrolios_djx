//
//  TaskCenterDetailTableCell.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTTaskCenterDetailTableCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,strong) NSIndexPath *indexPath;

//1是可以做 2是不可做任务
@property (nonatomic,strong) NSString *canDoStr;

// 计算高度
+(CGFloat) getWithDetailHeightCellDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
