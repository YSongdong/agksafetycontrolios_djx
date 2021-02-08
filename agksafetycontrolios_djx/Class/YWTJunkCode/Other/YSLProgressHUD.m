//
//  YSLProgressHUD.m
//  TestDemo
//
//  Created by creazylee on 2018/8/27.
//  Copyright © 2018年 creazylee. All rights reserved.
//

#import "YSLProgressHUD.h"

typedef NS_ENUM(NSInteger, YSLProgressHUDStyle) {
    YSLProgressHUDStyleHidden,
    YSLProgressHUDStyleSuccess,
    YSLProgressHUDStyleWarning,
    YSLProgressHUDStyleError
};

@interface YSLProgressHUD()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *tipsImageView;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation YSLProgressHUD

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static id _instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance ;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
    }
    
    return _contentView;
}

- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        _tipsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_tipsImageView];
    }
    
    return _tipsImageView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_messageLabel];
    }
    
    return _messageLabel;
}

- (void)configUI:(NSString *)msg style:(YSLProgressHUDStyle)style {
    UIImage *tipsImage = nil;
    switch (style) {
        case YSLProgressHUDStyleSuccess:
            tipsImage = [UIImage imageNamed:@"icon_tc_right"];
            break;
        case YSLProgressHUDStyleWarning:
            tipsImage = [UIImage imageNamed:@"icon_tc_tips"];
            break;
        case YSLProgressHUDStyleError:
            tipsImage = [UIImage imageNamed:@"icon_tc_tips"];
            break;
            
        default:
            break;
    }
    
    CGRect vRect =CGRectZero;
    vRect.size.height = 40;
    
    
    if (tipsImage) {
        CGSize imgSize = tipsImage.size;
        self.tipsImageView.image = tipsImage;
        self.tipsImageView.frame = CGRectMake(15, vRect.size.height/2 - imgSize.height/2, imgSize.width, imgSize.height);
    }else {
        self.tipsImageView.image = nil;
        self.tipsImageView.frame = CGRectZero;
    }
    
    self.messageLabel.text = msg;
    CGRect rect = CGRectZero;
    rect.origin.x = CGRectGetMaxX(self.tipsImageView.frame) + 8;
    rect.origin.y = 0;
    rect.size.height = 40;
    rect.size.width = 300;
    self.messageLabel.frame = rect;
    
    vRect.origin.y = KScreenH * 0.45;
    vRect.size.width = CGRectGetMaxX(rect) + 15;
    vRect.origin.x = KScreenW/2 - vRect.size.width/2;
    self.contentView.frame = vRect;
}

- (void)showProgressMessage:(NSString *)msg style:(YSLProgressHUDStyle)style {
    [self configUI:msg style:style];
    
    self.contentView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self.contentView];
    [UIView animateWithDuration:0.24 delay:0.0 options:(UIViewAnimationCurveEaseOut|UIViewAnimationOptionAllowUserInteraction) animations:^{
        self.contentView.alpha=1.0;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.contentView.alpha = 0;
            [self.contentView removeFromSuperview];
        });
    }];
}

+ (void)showErrorWithMessage:(NSString *)msg {
    [[YSLProgressHUD shareInstance] showProgressMessage:msg style:YSLProgressHUDStyleError];
}

+ (void)showWarningWithMessage:(NSString *)msg {
    [[YSLProgressHUD shareInstance] showProgressMessage:msg style:YSLProgressHUDStyleWarning];
}

+ (void)showSuccessWithMessage:(NSString *)msg {
    [[YSLProgressHUD shareInstance] showProgressMessage:msg style:YSLProgressHUDStyleSuccess];
}



@end
