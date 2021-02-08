//
//  YWTBaseSelectCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTBaseSelectConstant.h"
#import "YWTSelectUnitModel.h"

@protocol YWTBaseSelectCellDelegate <NSObject>
// 选中
-(void)selectBaseBtnIndexPath:(NSIndexPath*)indexPath isSelect:(BOOL)isSelect;

@end

@interface YWTBaseSelectCell : UITableViewCell

@property (nonatomic,weak) id <YWTBaseSelectCellDelegate> delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,assign) SelectType selectCellType;

@property (nonatomic,strong) YWTSelectUnitModel *model;

@end


