//
//  AlterLoginPwdVController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showPwdViewFristHomeStatu = 0, //  首次进入引导
    showPwdViewNormalStatu  //   正常进入
}showPwdViewStatu;


@interface YWTAlterLoginPwdVController : SDBaseController
// 类型
@property (nonatomic,assign) showPwdViewStatu pwdViewStatu;

@end


