//
//  LibayExerDetaModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLibayExerDetaModel : NSObject <YYModel>
//题库ID
@property (nonatomic,copy) NSString *Id;
//题库名称
@property (nonatomic,copy) NSString *title;
//题库展示缩略图片
@property (nonatomic,copy) NSString *thumbImgUrl;
//题库展示源图片
@property (nonatomic,copy) NSString *sourceImgUrl;
//题库题目数量
@property (nonatomic,copy) NSString *totalNum;
//题库分类
@property (nonatomic,copy) NSString *catName;
//题库描述
@property (nonatomic,copy) NSString *descr;
//题库修改时间
@property (nonatomic,copy) NSString *updateTime;
//题库标签
@property (nonatomic,copy) NSString *tagTitle;
//学习进度
@property (nonatomic,copy) NSString *rateStudy;
// 做了多少题
@property (nonatomic,copy) NSString *doNum;
// 完成度
@property (nonatomic,strong) NSString *percentStr;
@end

NS_ASSUME_NONNULL_END
