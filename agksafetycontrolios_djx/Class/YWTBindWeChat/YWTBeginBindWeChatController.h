//
//  BeginBindWeChatController.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showWeChatUnBindStatu = 0, // 未绑定
    showWeChatBindSuccessStatu  //绑定成功
}showWeChatBindStatu;

@interface YWTBeginBindWeChatController : SDBaseController
//  类型
@property (nonatomic,assign) showWeChatBindStatu bindStatu;

@end


