//
//  OSSManager.m
//  AliyunOSSSDK-iOS-Example
//
//  Created by huaixu on 2018/10/23.
//  Copyright © 2018 aliyun. All rights reserved.
//

#import "OSSManager.h"

#import "OSSAuthModel.h"

@implementation OSSManager

+ (instancetype)sharedManager {
    static OSSManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[OSSManager alloc] init];
    });
    
    return _manager;
}

-(void)setOSSDataDict:(NSDictionary *)oSSDataDict{
    _oSSDataDict = oSSDataDict;
}

- (void)asyncPutImage:(NSString *)objectKey uploadFilePath:(NSData*)filePath success:(void (^)(id _Nullable result))success failure:(void (^)(NSError * _Nonnull error))failure {
    if (![objectKey oss_isNotEmpty]) {
        NSError *error = [NSError errorWithDomain:NSInvalidArgumentException code:0 userInfo:@{NSLocalizedDescriptionKey: @"objectKey should not be nil"}];
        failure(error);
        return;
    }
    _normalUploadRequest = [OSSPutObjectRequest new];
    NSString *bucketStr = [NSString stringWithFormat:@"%@",self.oSSDataDict[@"bucket"]];
    _normalUploadRequest.bucketName = bucketStr;
    _normalUploadRequest.objectKey = objectKey;
    _normalUploadRequest.uploadingData = filePath;
    _normalUploadRequest.isAuthenticationRequired = YES;
    _normalUploadRequest.callbackParam = @{
                                           @"callbackUrl": @"",
                                           // callbackBody可自定义传入的信息
                                           @"callbackBody": @"filename=${object}"
                                           };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        OSSTask * task = [[OSSManager sharedManager].defaultClient putObject:self.normalUploadRequest];
        [task continueWithBlock:^id(OSSTask *task) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (task.error) {
                    failure(task.error);
                } else {
                    success(nil);
                }
            });
            return nil;
        }];
    });
}

- (void)triggerCallbackWithObjectKey:(NSString *)objectKey success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSCallBackRequest *request = [OSSCallBackRequest new];
        NSString *bucketStr = [NSString stringWithFormat:@"%@",self.oSSDataDict[@"bucket"]];
        request.bucketName = bucketStr;
        request.objectName = objectKey;
        request.callbackParam = @{@"callbackUrl": @"",
                                  @"callbackBody": @"test"};
        request.callbackVar = @{@"var1": @"value1",
                                @"var2": @"value2"};
        
        OSSTask *triggerCBTask = [[OSSManager sharedManager].defaultClient triggerCallBack:request];
        [triggerCBTask waitUntilFinished];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (triggerCBTask.result) {
                success(triggerCBTask.result);
            } else {
                failure(triggerCBTask.error);
            }
        });
    });
}

// 多文件上传
- (void)uploadfilePathDict:(NSArray *)pathArr isAsync:(BOOL)isAsync callback:(uploadCallblock)callback {
     // 注册
     id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:[OSSAuthModel shareInstance].AccessKeyId secretKeyId:[OSSAuthModel shareInstance].AccessKeySecret securityToken:[OSSAuthModel shareInstance].SecurityToken];

        OSSClient *client = [[OSSClient alloc] initWithEndpoint:[OSSAuthModel shareInstance].endpoint credentialProvider:credential];
    
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = pathArr.count;
    
        NSMutableArray *keyNames = [NSMutableArray array];
        NSError *error;
        int i = 0;
        for (NSDictionary *dict in pathArr) {
            NSData *fileData = dict[@"filePath"];
            // 做键值对
            [keyNames addObject:dict[@"typeName"]];
            if (fileData) {
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    //任务执行
                    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                    put.bucketName = [OSSAuthModel shareInstance].bucket;
                    // 文件名
                    NSString *dateString = dict[@"objectKey"];
                    put.objectKey = dateString;
                    // 内容
                    put.uploadingData = fileData;
                    
                    OSSTask * putTask = [client putObject:put];
                    [putTask waitUntilFinished]; // 阻塞直到上传完成
                    if (!putTask.error) {
                        // 移除最后一个
                        [keyNames removeLastObject];
                    } else {
                        if (callback) {
                            // 取消任务
                            [put cancel];
                            callback( NO, @"上传失败" , putTask.error);
                            return ;
                        }
                    }
                    if (isAsync) {
                        if (keyNames.count == 0) {
                            if (callback) {
                                callback( YES, @"全部上传完成" , error);
                            }
                        }
                    }
                }];
                if (queue.operations.count != 0) {
                    [operation addDependency:queue.operations.lastObject];
                }
                [queue addOperation:operation];
            }
            i++;
        }
        if (!isAsync) {
            [queue waitUntilAllOperationsAreFinished];
            if (callback) {
                callback( YES, @"全部上传完成" , error);
            }
        }
}



@end
