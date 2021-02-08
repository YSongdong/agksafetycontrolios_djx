//
//  AnswerCardHeaderReusableView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnswerCardHeaderReusableView.h"

@interface YWTAnswerCardHeaderReusableView ()

@property (nonatomic,strong) UILabel *titleLab;

@property (nonatomic,strong) UIButton *headerSwitchBtn;

@end


@implementation YWTAnswerCardHeaderReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    
    __weak typeof(self) weakSelf = self;
    
    
    self.titleLab = [[UILabel alloc]init];
    [self addSubview:self.titleLab];
    self.titleLab.text = @"单选题";
    self.titleLab.textColor = [UIColor colorCommonBlackColor];
    self.titleLab.font = Font(16);
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    self.headerSwitchBtn = [[UIButton alloc]init];
    [self addSubview:self.headerSwitchBtn];
    [self.headerSwitchBtn setTitle:@"展开" forState:UIControlStateNormal];
    [self.headerSwitchBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
    [self.headerSwitchBtn setTitleColor:[UIColor colorCommonAAAAGreyBlackColor] forState:UIControlStateNormal];
    [self.headerSwitchBtn setImage:[UIImage imageNamed:@"ico_up"] forState:UIControlStateNormal];
    self.headerSwitchBtn.titleLabel.font = BFont(13);
    [self.headerSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(weakSelf);
        make.width.equalTo(@(KSIphonScreenW(70)));
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
    }];
    [self.headerSwitchBtn LZSetbuttonType:LZCategoryTypeLeft];
    
    [self.headerSwitchBtn addTarget:self action:@selector(selectSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];

    // 隐藏按钮
    self.headerSwitchBtn.hidden = YES;
}
-(void) selectSwitchBtn:(UIButton *) sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
       self.switchBtnBlcok(@"1");
    }else{
       self.switchBtnBlcok(@"2");
    }
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
   
    self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"key"]];
   
    NSArray *listArr = (NSArray *)dict[@"list"];
    if (listArr.count > 12) {
        self.headerSwitchBtn.hidden = NO;
    }else{
        self.headerSwitchBtn.hidden = YES;
    }
   // 点击  1展开 2 收起 按钮
    NSString *spreadStr = [NSString stringWithFormat:@"%@",dict[@"spread"]];
    if ([spreadStr isEqualToString:@"1"]) {
        [self.headerSwitchBtn setTitle:@"展开 " forState:UIControlStateNormal];
        [self.headerSwitchBtn setImage:[UIImage imageNamed:@"ico_up"] forState:UIControlStateNormal];
    }else{
        [self.headerSwitchBtn setTitle:@"收起 " forState:UIControlStateNormal];
        [self.headerSwitchBtn setImage:[UIImage imageNamed:@"ico_down"] forState:UIControlStateNormal];
    }
}
-(void)setModel:(SheetModel *)model{
    _model = model;
    NSString *titleStr;
    if ([model.key isEqualToString:@"1"]) {
        titleStr = @"单选题";
    }else if ([model.key isEqualToString:@"2"]){
        titleStr = @"多选题";
    }else if ([model.key isEqualToString:@"3"]){
        titleStr = @"判断题";
    }else if ([model.key isEqualToString:@"4"]){
        titleStr = @"问答题";
    }else if ([model.key isEqualToString:@"5"]){
        titleStr = @"填空题";
    }else if ([model.key isEqualToString:@"6"]){
        titleStr = @"主观题";
    }
    self.titleLab.text = titleStr;
    
    if (model.list.count > 12) {
        self.headerSwitchBtn.hidden = NO;
    }else{
        self.headerSwitchBtn.hidden = YES;
    }
    // 点击  1展开 2 收起 按钮
    NSString *spreadStr = [NSString stringWithFormat:@"%@",model.spread];
    if ([spreadStr isEqualToString:@"1"]) {
        self.headerSwitchBtn.selected = YES;
        [self.headerSwitchBtn setTitle:@"展开 " forState:UIControlStateNormal];
        [self.headerSwitchBtn setImage:[UIImage imageNamed:@"ico_up"] forState:UIControlStateNormal];
    }else{
        self.headerSwitchBtn.selected = NO;
        [self.headerSwitchBtn setTitle:@"收起 " forState:UIControlStateNormal];
        [self.headerSwitchBtn setImage:[UIImage imageNamed:@"ico_down"] forState:UIControlStateNormal];
    }
}

-(void)setHeaderMode:(showAnswerCardHeaderMode)headerMode{
    _headerMode = headerMode;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

@end
