//
//  AnswerCardHeaderReusableView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 模式
 */
typedef enum {
    showAnswerCardHeaderAnswerMode = 0,   // 答题模式
    showAnswerCardHeaderDetailMode,       // 详情模式
}showAnswerCardHeaderMode;

#import "TempDetailQuestionModel.h"

@interface YWTAnswerCardHeaderReusableView : UICollectionReusableView

@property (nonatomic,assign) showAnswerCardHeaderMode headerMode;

// 点击  YES展开 NO 收起 按钮
@property (nonatomic,copy) void(^switchBtnBlcok)(NSString *spreadStr);

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,strong) SheetModel *model;


@end


