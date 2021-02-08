//
//  AttendanceAddMarkHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceAddMarkHeaderView.h"




@implementation YWTAttendanceAddMarkHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView {
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBgTap)];
    [bgView addGestureRecognizer:bgTap];
    
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@45);
    }];
    titleView.userInteractionEnabled = NO;
    
    self.markTitleLab = [[UILabel alloc]init];
    [titleView addSubview:self.markTitleLab];
    self.markTitleLab.text =@"打卡备注";
    self.markTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.markTitleLab.font = BFont(17);
    [self.markTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *markView = [[UIView alloc]init];
    [bgView addSubview:markView];
    markView.backgroundColor = [UIColor colorTextWhiteColor];
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    self.fsTextView = [[FSTextView alloc]init];
    [markView addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入签到备注信息 (必填)";
    self.fsTextView.placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.fsTextView.placeholderFont = Font(13);
    self.fsTextView.textColor = [UIColor colorCommonBlackColor];
    self.fsTextView.font = Font(13);
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    self.fsTextView.keyboardType = 
    self.fsTextView.borderWidth = 0.01;
    self.fsTextView.delegate = self;
    self.fsTextView.borderColor = [UIColor colorTextWhiteColor];
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(markView).offset(KSIphonScreenW(5));
        make.top.equalTo(markView).offset(KSIphonScreenH(10));
        make.bottom.equalTo(markView).offset(-KSIphonScreenH(8));
        make.right.equalTo(markView).offset(-KSIphonScreenW(10));
    }];
}
#pragma mark --- UITextViewDelegate -----
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [self endEditing:YES];
        return NO;
    }
    //判断键盘是不是九宫格键盘
    if ([self isNineKeyBoard:text] ){
        return YES;
    }else{
        if ([self hasEmoji:text] || [self stringContainsEmoji:text]){
            [self showErrorWithTitle:@"不支持输入特殊字符" autoCloseTime:0.5];
            return NO;
        }
    }
    return YES;
}
-(void)selectBgTap{
    [self.fsTextView resignFirstResponder];
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}
/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
@end
