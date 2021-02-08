//
//  YWTDetailContentCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/19.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTDetailContentCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

// 计算高度
+(CGFloat) getWithDetailConntentCellHeight:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
