//
//  BaseShowListModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseShowListModel : NSObject <YYModel>
// id
@property (nonatomic,copy) NSString *Id;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,strong) NSArray *tag;

@property (nonatomic,strong) NSArray *enclosure;
 // 是否展开 YES 是  NO 不是
@property (nonatomic,assign) BOOL isExqand;
// 高度
@property (nonatomic,assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
