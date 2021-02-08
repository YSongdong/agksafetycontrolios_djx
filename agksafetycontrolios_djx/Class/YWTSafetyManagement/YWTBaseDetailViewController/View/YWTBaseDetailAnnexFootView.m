//
//  BaseDetailAnnexFootView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTBaseDetailAnnexFootView.h"

@interface YWTBaseDetailAnnexFootView  ()
// 撤销按钮
@property (nonatomic,strong) UIButton *footRevokeBtn;
// 修改按钮
@property (nonatomic,strong) UIButton *footAlterBtn;
@end


@implementation YWTBaseDetailAnnexFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createFootView];
    }
    return self;
}
-(void) createFootView{
    __weak typeof(self) weakSelf = self;
    
    // 撤销
    self.footRevokeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.footRevokeBtn];
    [self.footRevokeBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [self.footRevokeBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.footRevokeBtn.titleLabel.font = Font(15);
    self.footRevokeBtn.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [self.footRevokeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(weakSelf);
    }];
    [self.footRevokeBtn addTarget:self action:@selector(selectRevokeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改
    self.footAlterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.footAlterBtn];
    [self.footAlterBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.footAlterBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.footAlterBtn.titleLabel.font = Font(15);
    self.footAlterBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [self.footAlterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.footRevokeBtn.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.footRevokeBtn);
        make.centerY.equalTo(weakSelf.footRevokeBtn.mas_centerY);
    }];
    [self.footAlterBtn addTarget:self action:@selector(selectAlterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 撤销按钮
    NSString *revokedoStr = [NSString stringWithFormat:@"%@",dict[@"revokedoIs"]];
    // 修改按钮
    NSString *changedoStr = [NSString stringWithFormat:@"%@",dict[@"changedoIs"]];
    __weak typeof(self) weakSelf = self;
    // 只显示 撤销按钮
    if ([revokedoStr isEqualToString:@"1"] && [changedoStr isEqualToString:@"0"]) {
        // 隐藏修改按钮
        self.footAlterBtn.hidden = YES;
        //
        self.footRevokeBtn.hidden = NO;
        // 更新UI
        [self.footRevokeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.right.equalTo(weakSelf);
        }];
    }else if ([revokedoStr isEqualToString:@"0"] && [changedoStr isEqualToString:@"1"]){
        // 隐藏修改按钮
        self.footRevokeBtn.hidden = YES;
        //
        self.footAlterBtn.hidden = NO;
        // 更新UI
        [self.footAlterBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.right.equalTo(weakSelf);
        }];
    }
}
// 撤销
-(void) selectRevokeBtn:(UIButton *) sender{
    self.selectRevokelsBtn();
}
// 修改
-(void) selectAlterBtn:(UIButton *) sneder{
    self.selelctAlterBtn();
}





@end
