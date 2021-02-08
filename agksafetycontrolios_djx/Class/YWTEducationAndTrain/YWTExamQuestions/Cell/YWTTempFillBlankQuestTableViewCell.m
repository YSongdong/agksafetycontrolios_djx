//
//  TempFillBlankQuestTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempFillBlankQuestTableViewCell.h"


@interface YWTTempFillBlankQuestTableViewCell () <UITextViewDelegate>



@end

@implementation YWTTempFillBlankQuestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      [self createFillBlbackView];
    }
    return self;
}
-(void) createFillBlbackView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];

    self.fsTextView = [[FSTextView alloc]init];
    self.fsTextView.placeholder = @"请填写您的答案";
    self.fsTextView.placeholderFont = Font(15);
    self.fsTextView.placeholderColor = [UIColor colorCommonGreyBlackColor];
    self.fsTextView.borderWidth = 1.f;
    self.fsTextView.keyboardType = UIKeyboardTypeNamePhonePad;
    self.fsTextView.borderColor = [UIColor colorWithHexString:@"#cccccc"];
    self.fsTextView.cornerRadius = 5.f;
    self.fsTextView.font = Font(14);
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    self.fsTextView.canPerformAction = NO;
    // 计算字体大小
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger answerfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"AnswerFont"]integerValue] : 14 ;
    self.fsTextView.font =Font(answerfontSize);
    self.fsTextView.delegate = self;
    [self addSubview:self.fsTextView];
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
}
#pragma mark --- UITextViewDelegate -----
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        self.fillinAnswerBlock(textView.text);
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
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.fsTextViewEditing(YES);
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.fsTextViewEditing(NO);
}
-(void)setFillBlankQuestMode:(showExamFillBlankQuestMode)fillBlankQuestMode{
    if (fillBlankQuestMode == showFillBlankQuestAnswerMode) {
         self.fsTextView.editable = YES;
    }else{
         self.fsTextView.editable = NO;
    }
}
-(void)getWithFillinAnswer:(NSString *)userAnswerStr andMode:(NSString *)modeStr{
    // 赋值
    self.fsTextView.text = userAnswerStr;
    if ([modeStr isEqualToString:@"2"]) {
        if ([userAnswerStr isEqualToString:@""] ||  userAnswerStr == nil) {
            self.fsTextView.placeholder = @" ";
        }
    }
    // 计算字体大小
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger answerfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"AnswerFont"]integerValue] : 14 ;
    self.fsTextView.font =Font(answerfontSize);
    [YWTTools getSpaceLabelHeight:self.fsTextView.text withFont:KScreenW-KSIphonScreenW(10) withWidth:answerfontSize withSpace:3];
}

//计算高度
+(CGFloat)getCellHeightWithStr:(NSString *)answerStr andType:(NSString *)typeStr{
    CGFloat height = 0 ;
    // 答案等于空，为默认高度
    if ([typeStr isEqualToString:@"5"] && ([answerStr isEqualToString:@""] || answerStr == nil)) {
        // 默认高度
        height = 55;
        return  height;
    }
    // 判断是  6:主观题  输入框要大点
    if ([typeStr isEqualToString:@"6"] && ([answerStr isEqualToString:@""] || answerStr == nil)) {
        // 默认高度
        height = 80;
        return  height;
    }
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger answerfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"AnswerFont"]integerValue] : 14 ;
    UILabel *answerLab = [[UILabel alloc]init];
    answerLab.text = answerStr;
    answerLab.numberOfLines = 0;
    CGFloat answerHeight = [YWTTools getSpaceLabelHeight:answerLab.text withFont:answerfontSize withWidth:KScreenW-40 withSpace:3];
    
    height += height+answerHeight+20;
    
    if ([typeStr isEqualToString:@"5"]){
        if (height > 50) {
             return height;
        }else{
             return 50;
        }
    }else{
        
        if (height > 80) {
            return height;
        }else{
            return 80;
        }
    }
}
/**
 判断是否存在特殊字符 只能输入汉字，数字，英文，括号，下划线，横杠，空格
 */
- (BOOL)isContainsSpecialCharacters:(NSString *)searchText
{
    /*此方法也可以理论上可以,但实测还是会有问题*/
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9()_\u4E00-\u9FA5\\s-，。？！；,.?!、（）():"";]"  options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result) {
        return YES;
    }else {
        return NO;
    }
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
