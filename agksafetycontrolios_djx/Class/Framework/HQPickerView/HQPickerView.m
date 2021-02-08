//
//  HQPickerView.m
//  HQPickerView
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 judian. All rights reserved.
//

#import "HQPickerView.h"

#import <Masonry.h>
/** 屏幕宽高 */
#define kScreenBounds [UIScreen mainScreen].bounds
#define KScreenWidth [[UIScreen mainScreen]bounds].size.width
#define KScreenHeight [[UIScreen mainScreen]bounds].size.height

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface HQPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *completionBtn;
@property (nonatomic, strong) UIView* line;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSString *selectedStr;


@end

@implementation HQPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        self.backgroundColor = self.backgroundColor = RGBA(51, 51, 51, 0.3);
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 260)];
        self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
        [self addSubview:self.bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
        [self addGestureRecognizer:tap];
        
        //显示动画
        [self showAnimation];
        
        __weak typeof(self) weakSelf = self;
        UIView *btnBgView = [[UIView alloc]init];
        [self.bgView addSubview:btnBgView];
        btnBgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf.bgView);
            make.height.equalTo(@(KSIphonScreenH(44)));
        }];
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBgView addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(44);
        }];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.completionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBgView addSubview:self.completionBtn];
        [self.completionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(44);
        }];
        self.completionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.completionBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.completionBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
        [self.completionBtn addTarget:self action:@selector(completionBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //线
        UIView *line = [UIView new];
        [btnBgView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(btnBgView);
            make.height.equalTo(@0.5);
        }];
        line.backgroundColor = RGBA(224, 224, 224, 1);
        self.line = line ;
        
        //显示timelab
        self.timeLab = [[UILabel alloc]init];
        [self.bgView addSubview:self.timeLab];
        self.timeLab.text = @"电压等级";
        self.timeLab.font = Font(18);
        self.timeLab.textColor = [UIColor colorCommon65GreyBlackColor];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.bgView.mas_centerX);
            make.centerY.equalTo(weakSelf.completionBtn.mas_centerY);
        }];
    }
    return self;
}
#pragma mark-----UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.customArr.count;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    // 设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        }
    }
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake((KScreenW-30)/2, 15,KScreenW-30.30, 30)];
    label.font=[UIFont systemFontOfSize:18.0];
    label.tag=component*100+row;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor colorCommonBlackColor];
    label.text = self.customArr[row];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedStr = self.customArr[row];
}
-(CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component {
    return 46;
}
- (void)setCustomArr:(NSArray *)customArr {
    _customArr = customArr;
    self.pickerView = [UIPickerView new];
    [self.bgView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.line);
        make.left.right.mas_equalTo(0);
    }];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.array addObject:customArr];
}

-(void)selectTap{
    [self removeFromSuperview];
    [self hideAnimation];
}
#pragma mark-----取消
- (void)cancelBtnClick{
    [self hideAnimation];
}
#pragma mark-----取消
- (void)completionBtnClick{
    NSString *str = [self.customArr objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:didSelectText:)]) {
        [self.delegate pickerView:self.pickerView didSelectText:str];
    }
    [self hideAnimation];
}

#pragma mark-----隐藏的动画
- (void)hideAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = KScreenHeight;
        self.bgView.frame = frame;
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark-----显示的动画
- (void)showAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = KScreenHeight-260;
        self.bgView.frame = frame;
    }];
}

@end
