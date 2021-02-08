//
//  ExamQuestBottomToolView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamQuestBottomToolView.h"

@implementation YWTExamQuestBottomToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createToolView];
    }
    return self;
}
-(void) createToolView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor  =[UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
    
    NSArray *titleArr = @[@"上一题",@"答题卡",@"设置",@"下一题"];
    NSArray *normalArr = @[@"sjlx_tab_ico_01",@"sjlx_tab_ico_02",@"sjlx_tab_ico_03",@"sjlx_tab_ico_04"];
    NSArray *highlightArr = @[@"tab_exam_left_sel",@"tab_exam_card_sel",@"tab_exam_setting_sel",@"tab_exam_right_sel"];
    for (int i= 0; i<titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(KScreenW/titleArr.count), 1, KScreenW/titleArr.count, self.frame.size.height)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:normalArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageChangeName:highlightArr[i]] forState:UIControlStateHighlighted];
        btn.titleLabel.font = Font(11);
        btn.tag = 100+i;
        btn.backgroundColor = [UIColor colorTextWhiteColor];
        [btn LZSetbuttonType:LZCategoryTypeBottom];
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
}
-(void) selectBtnAction:(UIButton *) sender{
    switch (sender.tag -100) {
        case 0:{
            self.lastQuestBlock();
            break;
        }
        case 1:{
            self.answerCardBlock();
            break;
        }
        case 2:{
            self.settingBlcok();
            break;
        }
        case 3:{
            self.nextQuestBlock();
            break;
        }
        default:
            break;
    }
}



@end
