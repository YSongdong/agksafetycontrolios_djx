//
//  KRMainNetTool.h
//  Dntrench
//
//  Created by kupurui on 16/10/19.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <UIKit/UIKit.h>
@interface KRMainNetTool : NSObject
singleton_interface(KRMainNetTool)
/**
 *  上传文件的接口方法
 */
- (void)upLoadData:(NSString *)url params:(NSDictionary *)param andData:(NSArray *)array complateHandle:(void(^)(id showdata,NSString *error))complet;
/**
 *  post   需要显示加载动画的接口方法 不上传文件
 */
- (void)postRequstWith:(NSString *)url params:(NSDictionary *)dic withModel:(Class)model waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet;
/**
 *  get  需要显示加载动画的接口方法
 */
- (void)getRequstWith:(NSString *)url params:(NSDictionary *)dic withModel:(Class)model waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet;
/**
 *  需要显示加载动画的接口方法 上传文件 (多张张图片)
 */
- (void)upLoadData:(NSString *)url params:(NSDictionary *)param andData:(NSArray *)array waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet;

/**
 *  需要显示加载动画的接口方法 上传文件 (单张张图片)
 */
- (void)upLoadPhotoUrl:(NSString *)url params:(NSDictionary *)param photo:(UIImage*)photoImage waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet;


+ (void)ysy_hasNetwork:(void(^)(NSString *net))hasNet;
@end
