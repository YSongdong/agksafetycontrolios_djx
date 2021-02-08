//
//  QuestTypeCollectionViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTQuestTypeCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
