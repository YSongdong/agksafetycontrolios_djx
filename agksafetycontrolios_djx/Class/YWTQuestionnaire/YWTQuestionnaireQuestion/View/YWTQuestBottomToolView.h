//
//  YWTQuestBottomToolView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YWTQuestBottomToolViewDelegate <NSObject>
// 上一题
-(void) selectBottomLastQuest;
// 下一题
-(void) selectBottomNextQuest;
@end

@interface YWTQuestBottomToolView : UIView

@property (nonatomic,weak) id <YWTQuestBottomToolViewDelegate> delegate;

// 上一题
@property (nonatomic,strong) UIButton *lastQuestBtn;
// 下一题
@property (nonatomic,strong) UIButton *nextQuestBtn;

@end

