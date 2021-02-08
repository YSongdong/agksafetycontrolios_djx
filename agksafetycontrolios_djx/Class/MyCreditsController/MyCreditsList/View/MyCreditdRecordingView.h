//
//  MyCreditdRecordingView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCreditdRecordingView : UIView

// 我的分数
@property (nonatomic,copy) void(^myCreditsSetCount)(NSString *dataSetCountStr);

@end

NS_ASSUME_NONNULL_END
