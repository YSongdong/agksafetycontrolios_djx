//
//  HeaderPhotoTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    cellPhotoStatuNotUploaded = 0, // 未上传
    cellPhotoStatuCollectionPhoto ,    // 采集照片中
    cellPhotoStatuFristHome ,    // 首次登陆
    cellPhotoStatuChecking ,       // 审核中
    cellPhotoStatuCheckError ,     // 审核失败
    cellPhotoStatuCheckSucces      // 审核成功
    
}showCellPhotoStatu;


@interface YWTHeaderPhotoTableViewCell : UITableViewCell

// 类型
@property (nonatomic,assign) showCellPhotoStatu  cellPhotoStatu;

// 失败原因
@property (nonatomic,strong) NSString *photoErrorStr;

@property (nonatomic,strong) NSDictionary *dict;


@end

NS_ASSUME_NONNULL_END
