//
//  LeftView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLeftView : UIView

//头像
@property (nonatomic,strong) UIImageView *headerImageV;
//头像状态
@property (nonatomic,strong) UIImageView *headerStatuImageV;
//姓名
@property (nonatomic,strong) UILabel *nameLab;
//性别
@property (nonatomic,strong) UIImageView *sexImageV;
//部门
@property (nonatomic,strong) UILabel *departNameLab;
//编号
@property (nonatomic,strong) UILabel *numberLab;
// 我的学分
@property (nonatomic,strong) UILabel *myCreditsLab;

// 点击头像跳转
@property (nonatomic,copy) void(^headerBlock)(void);
// 点击考试成绩
@property (nonatomic,copy) void(^examinationBlock)(void);
// 点击设置
@property (nonatomic,copy) void(^settingBlock)(void);
// 点击我的学分
@property (nonatomic,copy) void(^selectMyCrdits)(void);
// 点击我的文章
@property (nonatomic,copy) void(^selectMyArticle)(void);
// 更新用户信息
-(void) updateUserInfoData;

@end

NS_ASSUME_NONNULL_END
