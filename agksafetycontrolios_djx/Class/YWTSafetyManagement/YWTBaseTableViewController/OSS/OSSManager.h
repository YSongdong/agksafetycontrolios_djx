//
//  OSSManager.h
//  AliyunOSSSDK-iOS-Example
//
//  Created by huaixu on 2018/10/23.
//  Copyright © 2018 aliyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>

NS_ASSUME_NONNULL_BEGIN

/// 上传回调
typedef void(^uploadCallblock)(BOOL success, NSString* msg ,NSError *error);

@interface OSSManager : NSObject

@property (nonatomic, strong) OSSClient *defaultClient;

@property (nonatomic, strong) OSSClient *imageClient;

@property (nonatomic, strong) OSSPutObjectRequest *normalUploadRequest;
// 数据源
@property (nonatomic, strong) NSDictionary *oSSDataDict;

+ (instancetype)sharedManager;

- (void)asyncPutImage:(NSString *)objectKey uploadFilePath:(NSData*)filePath success:(void (^)(id _Nullable result))success failure:(void (^)(NSError * _Nonnull error))failure;
// 多文件上传
- (void)uploadfilePathDict:(NSArray *)pathArr isAsync:(BOOL)isAsync callback:(uploadCallblock)callback;


@end

NS_ASSUME_NONNULL_END
