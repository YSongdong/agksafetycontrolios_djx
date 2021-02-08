//
//  BaseWorkMeetingCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseWorkMeetingCell.h"

#import "FSTextView.h"
#import "UITextView+WZB.h"

@interface YWTBaseWorkMeetingCell ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,assign) BOOL isOne;
@end


@implementation YWTBaseWorkMeetingCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isOne = YES;
        [self createUserInfoView];
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
    
    
    // 班前班后会议标题
    self.meetTitleTextView = [[UITextView alloc]init];
    [contentView addSubview:self.meetTitleTextView];
    self.meetTitleTextView.wzb_placeholder = @"请输入班前班后会标题";
    self.meetTitleTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.meetTitleTextView.textColor =[UIColor colorCommonBlackColor];
    self.meetTitleTextView.font = Font(14);
    self.meetTitleTextView.returnKeyType = UIReturnKeyDone;
    [self.meetTitleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(5));
        make.left.equalTo(contentView).offset(KSIphonScreenW(10));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
        make.height.equalTo(@33);
    }];
    self.meetTitleTextView.delegate = self;
    // 根据文字长度更新高度
    [self.meetTitleTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.meetTitleTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(KSIphonScreenH(5));
            make.left.equalTo(contentView).offset(KSIphonScreenW(10));
            make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.meetTitleTextView.wzb_minHeight = 33;
    self.meetTitleTextView.wzb_maxHeight = 50;
    
    UIView *chenkTitleView = [[UIView alloc]init];
    [contentView addSubview:chenkTitleView];
    chenkTitleView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [chenkTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.meetTitleTextView);
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.meetTitleTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.height.equalTo(@1);
    }];
    
    // 工作地点
    self.workAddressTextView = [[UITextView alloc]init];
    [contentView addSubview:self.workAddressTextView];
    self.workAddressTextView.wzb_placeholder = @"请输入工作地点";
    self.workAddressTextView.wzb_placeholderColor =[UIColor colorCommonAAAAGreyBlackColor];
    self.workAddressTextView.textColor =[UIColor colorCommonBlackColor];
    self.workAddressTextView.font = Font(14);
    self.workAddressTextView.returnKeyType = UIReturnKeyDone;
    [self.workAddressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chenkTitleView.mas_bottom);
        make.width.equalTo(weakSelf.meetTitleTextView);
        make.centerX.equalTo(weakSelf.meetTitleTextView.mas_centerX);
        make.height.equalTo(@33);
    }];
    self.workAddressTextView.delegate = self;
    // 根据文字长度更新高度
    [self.workAddressTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.workAddressTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(chenkTitleView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.meetTitleTextView);
            make.centerX.equalTo(weakSelf.meetTitleTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.workAddressTextView.wzb_minHeight = 33;
    self.workAddressTextView.wzb_maxHeight = 50;
    
    UIView *uninLineView = [[UIView alloc]init];
    [contentView addSubview:uninLineView];
    uninLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [uninLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(chenkTitleView);
        make.bottom.equalTo(weakSelf.workAddressTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(chenkTitleView.mas_centerX);
    }];
    
    // 工作编号
    self.workNumerTextView = [[UITextView alloc]init];
    [contentView addSubview:self.workNumerTextView];
    self.workNumerTextView.wzb_placeholder = @"请输入工作票编号";
    self.workNumerTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.workNumerTextView.textColor =[UIColor colorCommonBlackColor];
    self.workNumerTextView.font = Font(14);
    self.workNumerTextView.returnKeyType = UIReturnKeyDone;
    [self.workNumerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uninLineView.mas_bottom);
        make.width.equalTo(weakSelf.workAddressTextView);
        make.centerX.equalTo(weakSelf.workAddressTextView.mas_centerX);
        make.height.equalTo(@33);
    }];
    self.workNumerTextView.delegate = self;
    // 根据文字长度更新高度
    [self.workNumerTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.workNumerTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uninLineView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.meetTitleTextView);
            make.centerX.equalTo(weakSelf.meetTitleTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.workNumerTextView.wzb_minHeight = 33;
    self.workNumerTextView.wzb_maxHeight = 50;
    
    UIView *addressLineView = [[UIView alloc]init];
    [contentView addSubview:addressLineView];
    addressLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [addressLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(uninLineView);
        make.bottom.equalTo(weakSelf.workNumerTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(uninLineView.mas_centerX);
    }];
    
    // 班前班后会议内容
    self.fsTextView = [[FSTextView alloc]init];
    [contentView addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入班前班后会议内容";
    self.fsTextView.placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.fsTextView.font = Font(14);
    self.fsTextView.delegate = self;
    self.fsTextView.textColor = [UIColor colorCommonBlackColor];
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLineView.mas_bottom).offset(KSIphonScreenH(3));
        make.left.equalTo(contentView).offset(KSIphonScreenW(11));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(8));
        make.bottom.equalTo(contentView).offset(-KSIphonScreenH(10));
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.isOne = NO;
    if (self.cellType == showBaseWorkMeetingType) {
        // 班前班后会
        // 地点
        self.workAddressTextView.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"classRecordAddress"]]];
        // 工作票
        self.workNumerTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]]];
        [self.workNumerTextView resignFirstResponder];
        // 标题
        self.meetTitleTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"classRecordTitle"]]];
        // 内容
        self.fsTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"classRecordContent"]]];
    }else{
       // 技术交底
        // 地点
        self.workAddressTextView.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"technicalDisclosureAddress"]]];
        // 工作票
        self.workNumerTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]]];
        [self.workNumerTextView resignFirstResponder];
        // 标题
        self.meetTitleTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"technicalDisclosureTitle"]]];
        // 内容
        self.fsTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"technicalDisclosureContent"]]];
    }
    self.isOne = YES;
}

-(void)setCellType:(showBaseWorkType )cellType{
    _cellType = cellType;
    if (cellType == showBaseWorkMeetingType) {
        self.workAddressTextView.wzb_placeholder = @"请输入工作地点";
        self.workNumerTextView.wzb_placeholder = @"请输入工作票(派工单)编号";
        self.meetTitleTextView.wzb_placeholder = @"请输入班前班后会标题";
        self.fsTextView.placeholder = @"备注(选填)";
    }else{
        self.workAddressTextView.wzb_placeholder = @"请输入工作地点";
        self.workNumerTextView.wzb_placeholder = @"请输入工程项目名称";
        self.meetTitleTextView.wzb_placeholder = @"请输入技术交底标题";
        self.fsTextView.placeholder = @"请输入技术交底内容";
    }
}
#pragma mark ------UITextViewDelegate ----
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (!self.isOne) {
        return YES ;
    }
    if (textView == self.workAddressTextView) {
        // 被检查单位
        self.selectRutureKeyBord(1, textView.text);
    }else if (textView == self.workNumerTextView){
        // 工作票
        self.selectRutureKeyBord(2, textView.text);
    }else if (textView == self.meetTitleTextView){
        // 标题
        self.selectRutureKeyBord(3, textView.text);
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
    if (textView == self.workAddressTextView) {
        // 被检查单位
        self.selectRutureKeyBord(1, textView.text);
    }else if (textView == self.workNumerTextView){
        // 工作票
        self.selectRutureKeyBord(2, textView.text);
    }else if (textView == self.meetTitleTextView){
        // 标题
        self.selectRutureKeyBord(3, textView.text);
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
        if (textView == self.workAddressTextView) {
            // 被检查单位
            self.selectRutureKeyBord(1, textView.text);
        }else if (textView == self.workNumerTextView){
            // 工作票
            self.selectRutureKeyBord(2, textView.text);
        }else if (textView == self.meetTitleTextView){
            // 标题
            self.selectRutureKeyBord(3, textView.text);
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
    if (self.workAddressTextView.isFirstResponder) {
        // 工作地点
        self.selectRutureKeyBord(1, self.workAddressTextView.text);
        [self.workAddressTextView resignFirstResponder];
    }
    if (self.workNumerTextView.isFirstResponder) {
        // 工作票
        self.selectRutureKeyBord(2, self.workNumerTextView.text);
        [self.workNumerTextView resignFirstResponder];
    }
    if (self.meetTitleTextView.isFirstResponder) {
        // 标题
        self.selectRutureKeyBord(3, self.meetTitleTextView.text);
        [self.meetTitleTextView resignFirstResponder];
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
