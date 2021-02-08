//
//  YWTSubimtOpinionCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSubimtOpinionCell.h"

@implementation YWTSubimtOpinionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createOpinionCell];
    }
    return self;
}
-(void) createOpinionCell{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.fsTextView = [[FSTextView alloc]init];
    [self addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入意见内容";
    self.fsTextView.placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.fsTextView.textColor = [UIColor colorCommonBlackColor];
    self.fsTextView.font = Font(13);
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    self.fsTextView.delegate = self;
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(15));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(15));
    }];
    
    UIView *lineView =[[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark --- UITextViewDelegate -----
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [self endEditing:YES];
        return NO;
    }
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
