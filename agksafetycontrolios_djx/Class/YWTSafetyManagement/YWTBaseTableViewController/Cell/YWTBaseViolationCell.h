//
//  BaseViolationCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/******************** 违章处理   ***************/
@interface YWTBaseViolationCell : UITableViewCell

// 违章人员
@property (nonatomic,strong) UITextView *violationNameTextView;
// 违章人员单位
@property (nonatomic,strong) UITextView *violaPersonUnitTextView;
// 提示选择违章等级
@property (nonatomic,strong) UILabel *showViolaGradeLab;
//违章等级
@property (nonatomic,strong) UILabel *ViolaGradeLab;
// 违章事由
@property (nonatomic,strong) UITextView *violaCententTextView;
// 检查内容
@property (nonatomic,strong) FSTextView *fsTextView;
// 选择违章等级
@property (nonatomic,copy) void(^selectViolation)(void);

@property (nonatomic,strong) NSDictionary *dict;
// 点击完成
@property (nonatomic,copy) void(^selectRutureKeyBord)(NSInteger index,NSString *textStr);
// 内容
@property (nonatomic,copy) void(^selectContentKeyBord)(NSString *contentStr);

@end

NS_ASSUME_NONNULL_END
