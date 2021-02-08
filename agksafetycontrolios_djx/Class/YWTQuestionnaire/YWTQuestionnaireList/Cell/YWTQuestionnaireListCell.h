//
//  YWTQuestionnaireListCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTQuestionnaireListCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

// 计算高度
+(CGFloat) getWithListCellHeight:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
