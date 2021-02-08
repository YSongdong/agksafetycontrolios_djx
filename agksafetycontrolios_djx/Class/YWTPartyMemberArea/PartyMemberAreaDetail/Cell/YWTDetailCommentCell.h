//
//  YWTDetailCommentCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTDetailCommentModel.h"

@interface YWTDetailCommentCell : UITableViewCell

@property (nonatomic,strong) YWTDetailCommentModel *model;
// 计算高度
+(CGFloat) getWithCommentCellHeight:(YWTDetailCommentModel *)model;

@end


