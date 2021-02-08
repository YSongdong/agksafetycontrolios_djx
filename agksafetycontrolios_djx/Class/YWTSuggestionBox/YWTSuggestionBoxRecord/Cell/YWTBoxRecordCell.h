//
//  YWTBoxRecordCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/18.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SuggestionBoxListBoxCellType = 0,  // 发起意见
    SuggestionBoxReplyBoxCellType ,    // 回复意见
}SuggestionRecordBoxCellType;

@interface YWTBoxRecordCell : UITableViewCell

@property (nonatomic,assign) SuggestionRecordBoxCellType cellType;

@property (nonatomic,strong) NSDictionary *dict;

@end


