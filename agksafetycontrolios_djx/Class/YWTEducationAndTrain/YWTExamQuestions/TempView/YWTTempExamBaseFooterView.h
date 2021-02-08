//
//  TempExamBaseFooterView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/24.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TempDetailQuestionModel.h"

@interface YWTTempExamBaseFooterView : UIView

@property (nonatomic,strong) QuestionListModel *footModel;

//计算高度
+(CGFloat)getLabelHeightWithDict:(QuestionListModel *)footModel;

@end


