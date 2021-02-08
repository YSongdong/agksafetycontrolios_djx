//
//  BeginCollectionTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    cellPhotoCollectionPhoto ,    // 采集照片中
    cellPhotoCollectionSucces      // 采集成功
}showCollectionBtnStatu;

@interface YWTBeginCollectionTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton *colletionBtn;
// 类型
@property (nonatomic,assign) showCollectionBtnStatu showBtnStatu;
//点击重新采集
@property (nonatomic,copy) void(^selectCollectionBlock)(void);
@end

