//
//  YWTSelectUnitHeaderView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWTSelectUnitHeaderView : UIView

@property (nonatomic,strong) YYLabel *nameLab;

@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic,copy) void(^selectUnit)(NSString *parentIdStr);

// 计算高度
+(CGFloat) getSelectUnitHeaderViewHgith:(NSArray*)titleArr;

@end

