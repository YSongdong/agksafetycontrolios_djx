//
//  OSSAuthModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSSAuthModel : NSObject

@property (nonatomic,copy) NSString *AccessKeyId;

@property (nonatomic,copy) NSString *AccessKeySecret;

@property (nonatomic,copy) NSString *Expiration;

@property (nonatomic,copy) NSString *SecurityToken;

@property (nonatomic,copy) NSString *bucket;

@property (nonatomic,copy) NSString *endpoint;

// 单例
singtonInterface;

@end

NS_ASSUME_NONNULL_END
