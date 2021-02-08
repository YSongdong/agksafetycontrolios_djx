//
//  PhotoCollectionController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    photoStatuNotUploaded = 0, // 未上传
    photoStatuCollectionPhoto ,    // 采集照片中
    photoStatuFristHome ,       // 首页引导
    photoStatuChecking ,       // 审核中
    photoStatuCheckError ,     // 审核失败
    photoStatuCheckSucces      // 审核成功
}collectionPhotoStatu ;


#import "SDBaseController.h"

@interface YWTPhotoCollectionController : SDBaseController

// 是否第一次进入首页 YES  是 NO 不是
@property (nonatomic,assign) BOOL isFristHome;
// 失败原因
@property (nonatomic,strong) NSString *photoErrorStr;
// 照片状态
@property (nonatomic,assign) collectionPhotoStatu photoStatu;


@end


