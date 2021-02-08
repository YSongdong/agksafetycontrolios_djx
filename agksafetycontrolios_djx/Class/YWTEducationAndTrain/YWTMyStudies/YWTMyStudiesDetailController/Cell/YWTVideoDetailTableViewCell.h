//
//  VideoDetailTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTVideoDetailTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

+(CGFloat) getWithHeightCell:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
