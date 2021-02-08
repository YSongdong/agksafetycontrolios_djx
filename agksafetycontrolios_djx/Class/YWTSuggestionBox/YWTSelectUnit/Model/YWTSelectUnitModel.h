//
//  YWTSelectUnitModel.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/10/14.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWTSelectUnitModel : NSObject <YYModel>

@property (nonatomic,copy) NSString *Id;

@property (nonatomic,copy) NSString *unitName;

@property (nonatomic,copy) NSString *identity;

@property (nonatomic,copy) NSString *end;

@property (nonatomic,copy) NSString *userid;

@property (nonatomic,copy) NSString *realname;

@property (nonatomic,copy) NSString *company;

@property (nonatomic,copy) NSString *photo;

//  是不是选中  YES 选中 NO
@property (nonatomic,assign) BOOL  isSelect;

@end

