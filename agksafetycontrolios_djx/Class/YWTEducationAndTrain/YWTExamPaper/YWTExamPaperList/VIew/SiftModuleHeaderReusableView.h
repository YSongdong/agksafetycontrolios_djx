//
//  SiftModuleHeaderReusableView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SiftModuleHeaderReusableView : UICollectionReusableView
// title
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
