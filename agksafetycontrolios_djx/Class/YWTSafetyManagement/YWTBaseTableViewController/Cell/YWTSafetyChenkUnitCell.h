//
//  SafetyChenkUnitCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/******************** 安全检查   ***************/
@interface YWTSafetyChenkUnitCell : UITableViewCell

// 检查标题
@property (nonatomic,strong) UITextView *chenkTitleTextView;
// 被检单位
@property (nonatomic,strong) UITextView *chenkUnitTextView;
// 检查地点
@property (nonatomic,strong) UITextView *chenkAddressTextView;
// 提示选择电压等级
@property (nonatomic,strong) UILabel *showVoltageLevelLab;
//电压等级
@property (nonatomic,strong) UILabel *voltageLevelLab;
// 工作票
@property (nonatomic,strong) UITextView *workTickTextView;

// 检查内容
@property (nonatomic,strong) FSTextView *fsTextView;
// 选择电压等级
@property (nonatomic,copy) void(^selectVoltageLevel)(void);

@property (nonatomic,strong) NSDictionary *dict;
// 点击完成
@property (nonatomic,copy) void(^selectRutureKeyBord)(NSInteger index,NSString *textStr);
// 内容
@property (nonatomic,copy) void(^selectContentKeyBord)(NSString *contentStr);
// 更新当前文字高度
@property (nonatomic,copy) void(^currentHeight)(CGFloat currentTextViewHeight);

@end

NS_ASSUME_NONNULL_END
