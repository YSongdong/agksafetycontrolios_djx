//
//  YWTSelectUnitController.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWTBaseSelectConstant.h"
#import "SDBaseController.h"

@protocol YWTSelectUnitControllerDelegate <NSObject>
//选中的Id
-(void) selectSelectUnitTargetIdStr:(NSString*)targetId targetName:(NSString*)targeName;

@end


@interface YWTSelectUnitController : SDBaseController

@property (nonatomic,weak) id <YWTSelectUnitControllerDelegate> delegate;

@property (nonatomic,assign) SelectType selectType;

@end


