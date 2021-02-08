//
//  BindIphoneViewController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showViewFristHomeStatu = 0, //  首次进入引导
    showViewNormalStatu,        //   个人资料
    showViewAlterBindStatu,     //   从修改手机
}showViewStatu;

@interface YWTBindIphoneViewController : SDBaseController

// 类型
@property (nonatomic,assign) showViewStatu viewStatu;

@end


