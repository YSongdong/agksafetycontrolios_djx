//
//  BaseHeaderSearchView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseHeaderSearchView.h"

@interface YWTBaseHeaderSearchView ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *clearBtn;

@end

@implementation YWTBaseHeaderSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderSearchView];
    }
    return self;
}
-(void) createHeaderSearchView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewF0F0BackGrounpWhiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [self addGestureRecognizer:tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor =  [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    UITapGestureRecognizer *tapBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTapBgView)];
    [bgView addGestureRecognizer:tapBgView];
    self.bgView = bgView;
   
    self.searchImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.searchImageV];
    self.searchImageV.image = [UIImage imageNamed:@"sjlb_ico_search"];
    self.searchImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset((KScreenW-24)/3);
        make.width.equalTo(@(KSIphonScreenW(20)));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.searchTextField  = [[UITextField alloc]init];
    [bgView addSubview:self.searchTextField];
    self.searchTextField.textColor = [UIColor colorCommonBlackColor];
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入资源名称搜索" attributes:@{NSForegroundColorAttributeName:[UIColor colorCommonGreyBlackColor]}];
    self.searchTextField.font = Font(14);
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.searchImageV.mas_right).offset(KSIphonScreenW(10));
        make.right.height.equalTo(bgView);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.clearBtn];
    [self.clearBtn setImage:[UIImage imageNamed:@"sjlb_ico_delete"] forState:UIControlStateNormal];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    [self.clearBtn addTarget:self action:@selector(selectClearBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn.hidden =  YES;
    
    self.bgView = bgView;
}

-(void) selectClearBtn:(UIButton *) sender{
    self.searchTextField.text = @"";
}
-(void)selectTapBgView{
    __weak typeof(self) weakSelf = self;
    // 进入开始编辑
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        [weakSelf.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(10));
        }];
        // 获取焦点
        [weakSelf.searchTextField becomeFirstResponder];
        // 显示清除按钮
        weakSelf.clearBtn.hidden = NO;
    }];
}
-(void) selectTap{
    __weak typeof(self) weakSelf = self;
    // 结束编辑
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        if ([weakSelf.searchTextField.text isEqualToString:@""]) {
            // 更新约束
            [weakSelf.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.bgView).offset((KScreenW-24)/3);
            }];
        }else{
            [weakSelf.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(10));
            }];
        }
        // 获取焦点
        [weakSelf.searchTextField resignFirstResponder];
        // 显示清除按钮
        weakSelf.clearBtn.hidden = YES;
    }];
}

// 文本字段将成为第一响应者
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    __weak typeof(self) weakSelf = self;
    // 进入开始编辑
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        [weakSelf.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(10));
        }];
        // 显示清除按钮
        weakSelf.clearBtn.hidden = NO;
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        __weak typeof(self) weakSelf = self;
        // 结束编辑时
        [UIView animateWithDuration:0.25 animations:^{
            // 更新约束
            if (!self.isExamCenterRcord) {
                [weakSelf.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(weakSelf.bgView).offset((KScreenW-24)/3);
                }];
            }else{
                [weakSelf.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(weakSelf.bgView).offset((KScreenW-24)/5);
                }];
            }
        }];
    }
    // 显示清除按钮
    self.clearBtn.hidden = YES;
}

// 点击搜索按钮
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    self.searchBlock(textField.text);
    return YES;
}
-(void)setIsExamCenterRcord:(BOOL)isExamCenterRcord{
    _isExamCenterRcord = isExamCenterRcord;
}



@end
