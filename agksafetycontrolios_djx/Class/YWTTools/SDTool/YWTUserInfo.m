//
//  SDUserInfo.m
//  CSSiteControl
//
//  Created by tiao on 2018/10/22.
//  Copyright © 2018年 wutiao. All rights reserved.
//

#import "YWTUserInfo.h"

@implementation YWTUserInfo
//保存用户数据
+(void) saveUserData:(NSDictionary *)data{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:data forKey:@"Login"];
    //3.强制让数据立刻保存
    [userD synchronize];
}
//删除用户信息
+(void) delUserInfo{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    //用户信息
    [userD removeObjectForKey:@"Login"];
    //3.强制让数据立刻保存
    [userD synchronize];
}
//判断是否登录
+(BOOL) passLoginData{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Login"]) {
        return YES;
    }else{
        return NO;
    }
}
// ----------------修改数据----------
//绑定手机
+(void) alterIsBindPhone:(NSDictionary *)dict{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"userId"] = dict[@"userId"];
    mutableDict[@"mobile"] = dict[@"mobile"];
    mutableDict[@"vMobile"] = dict[@"vMobile"];
    [YWTUserInfo saveUserData:mutableDict.copy];
}
//修改用户信息
+(void) alterUserInfoDictionary:(NSDictionary *)dict{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"realName"] = dict[@"realName"];
    mutableDict[@"sn"] = dict[@"sn"];
    mutableDict[@"company"] = dict[@"company"];
    mutableDict[@"sex"] = dict[@"sex"];
    mutableDict[@"mobile"] = dict[@"mobile"];
    mutableDict[@"vFace"] = dict[@"vFace"];
    mutableDict[@"vMobile"] = dict[@"vMobile"];
    mutableDict[@"photo"] = dict[@"photo"];
    [YWTUserInfo saveUserData:mutableDict.copy];
}
//修改用户头像审核状态
+(void) alterUserHeaderFaceChenkStatu:(NSString *)vFaceStr{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"vFace"] = vFaceStr;
    [YWTUserInfo saveUserData:mutableDict.copy];
}
// 修改用户学分
+(void) alterUserCreditStr:(NSString *)CreditStr{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"credit"] = CreditStr;
    [YWTUserInfo saveUserData:mutableDict.copy];
}

// -----------------取出数据---------
//获取 用户id
+(NSString *) obtainWithUserId{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *userIdStr = [NSString stringWithFormat:@"%@",dict[@"userId"]];
    return userIdStr;
}
//获取realName
+(NSString *) obtainWithRealName{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"realName"];
}
//获取账号
+(NSString *) obtainWithSN{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"sn"];
}
//获取性别
+(NSString *) obtainWithSex{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"sex"];
}
//获取公司名称
+(NSString *) obtainWithCompany{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"company"];
}
//获取公司名称id
+(NSString *) obtainWithCompanyId{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *companyIdStr = [NSString stringWithFormat:@"%@",dict[@"companyId"]];
    return companyIdStr;
}
//获取电话
+(NSString *) obtainWithMobile;{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *mobileStr = [NSString stringWithFormat:@"%@",dict[@"mobile"]];
    return mobileStr;
}
//获取手机是否绑定
+(NSString *) obtainWithVMobile{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *vMobileStr = [NSString stringWithFormat:@"%@",dict[@"vMobile"]];
    return vMobileStr;
}
//获取 token
+(NSString *) obtainWithToken{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"token"];
}
//获取 vFace
+(NSString *) obtainWithVFace{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *vFaceStr = [NSString stringWithFormat:@"%@",dict[@"vFace"]];
    return vFaceStr;
}
//获取 人脸照片
+(NSString *) obtainWithPhoto{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"photo"];
}
//获取首页配置数组
+(NSArray *) obtainWithModuleConfig{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSArray *moduleConfiggArr = dict[@"moduleConfig"];
    return moduleConfiggArr;
}
//获取登陆次数
+(NSString *) obtainWithLoginCount{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *loginCountStr = [NSString stringWithFormat:@"%@",dict[@"loginCount"]];
    return loginCountStr;
}
//获取登陆平台码
+(NSString *) obtainWithLoginPlatformCode{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *platformCodeStr = [NSString stringWithFormat:@"%@",dict[@"platformCode"]];
    return platformCodeStr;
}
//获取登陆平台名称
+(NSString *) obtainWithLoginPlatformName{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *platformCodeStr = [NSString stringWithFormat:@"%@",dict[@"platformName"]];
    return platformCodeStr;
}
//获取我的学分
+(NSString *) obtainWithCredit{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    NSString *platformCodeStr = [NSString stringWithFormat:@"%@",dict[@"credit"]];
    return platformCodeStr;
}




@end
