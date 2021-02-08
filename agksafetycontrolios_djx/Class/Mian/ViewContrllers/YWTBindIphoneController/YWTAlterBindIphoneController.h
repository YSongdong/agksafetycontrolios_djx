//
//  AlterBindIphoneController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showAlterBindFristHomeStatu = 0, //  首次进入引导
    showAlterBindNormalStatu  //   正常进入
}showAlterBindStatu;


@interface YWTAlterBindIphoneController : SDBaseController

@property (nonatomic,assign) showAlterBindStatu bindStatu;

@end


