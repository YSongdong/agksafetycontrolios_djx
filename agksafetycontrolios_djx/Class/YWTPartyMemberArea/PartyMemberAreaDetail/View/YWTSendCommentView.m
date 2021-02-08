//
//  YWTSendCommentView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/12.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSendCommentView.h"

@interface YWTSendCommentView ()
<
UITextViewDelegate
>
// 容器视图
@property (nonatomic, strong) UIView * containView;

@property (nonatomic, strong) FSTextView *fsTextView;

@end

@implementation YWTSendCommentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCommentView];
    }
    return self;
}
-(void) createCommentView{
    
    self.containView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-140, KScreenW, 140)];
    self.containView.backgroundColor = [UIColor colorTextWhiteColor];
    [self addSubview:self.containView];
    
    // 线条view
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
    lineView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [self.containView addSubview:lineView];
    
    self.fsTextView = [[FSTextView alloc]initWithFrame:CGRectMake(12, 12, KScreenW-24, 85)];
    [self.containView addSubview:self.fsTextView];
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    self.fsTextView.delegate = self;
    self.fsTextView.cornerRadius = 4;
    self.fsTextView.borderWidth = 1;
    self.fsTextView.borderColor = [UIColor colorViewBackGrounpWhiteColor];
    self.fsTextView.placeholder = @"写评论";
    [self.fsTextView becomeFirstResponder];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.containView addSubview:sendBtn];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font = Font(13);
    [sendBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [sendBtn addTarget:self action:@selector(selectSendAction:) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.containView).offset(-KSIphonScreenW(12));
        make.top.equalTo(weakSelf.fsTextView.mas_bottom).offset(KSIphonScreenH(10));
        make.height.equalTo(@25);
        make.width.equalTo(@55);
    }];
    sendBtn.layer.cornerRadius = 4;
    sendBtn.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void) selectSendAction:(UIButton *) sender{
    [self.fsTextView resignFirstResponder];
    self.selectCommit(self.fsTextView.text);
}
#pragma mark - YYTextViewDelegate
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ // 回车
        // 监听输入文本
        [textView resignFirstResponder];
        self.selectCommit(textView.text);
        return NO;
    }
    return YES;
}

#pragma mark ---- 键盘 ----
-(void) keyboardFrameChange:(NSNotification*)titf{
    NSDictionary * userInfo = [titf userInfo];
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = ([[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 ) | UIViewAnimationOptionBeginFromCurrentState;
    // 键盘高度
    CGFloat keyboardH = 0;
    if (endFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) { // 弹下
        keyboardH = 0;
    } else {
        keyboardH = endFrame.size.height;
    }
    // 容器的top
    CGFloat top = 0;
    if (keyboardH > 0) {
        top = KScreenH - self.containView.height - keyboardH;
    } else {
        top = KScreenH;
    }
    // 动画
    [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
        self.containView.top = top;
    } completion:^(BOOL finished) {
        if (keyboardH == 0) {
            self.fsTextView.text = nil;
            [self removeFromSuperview];
        }
    }];
}
#pragma mark - UIResponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    if (CGRectContainsPoint(self.containView.frame, currentPoint) == NO) {
        [self.fsTextView resignFirstResponder];
    }
}

@end
