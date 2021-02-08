//
//  AnswerCardCollectionViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "TempDetailQuestionModel.h"

@interface YWTAnswerCardCollectionViewCell : UICollectionViewCell

// 当前题号
@property (nonatomic,strong) NSString *questId;
// 题号
@property (nonatomic,strong) NSString *questNumber;

@property (nonatomic,strong) QuestionListModel *model;

@property (nonatomic,strong) ListModel *listModel;

@end


