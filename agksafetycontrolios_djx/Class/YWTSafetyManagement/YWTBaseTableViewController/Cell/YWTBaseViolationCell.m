//
//  BaseViolationCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseViolationCell.h"

#import "UITextView+WZB.h"

@interface YWTBaseViolationCell () <UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,assign) BOOL isOne;
@end

@implementation YWTBaseViolationCell
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
    
    // 违章事由
    self.violaCententTextView = [[UITextView alloc]init];
    [contentView addSubview:self.violaCententTextView];
    self.violaCententTextView.wzb_placeholder = @"请输入违章事由";
    self.violaCententTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.violaCententTextView.textColor =[UIColor colorCommonBlackColor];
    self.violaCententTextView.font = Font(14);
    [self.violaCententTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(5));
        make.left.equalTo(contentView).offset(KSIphonScreenW(10));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
        make.height.equalTo(@33);
    }];
    self.violaCententTextView.delegate = self;
    // 根据文字长度更新高度
    [self.violaCententTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.violaCententTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(KSIphonScreenH(5));
            make.left.equalTo(contentView).offset(KSIphonScreenW(10));
            make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.violaCententTextView.wzb_minHeight = 33;
    self.violaCententTextView.wzb_maxHeight = 50;
    
    UIView *chenkTitleView = [[UIView alloc]init];
    [contentView addSubview:chenkTitleView];
    chenkTitleView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [chenkTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf.violaCententTextView);
        make.bottom.equalTo(weakSelf.violaCententTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.height.equalTo(@1);
    }];
    
    //违章人员
    self.violationNameTextView = [[UITextView alloc]init];
    [contentView addSubview:self.violationNameTextView];
    self.violationNameTextView.wzb_placeholder = @"请输入违章人员姓名";
    self.violationNameTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.violationNameTextView.textColor =[UIColor colorCommonBlackColor];
    self.violationNameTextView.font = Font(14);
    [self.violationNameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chenkTitleView.mas_bottom).offset(KSIphonScreenH(5));
        make.width.equalTo(weakSelf.violaCententTextView);
        make.centerX.equalTo(weakSelf.violaCententTextView.mas_centerX);
        make.height.equalTo(@33);
    }];
    self.violationNameTextView.delegate = self;
    // 根据文字长度更新高度
    [self.violationNameTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.violationNameTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(chenkTitleView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.violaCententTextView);
            make.centerX.equalTo(weakSelf.violaCententTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.violationNameTextView.wzb_minHeight = 33;
    self.violationNameTextView.wzb_maxHeight = 50;
    
    UIView *uninLineView = [[UIView alloc]init];
    [contentView addSubview:uninLineView];
    uninLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [uninLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(chenkTitleView);
        make.bottom.equalTo(weakSelf.violationNameTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(chenkTitleView.mas_centerX);
    }];
    
    // 违章人员单位
    self.violaPersonUnitTextView = [[UITextView alloc]init];
    [contentView addSubview:self.violaPersonUnitTextView];
    self.violaPersonUnitTextView.wzb_placeholder = @"请输入违章人员单位";
    self.violaPersonUnitTextView.wzb_placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.violaPersonUnitTextView.textColor =[UIColor colorCommonBlackColor];
    self.violaPersonUnitTextView.font = Font(14);
    [self.violaPersonUnitTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uninLineView.mas_bottom).offset(KSIphonScreenH(5));
        make.width.equalTo(weakSelf.violationNameTextView);
        make.centerX.equalTo(weakSelf.violationNameTextView.mas_centerX);
        make.height.equalTo(@33);
    }];
    self.violaPersonUnitTextView.delegate = self;
    // 根据文字长度更新高度
    [self.violaPersonUnitTextView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        [weakSelf.violaPersonUnitTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uninLineView.mas_bottom).offset(KSIphonScreenH(5));
            make.width.equalTo(weakSelf.violaCententTextView);
            make.centerX.equalTo(weakSelf.violaCententTextView.mas_centerX);
            make.height.equalTo(@(currentTextViewHeight));
        }];
    }];
    self.violationNameTextView.wzb_minHeight = 33;
    self.violationNameTextView.wzb_maxHeight = 50;
    
    UIView *addressLineView = [[UIView alloc]init];
    [contentView addSubview:addressLineView];
    addressLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [addressLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(uninLineView);
        make.bottom.equalTo(weakSelf.violaPersonUnitTextView.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(uninLineView.mas_centerX);
    }];
    
    // 违章等级
    UIButton *violationGradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:violationGradeBtn];
    [violationGradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLineView.mas_bottom);
        make.width.equalTo(weakSelf.violationNameTextView);
        make.height.equalTo(@40);
        make.centerX.equalTo(weakSelf.violationNameTextView.mas_centerX);
    }];
    [violationGradeBtn addTarget:self action:@selector(selectGradeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 提示语
    self.showViolaGradeLab = [[UILabel alloc]init];
    [contentView addSubview:self.showViolaGradeLab];
    self.showViolaGradeLab.text = @"请选择违章等级";
    self.showViolaGradeLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.showViolaGradeLab.font = Font(14);
    [self.showViolaGradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressLineView.mas_left);
        make.centerY.equalTo(violationGradeBtn.mas_centerY);
    }];
    
    
    self.ViolaGradeLab = [[UILabel alloc]init];
    [contentView addSubview:self.ViolaGradeLab];
    self.ViolaGradeLab.text = @"";
    self.ViolaGradeLab.textColor = [UIColor colorCommonBlackColor];
    self.ViolaGradeLab.font = Font(14);
    [self.ViolaGradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressLineView.mas_left);
        make.right.equalTo(contentView).offset(-KSIphonScreenW(25));
        make.centerY.equalTo(violationGradeBtn.mas_centerY);
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [contentView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"safety_right_enter"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-KSIphonScreenW(13));
        make.centerY.equalTo(violationGradeBtn.mas_centerY);
    }];
    
    UIView *levelView = [[UIView alloc]init];
    [contentView addSubview:levelView];
    levelView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(uninLineView);
        make.bottom.equalTo(violationGradeBtn);
        make.centerX.equalTo(uninLineView.mas_centerX);
    }];
    
    // 违章处理情况
    self.fsTextView = [[FSTextView alloc]init];
    [contentView addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入违章处理情况";
    self.fsTextView.placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.fsTextView.font = Font(14);
    self.fsTextView.textColor = [UIColor colorCommonBlackColor];
    self.fsTextView.delegate = self;
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelView.mas_bottom);
        make.left.equalTo(contentView).offset(KSIphonScreenW(11));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(8));
        make.bottom.equalTo(contentView).offset(-KSIphonScreenH(10));
    }];
}
// 请选择违章等级
-(void)selectGradeBtn:(UIButton *) sender{
    [self.violationNameTextView resignFirstResponder];
    [self.violaPersonUnitTextView resignFirstResponder];
    [self.violaCententTextView resignFirstResponder];
    [self.fsTextView resignFirstResponder];
    self.selectViolation();
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
     self.isOne = NO;
    // 违章人员
    self.violationNameTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationUserInfo"]]];
    
    // 违章单位
    self.violaPersonUnitTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationUnitName"]]];
    [self.violaPersonUnitTextView resignFirstResponder];
    
    // 违章等级
    self.ViolaGradeLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"levels"]]];
    self.showViolaGradeLab.hidden = YES;
    
    // 违章事由
    self.violaCententTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationHanTitle"]]];
    
    // 内容
    self.fsTextView.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationHanContent"]]];
    self.isOne = YES;
}

#pragma mark ------UITextViewDelegate ----
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (!self.isOne) {
        return YES ;
    }
    if (textView == self.violationNameTextView) {
        // 被检查单位
        self.selectRutureKeyBord(1, textView.text);
    }else if (textView == self.violaPersonUnitTextView){
        // 工作票
        self.selectRutureKeyBord(2, textView.text);
    }else if (textView == self.violaCententTextView){
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
    if (textView == self.violationNameTextView) {
        // 被检查单位
        self.selectRutureKeyBord(1, textView.text);
    }else if (textView == self.violaPersonUnitTextView){
        // 工作票
        self.selectRutureKeyBord(2, textView.text);
    }else if (textView == self.violaCententTextView){
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
        if (textView == self.violationNameTextView) {
            // 被检查单位
            self.selectRutureKeyBord(1, textView.text);
        }else if (textView == self.violaPersonUnitTextView){
            // 工作票
            self.selectRutureKeyBord(2, textView.text);
        }else if (textView == self.violaCententTextView){
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
    if (self.violationNameTextView.isFirstResponder) {
        // 违章人员
        self.selectRutureKeyBord(1, self.violationNameTextView.text);
        [self.violationNameTextView resignFirstResponder];
    }
    if (self.violaPersonUnitTextView.isFirstResponder) {
       // 违章单位
        self.selectRutureKeyBord(2, self.violaPersonUnitTextView.text);
        [self.violaPersonUnitTextView resignFirstResponder];
    }
    if (self.violaCententTextView.isFirstResponder) {
        // 违章事由
        self.selectRutureKeyBord(3, self.violaCententTextView.text);
        [self.violaCententTextView resignFirstResponder];
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
