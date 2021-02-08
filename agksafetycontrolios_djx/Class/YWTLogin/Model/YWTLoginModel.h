//
//  LoginModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLoginModel : NSObject
// 用户id
@property (nonatomic,copy) NSString *userId;
// 账号
@property (nonatomic,copy) NSString *sn;
// 真实姓名
@property (nonatomic,copy) NSString *realName;
// 公司名称
@property (nonatomic,copy) NSString *company;
// 公司id
@property (nonatomic,copy) NSString *companyId;
// 电话
@property (nonatomic,copy) NSString *mobile;
// 1男 2女
@property (nonatomic,copy) NSString *sex;
// 1认证，2未认证
@property (nonatomic,copy) NSString *vMobile;
//
@property (nonatomic,copy) NSString *token;
// 1认证，2未认证 3是认证不通过 4审核中
@property (nonatomic,copy) NSString *vFace;
// 登陆次数
@property (nonatomic,copy) NSString *loginCount;
// 人脸照片
@property (nonatomic,copy) NSString *photo;
// 配置
@property (nonatomic,strong) NSArray *moduleConfig;
// 平台码
@property (nonatomic,copy) NSString *platformCode;
// 平台名称
@property (nonatomic,copy) NSString *platformName;
// 身份证
@property (nonatomic,copy) NSString *idCard;


@end

NS_ASSUME_NONNULL_END
