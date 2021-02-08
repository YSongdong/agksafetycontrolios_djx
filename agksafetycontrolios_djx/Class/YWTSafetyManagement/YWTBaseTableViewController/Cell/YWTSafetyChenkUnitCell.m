//
//  SafetyChenkUnitCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSafetyChenkUnitCell.h"

#import "FSTextView.h"
#import "UITextView+WZB.h"

@interface YWTSafetyChenkUnitCell () <UITextViewDelegate>

@property (nonatomic,assign) BOOL isOne;

@end

@implementation YWTSafetyChenkUnitCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUserInfoView];
        self.isOne = YES;
        //监听当键将要退出时
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void) createUserInfoView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(12));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(bgView);
    }];
    contentView.layer.cornerRadius = 8;
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderWidth = 1;
    contentView.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    
    // 检查标题
    self.chenkTitleTextView = [[UITextView alloc]init];
    [contentView addSubview:self.chenkTitleTextView];
    self.chenkTitleTextView.wzb_placeholder = @"请输入安全检查标题";
    self.chenkTitleTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.chenkTitleTextView.textColor =[UIColor colorCommonBlackColor];
    self.chenkTitleTextView.font = Font(14);
    self.chenkTitleTextView.returnKeyType = UIReturnKeyDone;
    [self.chenkTitleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(5));
        make.left.equalTo(contentView).offset(KSIphonScreenW(10));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
        make.height.equalTo(@33);
    }];
    self.chenkTitleTextView.delegate = self;
    // 根据文字长度更新高度
    [self.chenkTitleTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.chenkTitleTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(KSIphonScreenH(5));
            make.left.equalTo(contentView).offset(KSIphonScreenW(10));
            make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.chenkTitleTextView.wzb_minHeight = 33;
    self.chenkTitleTextView.wzb_maxHeight = 50;
    
    UIView *chenkTitleView = [[UIView alloc]init];
    [contentView addSubview:chenkTitleView];
    chenkTitleView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [chenkTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf.chenkTitleTextView);
        make.bottom.equalTo(weakSelf.chenkTitleTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.height.equalTo(@1);
    }];

    // 被检单位
    self.chenkUnitTextView = [[UITextView alloc]init];
    [contentView addSubview:self.chenkUnitTextView];
    self.chenkUnitTextView.wzb_placeholder = @"请输入被检单位";
    self.chenkUnitTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.chenkUnitTextView.textColor =[UIColor colorCommonBlackColor];
    self.chenkUnitTextView.font = Font(14);
    self.chenkUnitTextView.returnKeyType =  UIReturnKeyDone;
    [self.chenkUnitTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chenkTitleView.mas_bottom).offset(KSIphonScreenH(5));
        make.width.equalTo(weakSelf.chenkTitleTextView);
        make.height.equalTo(@33);
        make.centerX.equalTo(weakSelf.chenkTitleTextView.mas_centerX);
    }];
    self.chenkUnitTextView.delegate = self;
    // 根据文字长度更新高度
    [self.chenkUnitTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.chenkUnitTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(chenkTitleView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.chenkTitleTextView);
            make.centerX.equalTo(weakSelf.chenkTitleTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.chenkUnitTextView.wzb_minHeight = 33;
    self.chenkUnitTextView.wzb_maxHeight = 50;
    
    UIView *uninLineView = [[UIView alloc]init];
    [contentView addSubview:uninLineView];
    uninLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [uninLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(chenkTitleView);
        make.bottom.equalTo(weakSelf.chenkUnitTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(chenkTitleView.mas_centerX);
    }];

    // 检查地点
    self.chenkAddressTextView = [[UITextView alloc]init];
    [contentView addSubview:self.chenkAddressTextView];
    self.chenkAddressTextView.wzb_placeholder = @"请输入检查地点";
    self.chenkAddressTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.chenkAddressTextView.textColor =[UIColor colorCommonBlackColor];
    self.chenkAddressTextView.font = Font(14);
    self.chenkAddressTextView.returnKeyType =  UIReturnKeyDone;
    [self.chenkAddressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uninLineView.mas_bottom).offset(KSIphonScreenH(5));
        make.width.equalTo(weakSelf.chenkUnitTextView);
        make.height.equalTo(@33);
        make.centerX.equalTo(weakSelf.chenkUnitTextView.mas_centerX);
    }];
    self.chenkAddressTextView.delegate = self;
    // 根据文字长度更新高度
    [self.chenkAddressTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.chenkAddressTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uninLineView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.chenkUnitTextView);
            make.centerX.equalTo(weakSelf.chenkUnitTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.chenkAddressTextView.wzb_minHeight = 33;
    self.chenkAddressTextView.wzb_maxHeight = 50;
    
    UIView *addressLineView = [[UIView alloc]init];
    [contentView addSubview:addressLineView];
    addressLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [addressLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(uninLineView);
        make.bottom.equalTo(weakSelf.chenkAddressTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(uninLineView.mas_centerX);
    }];
    
    // 工作票
    self.workTickTextView = [[UITextView alloc]init];
    [contentView addSubview:self.workTickTextView];
    self.workTickTextView.wzb_placeholder = @"请输入工作票(操作票)号";
    self.workTickTextView.wzb_placeholderColor =[UIColor colorCommonAAAAGreyBlackColor];
    self.workTickTextView.textColor =[UIColor colorCommonBlackColor];
    self.workTickTextView.font = Font(14);
    self.workTickTextView.returnKeyType =  UIReturnKeyDone;
    [self.workTickTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLineView.mas_bottom).offset(KSIphonScreenH(5));
        make.width.equalTo(weakSelf.chenkUnitTextView);
        make.height.equalTo(@33);
        make.centerX.equalTo(weakSelf.chenkUnitTextView.mas_centerX);
    }];
    self.workTickTextView.delegate = self;
    // 根据文字长度更新高度
    [self.workTickTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.workTickTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addressLineView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.chenkUnitTextView);
            make.centerX.equalTo(weakSelf.chenkUnitTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.workTickTextView.wzb_minHeight = 33;
    self.workTickTextView.wzb_maxHeight = 50;
    
    UIView *workTickView = [[UIView alloc]init];
    [contentView addSubview:workTickView];
    workTickView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [workTickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(uninLineView);
        make.bottom.equalTo(weakSelf.workTickTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(uninLineView.mas_centerX);
    }];

    // 检查内容
    self.fsTextView = [[FSTextView alloc]init];
    [contentView addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入安全检查内容";
    self.fsTextView.placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.fsTextView.font = Font(14);
    self.fsTextView.textColor = [UIColor colorCommonBlackColor];
    self.fsTextView.returnKeyType =  UIReturnKeyDone;
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(workTickView.mas_bottom).offset(KSIphonScreenH(3));
        make.left.equalTo(contentView).offset(KSIphonScreenW(11));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(8));
        make.bottom.equalTo(contentView).offset(-KSIphonScreenH(10));
    }];
    self.fsTextView.delegate = self;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.isOne = NO;
    // 被检单位
    self.chenkUnitTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"beingCheckUnitName"]]];

    // 检查地点
    self.chenkAddressTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"securityCheckAddress"]]];
    [self.chenkAddressTextView resignFirstResponder];
    // 电压等级
    self.voltageLevelLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"voltageLevels"]]];
    self.showVoltageLevelLab.hidden = YES;

    // 工作票
    self.workTickTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]]];

    // 标题
    self.chenkTitleTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"securityCheckTitle"]]];

    // 内容
    self.fsTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"securityCheckContent"]]];

    [self endEditing:YES];
    self.isOne = YES;
}
#pragma mark ------UITextViewDelegate ----
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (!self.isOne) {
        return YES ;
    }
    if (textView == self.chenkUnitTextView) {
        // 被检查单位
        self.selectRutureKeyBord(1, textView.text);
    }else if (textView == self.chenkAddressTextView){
        // 检查地点
        self.selectRutureKeyBord(2, textView.text);
    }else if (textView == self.workTickTextView){
        // 工作票
        self.selectRutureKeyBord(3, textView.text);
    }
    else if (textView == self.chenkTitleTextView){
        // 标题
        self.selectRutureKeyBord(4, textView.text);
    }
    // 判断有值 就传
    if (self.fsTextView.text.length != 0) {
        self.selectContentKeyBord(self.fsTextView.text);
    }
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (!self.isOne) {
        return YES ;
    }
    if (textView == self.chenkUnitTextView) {
        // 被检查单位
        self.selectRutureKeyBord(1, textView.text);
    }else if (textView == self.chenkAddressTextView){
        // 检查地点
        self.selectRutureKeyBord(2, textView.text);
    }else if (textView == self.workTickTextView){
        // 工作票
        self.selectRutureKeyBord(3, textView.text);
    }
    else if (textView == self.chenkTitleTextView){
        // 标题
        self.selectRutureKeyBord(4, textView.text);
    }
    // 判断有值 就传
    if (self.fsTextView.text.length != 0) {
        self.selectContentKeyBord(self.fsTextView.text);
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self endEditing:YES];
        if (textView == self.chenkUnitTextView) {
            // 被检查单位
            self.selectRutureKeyBord(1, textView.text);
        }else if (textView == self.chenkAddressTextView){
            // 检查地点
            self.selectRutureKeyBord(2, textView.text);
        }else if (textView == self.workTickTextView){
            // 工作票
            self.selectRutureKeyBord(3, textView.text);
        }
        else if (textView == self.chenkTitleTextView){
            // 标题
            self.selectRutureKeyBord(4, textView.text);
        }else if (textView == self.fsTextView){
            // 内容
             self.selectContentKeyBord(textView.text);
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
// 当键盘消失时
-(void) keyBoardWillHide:(NSNotification *)tifi{
    if (self.chenkUnitTextView.isFirstResponder) {
        // 被检查单位
        self.selectRutureKeyBord(1, self.chenkUnitTextView.text);
        [self.chenkUnitTextView resignFirstResponder];
    }
    if (self.chenkAddressTextView.isFirstResponder) {
        // 检查地点
        self.selectRutureKeyBord(2, self.chenkAddressTextView.text);
        [self.chenkAddressTextView resignFirstResponder];
    }
    if (self.workTickTextView.isFirstResponder) {
        // 工作票
        self.selectRutureKeyBord(3, self.workTickTextView.text);
        [self.workTickTextView resignFirstResponder];
    }
    if (self.chenkTitleTextView.isFirstResponder) {
        // 标题
        self.selectRutureKeyBord(4, self.chenkTitleTextView.text);
        [self.chenkTitleTextView resignFirstResponder];
    }
    if (self.fsTextView.isFirstResponder) {
        // 内容
        self.selectContentKeyBord(self.fsTextView.text);
        [self.fsTextView resignFirstResponder];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
