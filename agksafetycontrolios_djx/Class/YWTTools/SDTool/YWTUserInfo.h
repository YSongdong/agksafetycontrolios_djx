//
//  SDUserInfo.h
//  CSSiteControl
//
//  Created by tiao on 2018/10/22.
//  Copyright © 2018年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTUserInfo : NSObject

//保存用户数据
+(void) saveUserData:(NSDictionary *)data;

//删除用户信息
+(void) delUserInfo;

//判断是否登录
+(BOOL) passLoginData;

// ----------------修改数据----------
//绑定手机
+(void) alterIsBindPhone:(NSDictionary *)dict;
//修改用户信息
+(void) alterUserInfoDictionary:(NSDictionary *)dict;
//修改用户头像审核状态
+(void) alterUserHeaderFaceChenkStatu:(NSString *)vFaceStr;
// 修改用户学分
+(void) alterUserCreditStr:(NSString *)CreditStr;
// ----------------取出数据----------
//获取 用户id
+(NSString *) obtainWithUserId;
//获取realName
+(NSString *) obtainWithRealName;
//获取账号
+(NSString *) obtainWithSN;
//获取性别
+(NSString *) obtainWithSex;
//获取公司名称
+(NSString *) obtainWithCompany;
//获取公司名称id
+(NSString *) obtainWithCompanyId;
//获取电话
+(NSString *) obtainWithMobile;
//获取手机是否绑定
+(NSString *) obtainWithVMobile;
//获取 token
+(NSString *) obtainWithToken;
//获取 vFace
+(NSString *) obtainWithVFace;
//获取 人脸照片
+(NSString *) obtainWithPhoto;
//获取首页配置数组
+(NSArray *) obtainWithModuleConfig;
//获取登陆次数
+(NSString *) obtainWithLoginCount;
//获取登陆平台码
+(NSString *) obtainWithLoginPlatformCode;
//获取登陆平台名称
+(NSString *) obtainWithLoginPlatformName;
//获取我的学分
+(NSString *) obtainWithCredit;





@end

NS_ASSUME_NONNULL_END
