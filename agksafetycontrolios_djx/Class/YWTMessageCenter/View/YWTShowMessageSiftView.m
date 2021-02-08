//
//  ShowMessageSiftView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/4.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowMessageSiftView.h"

@implementation YWTShowMessageSiftView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [bigBgView addGestureRecognizer:tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
        make.height.equalTo(@(KSIphonScreenH(275)));
    }];
    
    NSArray *arr = @[@"请选择需要筛选的消息类型",@"全部消息",@"系统消息",@"考试通知",@"任务通知"];
    for (int i=0; i<arr.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgView addSubview:btn];
        btn.frame = CGRectMake(0, i*KSIphonScreenH(44)+i*1, KScreenW, KSIphonScreenH(44));
        btn.titleLabel.font = Font(16);
        btn.titleLabel.textAlignment  = NSTextAlignmentCenter;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:[UIColor colorCommon65GreyBlackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        }else{
            btn.backgroundColor = [UIColor colorTextWhiteColor];
            [btn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(selectdBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font(18);
    cancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelActtion:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)selectTap{
    [self removeFromSuperview];
}

-(void)selectCancelActtion:(UIButton *) sender{
    [self removeFromSuperview];
}
//选择筛选条件
-(void)selectdBtnAction:(UIButton *) sender{
    switch (sender.tag - 200) {
        case 1:{
            //全部消息
            self.selectType(@"0");
            break;
        }
        case 2:{
            //系统消息
            self.selectType(@"1");
            break;
        }
        case 3:{
            //考试通知
            self.selectType(@"2");
            break;
        }
        case 4:{
            //任务通知
            self.selectType(@"3");
            break;
        }
        default:
            break;
    }
    [self removeFromSuperview];
}

-(void)setTagIdStr:(NSString *)tagIdStr{
    _tagIdStr = tagIdStr;
    if ([tagIdStr isEqualToString:@""]) {
        return;
    }else if ([tagIdStr isEqualToString:@"0"]){
        UIButton *btn = [self viewWithTag:201];
        [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    }else if ([tagIdStr isEqualToString:@"1"]){
        UIButton *btn = [self viewWithTag:202];
        [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    }else if ([tagIdStr isEqualToString:@"2"]){
        UIButton *btn = [self viewWithTag:203];
        [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    }else if ([tagIdStr isEqualToString:@"3"]){
        UIButton *btn = [self viewWithTag:204];
        [btn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    }
}





@end
