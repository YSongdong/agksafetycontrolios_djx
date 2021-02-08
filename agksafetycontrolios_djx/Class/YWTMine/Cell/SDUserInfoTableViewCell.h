//
//  SDUserInfoTableViewCell.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDUserInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,strong) NSIndexPath *indexPath;

//点击退出按钮
@property (nonatomic,copy) void(^leaveBtnBlock)(NSIndexPath *indexPath);

//修改会员账号
-(void) alterVipNameStr:(NSString *) nameStr;


@end
