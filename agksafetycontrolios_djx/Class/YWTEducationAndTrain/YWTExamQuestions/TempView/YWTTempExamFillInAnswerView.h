//
//  TempExamFillInAnswerView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTTempExamFillInAnswerView : UIView <UITextViewDelegate>

@property (nonatomic,strong) UIView *bgView ;

@property (nonatomic,strong) UILabel *placeLab;

@property (nonatomic,strong) UITextView *answerTextView;

//完成按钮
@property (nonatomic,copy) void(^frishBlock)(NSString *userAnswerStr);

@end

NS_ASSUME_NONNULL_END
