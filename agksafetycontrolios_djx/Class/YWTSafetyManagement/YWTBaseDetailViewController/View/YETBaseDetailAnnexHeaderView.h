//
//  BaseDetailAnnexHeaderView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YETBaseDetailAnnexHeaderView : UIView

@property (nonatomic,strong) NSDictionary *dict;
// 计算高度
+(CGFloat) getWithAnnexHeaderHeight:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
