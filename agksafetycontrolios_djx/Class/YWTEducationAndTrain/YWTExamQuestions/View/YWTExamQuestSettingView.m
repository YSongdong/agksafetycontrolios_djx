//
//  ExamQuestSettingView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamQuestSettingView.h"


@implementation YWTExamQuestSettingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSettingView];
    }
    return self;
}
-(void) createSettingView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.35;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [bgView addGestureRecognizer:tap];
    
    
    // 字体view
    UIView *fontView = [[UIView alloc]init];
    [self addSubview:fontView];
    fontView.backgroundColor  = [UIColor colorTextWhiteColor];
    [fontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(@(KSIphonScreenH(55)));
    }];
    // 标题view
    UIView *titleView = [[UIView alloc]init];
    [self addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fontView.mas_top);
        make.left.with.equalTo(fontView);
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.centerX.equalTo(fontView.mas_centerX);
    }];
    
    UILabel *showSettLab = [[UILabel alloc]init];
    [titleView addSubview:showSettLab];
    showSettLab.text = @"设置";
    showSettLab.textColor = [UIColor colorCommon65GreyBlackColor];
    showSettLab.font = Font(16);
    [showSettLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];

    UIButton *successBtn = [[UIButton alloc]init];
    [titleView addSubview:successBtn];
    [successBtn setTitle:@"完成" forState:UIControlStateNormal];
    [successBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    successBtn.titleLabel.font = Font(16);
    [successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(titleView);
        make.width.equalTo(@(KSIphonScreenW(60)));
    }];
    [successBtn addTarget:self action:@selector(selectSuccessBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc]init];
    [titleView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(titleView);
        make.height.equalTo(@1);
    }];
    
    // 字体view
    UILabel *showFontLab = [[UILabel alloc]init];
    [fontView addSubview:showFontLab];
    showFontLab.text = @"字体设置";
    showFontLab.textColor = [UIColor colorCommon65GreyBlackColor];
    showFontLab.font = Font(15);
    [showFontLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fontView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(fontView.mas_centerY);
    }];
    
    NSArray *titleArr = @[@"特大",@"加大",@"正常",@"小号"];
    NSArray *fontArr = @[@"18",@"15",@"14",@"13"];
    for (int i=0; i< titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [fontView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(fontView).offset(-(i*KSIphonScreenW(60)));
            make.top.bottom.equalTo(fontView);
            make.width.equalTo(@(KSIphonScreenW(60)));
        }];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorCommon65GreyBlackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = Font([fontArr[i]integerValue]);
        btn.tag = 100 +i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==2) {
            [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
            self.pageTag = btn.tag;
        }
    }
    
    NSUserDefaults *fontDef =[NSUserDefaults standardUserDefaults];
    if ([fontDef objectForKey:@"Font"]) {
        NSDictionary *dict =[fontDef objectForKey:@"Font"];
        NSString *fontStr = dict[@"SettingView"];
        switch ([fontStr integerValue]) {
            case 17:
            {  // 特大
                [self alterBtnStatuTag:100];
                break;
            }
            case 14:
            { // 加大
                [self alterBtnStatuTag:101];
                break;
            }
            case 13:
            {  // 正常
                [self alterBtnStatuTag:102];
                break;
            }
            case 12:
            { // 小号
                [self alterBtnStatuTag:103];
                break;
            }
            default:
                break;
        }
    }
}
-(void)selectBtn:(UIButton *) sender{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.pageTag == sender.tag) {
        return ;
    }
    switch (sender.tag - 100) {
        case 0:
        { // 特大
            // 标题
            param[@"SubjectFont"] = @"23";
            // 当前第几天
            param[@"NowQuestFont"] = @"19";
            // 总共多少题
            param[@"TotalQuestFont"] = @"16";
            // 题目
            param[@"TitleQuestFont"] = @"21";
            // 答题
            param[@"AnswerFont"] = @"20";
            // 解析
            param[@"Footer"] = @"20";
            // 设置
            param[@"SettingView"] = @"17";
            
            [userD setObject:param.copy forKey:@"Font"];
            //3.强制让数据立刻保存
            [userD synchronize];
            
            [self alterBtnStatuTag:sender.tag];
            // 刷新视图
            self.refreshViewBlock();
            break;
        }
        case 1:
        { // 加大
            // 标题
            param[@"SubjectFont"] = @"21";
            // 当前第几天
            param[@"NowQuestFont"] = @"17";
            // 总共多少题
            param[@"TotalQuestFont"] = @"14";
            // 题目
            param[@"TitleQuestFont"] = @"19";
            // 答题
            param[@"AnswerFont"] = @"18";
            // 解析
            param[@"Footer"] = @"18";
            // 设置
            param[@"SettingView"] = @"14";
            
            [userD setObject:param.copy forKey:@"Font"];
            //3.强制让数据立刻保存
            [userD synchronize];
            [self alterBtnStatuTag:sender.tag];
            // 刷新视图
            self.refreshViewBlock();
            break;
        }
        case 2:
        {// 正常
            // 标题
            param[@"SubjectFont"] = @"19";
            // 当前第几天
            param[@"NowQuestFont"] = @"15";
            // 总共多少题
            param[@"TotalQuestFont"] = @"12";
            // 题目
            param[@"TitleQuestFont"] = @"17";
            // 答题
            param[@"AnswerFont"] = @"16";
            // 解析
            param[@"Footer"] = @"16";
            // 设置
            param[@"SettingView"] = @"13";
            
            [userD setObject:param.copy forKey:@"Font"];
            //3.强制让数据立刻保存
            [userD synchronize];
            [self alterBtnStatuTag:sender.tag];
            // 刷新视图
            self.refreshViewBlock();
            break;
        }
        case 3:
        {// 小号
            // 标题
            param[@"SubjectFont"] = @"18";
            // 当前第几题
            param[@"NowQuestFont"] = @"14";
            // 总共多少题
            param[@"TotalQuestFont"] = @"11";
            // 题目
            param[@"TitleQuestFont"] = @"16";
            // 答题
            param[@"AnswerFont"] = @"15";
            // 解析
            param[@"Footer"] = @"15";
            // 设置
            param[@"SettingView"] = @"12";
            
            [userD setObject:param.copy forKey:@"Font"];
            //3.强制让数据立刻保存
            [userD synchronize];
            
            [self alterBtnStatuTag:sender.tag];
            // 刷新视图
            self.refreshViewBlock();
            break;
        }
        default:
            break;
    }
}
// 设置当前选中状态
-(void) alterBtnStatuTag:(NSInteger)btnTag{
    UIButton *oldBtn = [self viewWithTag:self.pageTag];
    [oldBtn setTitleColor:[UIColor colorCommon65GreyBlackColor] forState:UIControlStateNormal];
    
    UIButton *btn = [self viewWithTag:btnTag];
    [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.pageTag = btn.tag;
}
-(void)selectSuccessBtn:(UIButton *) sender{
    [self selectTap];
}
-(void) selectTap{
    [self removeFromSuperview];
}



@end
