//
//  YWTBaseParyMemberCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTPartyEemberAreaModel.h"

#import "PatryMemberMacros.h"
#import "YWTConstant.h"

#import "YWTImageListView.h"
#import "YWTCellVideoView.h"
#import "YWTOperateMenuView.h"

NS_ASSUME_NONNULL_BEGIN


//#### 动态
@protocol YWTBaseParyMemberCellDelegate;
@interface YWTBaseParyMemberCell : UITableViewCell

@property (nonatomic,weak) id <YWTBaseParyMemberCellDelegate> delegate;
// 大背景
@property (nonatomic,strong) UIView *cellBgView;
// 点击详情背景
@property (nonatomic,strong) UIButton *clickBgBtn;
// 头像
@property (nonatomic,strong) UIImageView *avatarImageV;
// 名称
@property (nonatomic,strong) UILabel * nickNameLab;
// 部门
@property (nonatomic,strong) UILabel * departmentNameLab;
// 时间
@property (nonatomic,strong) UILabel * timeLab;
// 正文
@property (nonatomic,strong) YYLabel * linkLabel;
// 图片view
@property (nonatomic,strong) YWTImageListView *imageListView;
// 视频view
@property (nonatomic,strong) YWTCellVideoView *cellVideoView;
// 操作视图
@property (nonatomic,strong) YWTOperateMenuView *menuView;

@property (nonatomic,strong) YWTPartyEemberAreaModel *model;
// 图片渲染
- (void)loadPicture;

@end

@protocol YWTBaseParyMemberCellDelegate <NSObject>
// 选中文章详情
-(void) selectOPerateMenu:(YWTBaseParyMemberCell *)cell operateType:(YWTOperateType)operateType;

@end


NS_ASSUME_NONNULL_END
