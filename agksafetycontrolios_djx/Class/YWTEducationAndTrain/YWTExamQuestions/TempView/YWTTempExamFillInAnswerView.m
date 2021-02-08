//
//  TempExamFillInAnswerView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempExamFillInAnswerView.h"

@implementation YWTTempExamFillInAnswerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createFillAnswerView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void) createFillAnswerView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [bigBgView addGestureRecognizer:tap];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-KSIphonScreenH(100)-KSTabbarH, KScreenW, KSIphonScreenH(100))];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor  =[UIColor colorViewBackGrounpWhiteColor];
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#dbdbdb"].CGColor;
    self.bgView.layer.cornerRadius =4;
    self.bgView.layer.masksToBounds = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger analyzeSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"AnswerFont"]integerValue] : 16 ;
    btn.titleLabel.font = [UIFont systemFontOfSize:analyzeSize];
    btn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
        make.height.equalTo(@(KSIphonScreenH(33)));
        make.width.equalTo(@(KSIphonScreenW(73)));
    }];
    [btn addTarget:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius =4;
    btn.layer.masksToBounds = YES;
    
    self.answerTextView  =  [[UITextView alloc]init];
    [weakSelf.bgView addSubview:self.answerTextView];
    [self.answerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenH(15));
        make.bottom.equalTo(btn.mas_top);
    }];
    self.answerTextView.delegate = self;
    //弹起键盘
    [self.answerTextView becomeFirstResponder];

    
    self.placeLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.placeLab];
    self.placeLab.text = @"请填写您的答案";
    self.placeLab.font = [UIFont systemFontOfSize:14];
    self.placeLab.textColor  =[UIColor colorCommonAAAAGreyBlackColor];
    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.answerTextView.mas_top).offset(KSIphonScreenW(8));
        make.left.equalTo(weakSelf.answerTextView.mas_left);
    }];
}
/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(self.bgView.center.x, frame.origin.y-self.bgView.frame.size.height/2);
    }];
}
/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
-(void)keyboardWillHidden:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(self.bgView.center.x, KScreenH-KSIphonScreenH(100)/2-KSTabbarH);
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //判断输入的字是否是回车，即按下return
    if ([text isEqualToString:@"\n"]){
        
        self.frishBlock(self.answerTextView.text);
        //失去焦点
        [self.answerTextView resignFirstResponder];
        
        //在这里做你响应return键的代码
        return NO;
    }
    if (textView.text.length == 0 || text.length == 0) {
        self.placeLab.hidden = NO;
    }else{
        self.placeLab.hidden = YES;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0 ) {
        self.placeLab.hidden = NO;
    }else{
        self.placeLab.hidden = YES;
    }
}
//完成按钮
-(void)sendBtn:(UIButton *) sender{
    self.frishBlock(self.answerTextView.text);
}
-(void)changeContentViewPoint:(NSNotification *) titf
{
    //失去焦点
    [self.answerTextView resignFirstResponder];
}
-(void)selectTap{
    //失去焦点
    [self.answerTextView resignFirstResponder];
    [self removeFromSuperview];
}




@end
