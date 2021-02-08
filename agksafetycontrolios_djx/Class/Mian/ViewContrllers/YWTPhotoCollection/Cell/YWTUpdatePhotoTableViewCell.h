//
//  updatePhotoTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    cellUpdateBtnNotUploaded = 0, // 未上传
    cellUpdateBtnCollectionPhoto ,    // 采集照片中
    cellUpdateBtnFristHome ,    // 首次登陆
    cellUpdateBtnChecking ,       // 审核中
    cellUpdateBtnCheckError ,     // 审核失败
    cellUpdateBtnCheckSucces      // 审核成功
}showCellUpdateBtnStatu;

@interface YWTUpdatePhotoTableViewCell : UITableViewCell

@property (nonatomic,strong) UIButton *updateColletionBtn;

// 类型
@property (nonatomic,assign) showCellUpdateBtnStatu showUpdateBtnStatu;

//点击按钮方法
@property (nonatomic,copy) void(^selectActionBlock)(void);

@end

NS_ASSUME_NONNULL_END
