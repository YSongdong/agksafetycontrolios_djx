//
//  YWTBtnOperationAreaView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTBtnOperationAreaView.h"

@implementation YWTBtnOperationAreaView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBtnView];
    }
    return self;
}
-(void) createBtnView{
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    WS(weakSelf);
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.commentBtn];
    [self.commentBtn setImage:[UIImage imageNamed:@"party_list_comment"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:@" 评论" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = Font(13);
    [self.commentBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorViewBackGrounpWhiteColor]] forState:UIControlStateNormal];
    [self.commentBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#dbdbdb"]] forState:UIControlStateHighlighted];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
    }];
    [self.commentBtn addTarget:self action:@selector(selectCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *lineImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"party_detail_line"]];
    [self addSubview:lineImageV];
    [lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.commentBtn.mas_right);
        make.width.equalTo(@1);
        make.centerY.equalTo(weakSelf.commentBtn.mas_centerY);
    }];
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.likeBtn];
    [self.likeBtn setImage:[UIImage imageNamed:@"party_list_like"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"party_list_selectLike"] forState:UIControlStateSelected];
    [self.likeBtn setTitle:@" 点赞" forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateSelected];
    self.likeBtn.titleLabel.font = Font(13);
    [self.likeBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorViewBackGrounpWhiteColor]] forState:UIControlStateNormal];
    [self.likeBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#dbdbdb"]] forState:UIControlStateHighlighted];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineImageV.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.commentBtn);
        make.centerY.equalTo(weakSelf.commentBtn.mas_centerY);
    }];
    [self.likeBtn addTarget:self action:@selector(selectLickAction:) forControlEvents:UIControlEventTouchUpInside];
}

//
-(void) selectCommentAction:(UIButton *) sender{
    if ([self.delegate respondsToSelector:@selector(selectOPerateMenuOperateType:)]) {
        [self.delegate selectOPerateMenuOperateType:YWTOperateTypeComment];
    }
}
//
-(void) selectLickAction:(UIButton *) sender{
   if ([self.delegate respondsToSelector:@selector(selectOPerateMenuOperateType:)]) {
        [self.delegate selectOPerateMenuOperateType:YWTOperateTypeLike];
    }
}



@end
