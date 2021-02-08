//
//  UIViewController+Extension.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/30.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "UIViewController+Extension.h"
 #import <objc/message.h>

//利用静态变量地址唯一不变的特性
static NSString *monitorRulesArrKey = @"monitorRulesArrKey";

@implementation UIViewController (Extension)

/**
 getter方法
 */
-(NSArray *)monitorRules{
    return objc_getAssociatedObject(self, &monitorRulesArrKey);
}
/**
 setter方法
 */
-(void)setMonitorRules:(NSArray *)monitorRules{
    objc_setAssociatedObject(self, &monitorRulesArrKey, monitorRules, OBJC_ASSOCIATION_COPY);
}

#pragma mark --------   人脸规则方法 ------------
/**
 判断是否开启人脸验证
 @param   montiorStr  传入规则方法名
 @return  返回人脸验证规则  如果为空key  表示没有规则
 */
-(NSDictionary *) createFaveVerificationStr:(NSString *)montiorStr{
    NSMutableDictionary *motionDict = [NSMutableDictionary dictionary];
    if (self.monitorRules.count == 0) {
        return motionDict;
    }
    for (NSDictionary *dict in self.monitorRules) {
        // 获取检测规则key
        NSString *ruleKeyStr = [NSString stringWithFormat:@"%@",dict[@"rule"]];
        if ([ruleKeyStr isEqualToString:montiorStr]) {
            motionDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            return motionDict;
        }
    }
    return motionDict;
}
/**
 通过规则进行人脸验证
 @param faceVeriDict 规则字典
 */
-(void) passRulesConductFaceVeri:(NSDictionary *)faceVeriDict{
    __weak typeof(self) weakSelf = self;
    if ([[FaceSDKManager sharedInstance] canWork]) {
        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    }
    NSString *motionStr = faceVeriDict[@"motion"];
    NSArray *motionArr = [self createFaceVierMotion:motionStr];
    if ([motionArr containsObject:[NSNumber numberWithInteger:10]]) {
        DetectionViewController* dvc = [[DetectionViewController alloc] init];
        SDRootNavigationController *navi = [[SDRootNavigationController alloc] initWithRootViewController:dvc];
        navi.navigationBarHidden = true;
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        //点击关闭视图
        dvc.closeViewControllBlock = ^{
            [weakSelf closeViewControll];
        };
        // 如果超时
        dvc.CodeTimeoutBlock = ^{
            [weakSelf codeTimeOut];
        };
        dvc.fackBlcok = ^(UIImage *image) {
            NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
            mutableDict[@"rule"] = [NSString stringWithFormat:@"%@",faceVeriDict[@"rule"]];
            mutableDict[@"faceSuccess"] = image;
            [weakSelf returnFaceSuccessImage:mutableDict.copy];
        };
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    LivenessViewController* lvc = [[LivenessViewController alloc] init];
    lvc.closeButton.hidden = YES;
    [[IDLFaceLivenessManager sharedInstance] livenesswithList:motionArr order:YES numberOfLiveness:0];
    SDRootNavigationController *navi = [[SDRootNavigationController alloc] initWithRootViewController:lvc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    // 超时
    lvc.CodeTimeoutBlock = ^{
        [weakSelf codeTimeOut];
    };
    // 点击关闭
    lvc.closeViewControllBlock = ^{
        [weakSelf closeViewControll];
    };
    // 采集成功
    lvc.fackBlcok = ^(UIImage *image) {
         NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
         mutableDict[@"rule"] = [NSString stringWithFormat:@"%@",faceVeriDict[@"rule"]];
         mutableDict[@"faceSuccess"] = image;
         [weakSelf returnFaceSuccessImage:mutableDict.copy];
    };
    [self presentViewController:navi animated:YES completion:nil];
}
-(NSArray *) createFaceVierMotion:(NSString *)motionStr{
    NSMutableArray *liveActionArr = [NSMutableArray array];
    NSArray *motionArr = [motionStr componentsSeparatedByString:@","];
    for (int i=0; i<motionArr.count; i++) {
        NSString *str = motionArr[i];
        [liveActionArr addObject:[NSNumber numberWithInteger:[str integerValue]]];
    }
    return liveActionArr.copy;
}

-(void)returnFaceSuccessImage:(NSDictionary *)dict{
    
    
}
-(void) codeTimeOut{
    
    
}
-(void)closeViewControll{
    
}

@end
