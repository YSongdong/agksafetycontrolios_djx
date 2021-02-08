//
//  YWTOSSManager.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/10/28.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>
NS_ASSUME_NONNULL_BEGIN

/// 上传回调
typedef void(^uploadCallblock)(BOOL success, NSString* msg ,NSError *error);

@interface YWTOSSManager : NSObject
@property (nonatomic, strong) OSSClient *defaultClient;

@property (nonatomic, strong) OSSClient *imageClient;

@property (nonatomic, strong) OSSPutObjectRequest *normalUploadRequest;
// 数据源
@property (nonatomic, strong) NSDictionary *oSSDataDict;

+ (instancetype)sharedManager;
// 多文件上传
- (void)uploadfilePathDict:(NSArray *)pathArr isAsync:(BOOL)isAsync callback:(uploadCallblock)callback;
@end

NS_ASSUME_NONNULL_END
