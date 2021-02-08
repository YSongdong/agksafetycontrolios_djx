//
//  YWTPartyEemberAreaModel.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTPartyEemberAreaModel : NSObject <YYModel>
// 文章id
@property (nonatomic, copy) NSString * Id ;
// 1 已点赞 2未点赞
@property (nonatomic, copy) NSString * give;
// 1纯文章 2文章加图片 3文章加视频
@property (nonatomic, copy) NSString * types;
// 正文
@property (nonatomic, copy) NSString * content;
// 发布时间戳
@property (nonatomic, copy) NSString * createtime;
// 头像
@property (nonatomic,copy) NSString *photo;
// 名字
@property (nonatomic, copy) NSString * realname;
// 用户单位名
@property (nonatomic, copy) NSString * company;
// 视频预览图
@property (nonatomic, copy) NSString * preview;
// 文章浏览数
@property (nonatomic,strong) NSString *visitornum;
// 文章点赞数
@property (nonatomic,strong) NSString *clickNum;
// 文章回复数
@property (nonatomic,strong) NSString *replynum;
// 文件地址集合
@property (nonatomic, strong) NSArray * filelist;
// 显示'全文'/'收起'
@property (nonatomic, assign) BOOL isFullText;

// 单张图片的宽度（用于预设视图尺寸）
@property (nonatomic, assign) CGFloat singleWidth;
// 单张图片的高度（用于预设视图尺寸）
@property (nonatomic, assign) CGFloat singleHeight;
//对应cell高度
@property (nonatomic, assign) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
