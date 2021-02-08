//
//  YWTSelectBaseCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SelectBaseCellType){
    SelectBaseCellSelectType = 0,       // 选择类型
    SelectBaseCellAcceeptanceType       // 接受类型
};

@interface YWTSelectBaseCell : UITableViewCell
// 类型
@property (nonatomic,assign) SelectBaseCellType cellType;
// 提示lab
@property (nonatomic,strong) UILabel *placeholderLab;
// 正文
@property (nonatomic,strong) UILabel *baseLab;
@end


