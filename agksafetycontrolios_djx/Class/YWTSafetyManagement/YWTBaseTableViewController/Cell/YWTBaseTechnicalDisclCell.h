//
//  BaeTechnicalDisclCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showBaseTechnicalType = 0 ,   //技术交底
    showBaseViolationType,        // 违章处理
}showBaseType;

@interface YWTBaseTechnicalDisclCell : UITableViewCell
// 类型
@property (nonatomic,assign) showBaseType baseType;

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
