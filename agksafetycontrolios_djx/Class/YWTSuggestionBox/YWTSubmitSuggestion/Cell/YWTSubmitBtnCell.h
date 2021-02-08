//
//  YWTSubmitBtnCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YWTSubmitBtnCellDelegate <NSObject>
-(void) selectSubmitCellBtn;
@end

@interface YWTSubmitBtnCell : UITableViewCell

@property (nonatomic,weak) id <YWTSubmitBtnCellDelegate> delegate;

@end


