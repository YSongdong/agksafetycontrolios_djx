//
//  YWTOSSManager.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/10/28.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTOSSManager.h"
#import "OSSAuthModel.h"
#import "YWTAddModel.h"

@implementation YWTOSSManager

+ (instancetype)sharedManager {
    static YWTOSSManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[YWTOSSManager alloc] init];
    });
    
    return _manager;
}

-(void)setOSSDataDict:(NSDictionary *)oSSDataDict{
    _oSSDataDict = oSSDataDict;
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
    
    NSMutableArray *annexArr = [NSMutableArray arrayWithArray:pathArr];
    // 移除最后一个
    [annexArr removeLastObject];
    for (int i=0; i<annexArr.count; i++) {
        YWTAddModel *model = annexArr[i];
        NSData *fileData = model.fileData;
        // 做键值对
        [keyNames addObject:model.fileName];
        if (fileData) {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //任务执行
                OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                put.bucketName = [OSSAuthModel shareInstance].bucket;
                // 文件名
                NSString *dateString = model.objectKey;
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
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        if (callback) {
            callback( YES, @"全部上传完成" , error);
        }
    }
}

@end
