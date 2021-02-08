//
//  ShowSubmitExamView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowSubmitExamView.h"

@interface YWTShowSubmitExamView ()

@end


@implementation YWTShowSubmitExamView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubmitView];
    }
    return self;
}
-(void) createSubmitView{
    __weak typeof(self) weakSelf = self;
    
    UIView *backGrounpView = [[UIView alloc]init];
    [self addSubview:backGrounpView];
    backGrounpView.backgroundColor = [UIColor blackColor];
    backGrounpView.alpha = 0.35;
    [backGrounpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    [backGrounpView addGestureRecognizer:tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    [titleView addSubview:titleLab];
    titleLab.text = @"提交试卷";
    titleLab.textColor = [UIColor colorCommonBlackColor];
    titleLab.font = BFont(18);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.contentLab = [[UILabel alloc]init];
    [contentView addSubview:self.contentLab];
    self.contentLab.font = Font(14);
    self.contentLab.textColor = [UIColor colorCommonBlackColor];
    self.contentLab.numberOfLines = 0;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(30));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
   
    NSArray *questionArr =[[DataBaseManager sharedManager] selectAllApps];
    NSInteger answerNumber = 0;
    for (NSDictionary *dict in questionArr) {
        if (![dict[@"userAnswer"]isEqualToString:@""]) {
            answerNumber ++;
        }
    }
    NSString *titleStr = [NSString stringWithFormat:@"共有试题 %lu 题，已做 %ld 题，您确认要交卷吗？",(unsigned long)questionArr.count,(long)answerNumber];
    NSString *totalStr = [NSString stringWithFormat:@"%lu",(unsigned long)questionArr.count];
    NSString *answerStr = [NSString stringWithFormat:@"%ld",(long)answerNumber];
    
    self.contentLab.attributedText = [self getAttrbuteNameStr:titleStr andAlterTotalStr:totalStr answerStr:answerStr];
   

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(weakSelf.contentLab.mas_bottom).offset(KSIphonScreenH(10));
    }];
    
    UIView *bottomBtnView = [[UIView alloc]init];
    [bgView addSubview:bottomBtnView];
    bottomBtnView.backgroundColor = [UIColor colorLineCommonE9E9E9GreyBlackColor];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtnView addSubview:updateBtn];
    [updateBtn setTitle:@"继续答题" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = BFont(16);
    updateBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(bottomBtnView);
    }];
    [updateBtn addTarget:self action:@selector(selectContinueBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nowSubmitBtn = [[UIButton alloc]init];
    [bottomBtnView addSubview:nowSubmitBtn];
    [nowSubmitBtn setTitle:@"现在交卷" forState:UIControlStateNormal];
    [nowSubmitBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    nowSubmitBtn.titleLabel.font = BFont(16);
    nowSubmitBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [nowSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(updateBtn.mas_right).offset(1);
        make.right.equalTo(bottomBtnView);
        make.width.height.equalTo(updateBtn);
        make.centerY.equalTo(bottomBtnView.mas_centerY);
    }];
    [nowSubmitBtn addTarget:self action:@selector(selectSubmitExamBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(45));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(45));
        make.bottom.equalTo(bottomBtnView.mas_bottom);
    }];
    bgView.layer.cornerRadius = 7;
    bgView.layer.masksToBounds = YES;

}
// 取消
-(void)selectContinueBtn:(UIButton *) sender{
    [self removeFromSuperview];
}
-(void)removeView{
    [self selectContinueBtn:nil];
}
// 交卷
-(void)selectSubmitExamBtn:(UIButton*) sender{
    self.submitExamBlock();
}
// UILabel 富文本
/*
 nameStr : 传入的文字
 colorStr  : 要想修改的文字
 */
-(NSMutableAttributedString *) getAttrbuteNameStr:(NSString *)nameStr andAlterTotalStr:(NSString *)totalStr answerStr:(NSString *)answerStr{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:nameStr];
    NSRange range = NSMakeRange(5, totalStr.length);
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:range];
        // 设置斜体
//        [attributStr addAttribute:NSObliquenessAttributeName value:@0.25 range:range];
    }
   
    NSRange answerRange = NSMakeRange(5+6+totalStr.length, answerStr.length);
    if (answerRange.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#00c356"] range:answerRange];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:answerRange];
        // 设置斜体
//        [attributStr addAttribute:NSObliquenessAttributeName value:@0.25 range:answerRange];
    }
    return attributStr;
}
@end
