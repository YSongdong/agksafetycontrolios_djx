//
//  YWTAnnualBottomView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/20.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAnnualBottomView : UIView
@property (nonatomic,strong) UIView *bgView;
// 序号
@property (nonatomic,strong) UILabel *serialNumberLab;
// 头像‘
@property (nonatomic,strong) UIImageView *headerImageV;
// 名称
@property (nonatomic,strong) UILabel *nameLab;
// 得分
@property (nonatomic,strong) UILabel *scoreLab;

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
