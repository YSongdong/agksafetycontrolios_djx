//
//  YWTSelectUnitHeaderView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSelectUnitHeaderView.h"

@implementation YWTSelectUnitHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.nameLab = [YYLabel new];
    [self addSubview:self.nameLab];
    self.nameLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.nameLab.font = Font(12);
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.top.equalTo(weakSelf.mas_top);
    }];
    
    NSString *str = @" ";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    UIImageView *topImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suggetion_select_top"]];
    topImageV.frame = CGRectMake(0, 0, 13, 13);
    NSMutableAttributedString *attachText= [NSMutableAttributedString yy_attachmentStringWithContent:topImageV contentMode:UIViewContentModeScaleAspectFit attachmentSize:topImageV.frame.size alignToFont:Font(12) alignment:YYTextVerticalAlignmentCenter];
    [attri insertAttributedString:attachText atIndex:0];
    
    self.nameLab.numberOfLines = 0;
    self.nameLab.attributedText = attri;
}

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    NSMutableString *titleStr = [NSMutableString new];
    for (int i=0; i< titleArr.count; i++) {
       NSDictionary *dict = titleArr[i];
       NSString *title = [NSString stringWithFormat:@"%@",dict[@"title"]];
       [titleStr appendString:title];
       if (i != titleArr.count-1) {
          [titleStr appendString:@" > "];
       }
    }
    WS(weakSelf);
   NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:titleStr];
    for (int i=0; i< titleArr.count; i++) {
        NSDictionary *dict = titleArr[i];
        NSString *title = [NSString stringWithFormat:@"%@",dict[@"title"]];
        NSRange range ;
        range = [titleStr rangeOfString:title];
        [attri yy_setTextHighlightRange:range color:[UIColor colorCommon65GreyBlackColor] backgroundColor:[UIColor colorTextWhiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSString *textStr = [text.string substringWithRange:range];
            NSString *parentIdStr  = [weakSelf getWithParentidText:textStr];
            weakSelf.selectUnit(parentIdStr);
        }];
        if (i == titleArr.count-1) {
            [attri yy_setTextHighlightRange:range color:[UIColor colorConstantCommonBlueColor] backgroundColor:[UIColor colorTextWhiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSString *textStr = [text.string substringWithRange:range];
                NSString *parentIdStr  = [weakSelf getWithParentidText:textStr];
                weakSelf.selectUnit(parentIdStr);
            }];
        }
    }
    UIImageView *topImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suggetion_select_top"]];
      topImageV.frame = CGRectMake(0, 0, 13, 13);
      NSMutableAttributedString *attachText= [NSMutableAttributedString yy_attachmentStringWithContent:topImageV contentMode:UIViewContentModeScaleAspectFit attachmentSize:topImageV.frame.size alignToFont:Font(12) alignment:YYTextVerticalAlignmentCenter];
   [attri insertAttributedString:attachText atIndex:0];
   self.nameLab.numberOfLines = 0;
   self.nameLab.preferredMaxLayoutWidth =KScreenW-KSIphonScreenW(24);
   self.nameLab.attributedText = attri;
}

// 获取上级id
-(NSString *) getWithParentidText:(NSString*)text{
    NSString *parentIdStr = @"";
    for (int i=0; i< _titleArr.count; i++) {
       NSDictionary *dict = _titleArr[i];
       NSString *title = [NSString stringWithFormat:@"%@",dict[@"title"]];
        if ([text isEqualToString:title]) {
            parentIdStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
            return parentIdStr;
        }
    }
    return parentIdStr;
}
// 计算高度
+(CGFloat) getSelectUnitHeaderViewHgith:(NSArray*)titleArr{
    CGFloat hegith = 20;
    NSMutableString *titleStr = [NSMutableString new];
    for (int i=0; i< titleArr.count; i++) {
       NSDictionary *dict = titleArr[i];
       NSString *title = [NSString stringWithFormat:@"%@",dict[@"title"]];
       [titleStr appendString:title];
       if (i != titleArr.count-1) {
          [titleStr appendString:@" > "];
       }
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:titleStr];
    UIImageView *topImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suggetion_select_top"]];
    topImageV.frame = CGRectMake(0, 0, 13, 13);
    NSMutableAttributedString *attachText= [NSMutableAttributedString yy_attachmentStringWithContent:topImageV contentMode:UIViewContentModeScaleAspectFit attachmentSize:topImageV.frame.size alignToFont:Font(12) alignment:YYTextVerticalAlignmentCenter];
    [attri insertAttributedString:attachText atIndex:0];
    
    //
    CGFloat attHeigh =[ attri boundingRectWithSize:CGSizeMake(KScreenW-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    
    hegith += attHeigh;
    
    return hegith;
}



@end
