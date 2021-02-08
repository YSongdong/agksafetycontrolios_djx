//
//  YWTAddModel.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/6.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAddModel : NSObject
// 封面
@property (nonatomic,copy) UIImage *photoImege;
// 名称
@property (nonatomic,copy) NSString *fileName;
// 类型
@property (nonatomic,copy) NSString *objectKey;
// 
@property (nonatomic,copy) NSString *typeName;

@property (nonatomic,copy) NSString *type;
// 地址
@property (nonatomic,copy) NSString *urlStr;
// data
@property (nonatomic,copy) NSData *fileData;

@end

NS_ASSUME_NONNULL_END
