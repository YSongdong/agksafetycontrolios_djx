//
//  YWTOperateMenuView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTOperateMenuView.h"

@implementation YWTOperateMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createMenuView];
    }
    return self;
}
-(void) createMenuView{
    WS(weakSelf);
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.height.equalTo(@0.5);
    }];
    
    // 浏览数
    self.viewingCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.viewingCountBtn];
    [self.viewingCountBtn setTitle:@"11" forState:UIControlStateNormal];
    [self.viewingCountBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
    [self.viewingCountBtn setImage:[UIImage imageNamed:@"party_list_viewing"] forState:UIControlStateNormal];
    self.viewingCountBtn.titleLabel.font = Font(13);
    [self.viewingCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.bottom.equalTo(weakSelf);
    }];
    
    // 评论数
    self.commentCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.commentCountBtn];
    [self.commentCountBtn setTitle:@"11" forState:UIControlStateNormal];
    [self.commentCountBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
    [self.commentCountBtn setImage:[UIImage imageNamed:@"party_list_comment"] forState:UIControlStateNormal];
    self.commentCountBtn.titleLabel.font = Font(13);
    [self.commentCountBtn addTarget:self action:@selector(selectCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.viewingCountBtn.mas_right);
        make.width.height.equalTo(weakSelf.viewingCountBtn);
        make.centerY.equalTo(weakSelf.viewingCountBtn.mas_centerY);
    }];
    
    // 点赞数
    self.likeCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.likeCountBtn];
    [self.likeCountBtn setTitle:@"11" forState:UIControlStateNormal];
    [self.likeCountBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
    [self.likeCountBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateSelected];
    [self.likeCountBtn setImage:[UIImage imageNamed:@"party_list_like"] forState:UIControlStateNormal];
    [self.likeCountBtn setImage:[UIImage imageNamed:@"party_list_selectLike"] forState:UIControlStateSelected];
    self.likeCountBtn.titleLabel.font = Font(13);
    [self.likeCountBtn addTarget:self action:@selector(selectLikeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.likeCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.commentCountBtn.mas_right);
        make.width.height.equalTo(weakSelf.viewingCountBtn);
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.viewingCountBtn.mas_centerY);
    }];
}
-(void) selectLikeAction:(UIButton *) sender{
    self.selectLikeBtn();
}
-(void) selectCommentAction:(UIButton *) sender{
    self.selectCommentBtn();
}


@end
