//
//  YWTDetailInfoCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatryMemberMacros.h"
#import "YWTConstant.h"
#import "YWTPartyEemberAreaModel.h"
#import "YWTCellVideoView.h"

@protocol YWTDetailInfoCellDelegate;
@interface YWTDetailInfoCell : UITableViewCell

@property (nonatomic,weak) id <YWTDetailInfoCellDelegate> delegate;
// 视频view
@property (nonatomic,strong) YWTCellVideoView *cellVideoView;

@property (nonatomic,strong) YWTPartyEemberAreaModel *model;
// 图片渲染
- (void)loadPicture;
@end

@protocol YWTDetailInfoCellDelegate <NSObject>

-(void) selectOPerateMenu:(YWTDetailInfoCell *)cell operateType:(YWTOperateType)operateType;

@end


