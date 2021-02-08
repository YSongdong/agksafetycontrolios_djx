//
//  UIViewController+Extension.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/30.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)
//  监控规则数组
@property (nonatomic,copy) NSArray *monitorRules;
/**
 判断是否开启人脸验证
 @param   montiorStr  传入规则方法名
 @return  返回人脸验证规则  如果为空key  表示没有规则
 */
-(NSDictionary *) createFaveVerificationStr:(NSString *)montiorStr;
/**
 通过规则进行人脸验证
 @param faceVeriDict 规则字典
 */
-(void) passRulesConductFaceVeri:(NSDictionary *)faceVeriDict;
//
-(void)returnFaceSuccessImage:(NSDictionary *)dict;
-(void) codeTimeOut;
-(void) closeViewControll;

@end

NS_ASSUME_NONNULL_END
