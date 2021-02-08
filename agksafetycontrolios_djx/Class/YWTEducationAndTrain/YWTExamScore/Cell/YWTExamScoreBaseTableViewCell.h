//
//  ExamScoreBaseTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum {
    showExamScoreCellExerType = 0,   //练习
    showExamScoreCellExamPaperType ,  // 考试
}showExamScoreCellType;


@interface YWTExamScoreBaseTableViewCell : UITableViewCell

@property (nonatomic,assign)showExamScoreCellType cellType;

@property (nonatomic,strong) NSDictionary *dict ;

@end


