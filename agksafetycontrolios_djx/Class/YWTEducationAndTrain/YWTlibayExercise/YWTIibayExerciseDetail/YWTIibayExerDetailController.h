//
//  IibayExerDetailController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTIibayExerDetailController : SDBaseController
//题库ID
@property (nonatomic,strong) NSString *libaryIdStr;
// 数据源
@property (nonatomic,strong) NSDictionary *nowDataDict;
//  顺序练习 练习状态
@property (nonatomic,strong) NSString *sequentPracStatus;
// 正确题数
@property (nonatomic,strong) NSString *succeedStr;
// 错误题数
@property (nonatomic,strong) NSString *errorStr;
// 做了多少题
@property (nonatomic,strong) NSString *doNumStr;
// 完成度
@property (nonatomic,strong) NSString *percentStr;


@end


