//
//  YWTDetailCommentModel.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTDetailCommentModel : NSObject
// 文章id
@property (nonatomic, copy) NSString * Id;
// 评论人头像
@property (nonatomic, copy) NSString * photo;
//评论人姓名
@property (nonatomic, copy) NSString * realname;
// 评论人单位名
@property (nonatomic,copy) NSString *company;
// 评论
@property (nonatomic, copy) NSString * content;
// 评论人发布时间
@property (nonatomic, copy) NSString * createtime;
@end

NS_ASSUME_NONNULL_END
