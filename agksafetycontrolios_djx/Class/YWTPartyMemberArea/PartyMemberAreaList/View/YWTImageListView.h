//
//  YWTImageListView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTPartyEemberAreaModel.h"

@class YWTImageView;

@interface YWTImageListView : UIView

@property (nonatomic,strong) YWTPartyEemberAreaModel *imageModel;

// 点击小图
@property (nonatomic, copy) void (^singleTapHandler)( YWTImageView*imageView);

// 图片渲染
- (void)loadPicture;

@end

/* --------   单个小图显示视图 ----------*/
@interface YWTImageView : UIImageView
// 点击小图
@property (nonatomic, copy) void (^clickHandler)(YWTImageView *imageView);

@end

