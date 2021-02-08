//
//  ExamPaperScoreTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showCellExamScoreExerType = 0,   //练习
    showCellExamScoreExamPaperType ,  // 考试
}showCellExamScoreType;


@interface YWTExamPaperScoreTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict ;

// 类型
@property (nonatomic,assign) showCellExamScoreType cellScoreType;
// 点击重新练习
@property (nonatomic,copy) void(^selectAgainExamBlock)(void);
// 点击查看详情
@property (nonatomic,copy) void(^detailBlock)(void);


@end

NS_ASSUME_NONNULL_END
