//
//  BaseAddAnnexPushView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseAddAnnexPushView.h"

@implementation YWTBaseAddAnnexPushView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAddAnnexView];
    }
    return self;
}
-(void) createAddAnnexView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UITapGestureRecognizer *bigTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBigBgView)];
    [bigBgView addGestureRecognizer:bigTap];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = BFont(14);
    cancelBtn.backgroundColor = [UIColor colorCommonGreyColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSTabbarH);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(cancelBtn.mas_top);
        make.height.equalTo(@(KSIphonScreenH(220)));
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    
    CGFloat btnW = KScreenW/4;
    
    // 图片
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:photoBtn];
    photoBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top);
        make.left.equalTo(contentView);
        make.width.equalTo(@(btnW));
        make.height.equalTo(@108);
    }];
    [photoBtn addTarget:self action:@selector(selectPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];

    UIView *photoView = [[UIView alloc]init];
    [photoBtn addSubview:photoView];
    photoView.userInteractionEnabled = NO;
    
    UIImageView *photoImageV = [[UIImageView alloc]init];
    [photoView addSubview:photoImageV];
    photoImageV.image = [UIImage imageNamed:@"annex_photo"];
    [photoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(photoView);
    }];

    UILabel *showPhotoLab = [[UILabel alloc]init];
    [photoView addSubview:showPhotoLab];
    showPhotoLab.text = @"图片";
    showPhotoLab.textColor = [UIColor colorCommonBlackColor];
    showPhotoLab.font = Font(14);
    [showPhotoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoImageV.mas_bottom).offset(KSIphonScreenH(11));
        make.centerX.equalTo(photoImageV.mas_centerX);
    }];

    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(photoImageV);
        make.bottom.equalTo(showPhotoLab.mas_bottom).offset(2);
        make.centerX.equalTo(photoBtn.mas_centerX);
        make.centerY.equalTo(photoBtn.mas_centerY);
    }];

    // 相机
    UIButton *camereaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:camereaBtn];
    camereaBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [camereaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoBtn.mas_right);
        make.width.height.equalTo(photoBtn);
        make.centerY.equalTo(photoBtn.mas_centerY);
    }];
    [camereaBtn addTarget:self action:@selector(selectcameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *cameraView = [[UIView alloc]init];
    [camereaBtn addSubview:cameraView];
    cameraView.userInteractionEnabled = NO;
    
    UIImageView *cameraImageV = [[UIImageView alloc]init];
    [cameraView addSubview:cameraImageV];
    cameraImageV.image = [UIImage imageNamed:@"annex_camera"];
    [cameraImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(cameraView);
    }];
    
    UILabel *showCameraLab = [[UILabel alloc]init];
    [cameraView addSubview:showCameraLab];
    showCameraLab.text = @"拍照";
    showCameraLab.textColor = [UIColor colorCommonBlackColor];
    showCameraLab.font = Font(14);
    [showCameraLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cameraImageV.mas_bottom).offset(KSIphonScreenH(11));
        make.centerX.equalTo(cameraImageV.mas_centerX);
    }];
    
    [cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(cameraImageV);
        make.bottom.equalTo(showCameraLab.mas_bottom).offset(2);
        make.centerX.equalTo(camereaBtn.mas_centerX);
        make.centerY.equalTo(camereaBtn.mas_centerY);
    }];

    // 音频
    UIButton *audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:audioBtn];
    audioBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(camereaBtn.mas_right);
        make.width.height.equalTo(camereaBtn);
        make.centerY.equalTo(camereaBtn.mas_centerY);
    }];
    [audioBtn addTarget:self action:@selector(selectAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *audioView = [[UIView alloc]init];
    [audioBtn addSubview:audioView];
    audioView.userInteractionEnabled = NO;
    
    UIImageView *audioImageV = [[UIImageView alloc]init];
    [audioView addSubview:audioImageV];
    audioImageV.image = [UIImage imageNamed:@"annex_audio"];
    [audioImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(audioView);
    }];
    
    UILabel *showAudioLab = [[UILabel alloc]init];
    [audioView addSubview:showAudioLab];
    showAudioLab.text = @"音频";
    showAudioLab.textColor = [UIColor colorCommonBlackColor];
    showAudioLab.font = Font(14);
    [showAudioLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(audioImageV.mas_bottom).offset(KSIphonScreenH(11));
        make.centerX.equalTo(audioImageV.mas_centerX);
    }];
    
    [audioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(audioImageV);
        make.bottom.equalTo(showAudioLab.mas_bottom).offset(2);
        make.centerX.equalTo(audioBtn.mas_centerX);
        make.centerY.equalTo(audioBtn.mas_centerY);
    }];
 
    // 录音
    UIButton *recorderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:recorderBtn];
    recorderBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [recorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(audioBtn.mas_right);
        make.width.height.equalTo(audioBtn);
        make.centerY.equalTo(audioBtn.mas_centerY);
    }];
    [recorderBtn addTarget:self action:@selector(selectRecorderBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *recorderView = [[UIView alloc]init];
    [recorderBtn addSubview:recorderView];
    recorderView.userInteractionEnabled = NO;
    
    UIImageView *recorderImageV = [[UIImageView alloc]init];
    [recorderView addSubview:recorderImageV];
    recorderImageV.image = [UIImage imageNamed:@"annex_recorder"];
    [recorderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(recorderView);
    }];
    
    UILabel *showRecorderLab = [[UILabel alloc]init];
    [recorderView addSubview:showRecorderLab];
    showRecorderLab.text = @"录音";
    showRecorderLab.textColor = [UIColor colorCommonBlackColor];
    showRecorderLab.font = Font(14);
    [showRecorderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recorderImageV.mas_bottom).offset(KSIphonScreenH(11));
        make.centerX.equalTo(recorderImageV.mas_centerX);
    }];
    [recorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(recorderImageV);
        make.bottom.equalTo(showRecorderLab.mas_bottom).offset(2);
        make.centerX.equalTo(recorderBtn.mas_centerX);
        make.centerY.equalTo(recorderBtn.mas_centerY);
    }];
 
    // 视频
    UIButton *documentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:documentBtn];
    documentBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [documentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoBtn.mas_bottom);
        make.width.height.equalTo(photoBtn);
        make.centerX.equalTo(photoBtn.mas_centerX);
    }];
    [documentBtn addTarget:self action:@selector(selectDocumentBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *documentView = [[UIView alloc]init];
    [documentBtn addSubview:documentView];
    documentView.userInteractionEnabled = NO;
    
    UIImageView *docuImageV = [[UIImageView alloc]init];
    [documentView addSubview:docuImageV];
    docuImageV.image = [UIImage imageNamed:@"base_type_video"];
    [docuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(documentView);
    }];
    
    UILabel *showDocuLab = [[UILabel alloc]init];
    [documentView addSubview:showDocuLab];
    showDocuLab.text = @"视频";
    showDocuLab.textColor = [UIColor colorCommonBlackColor];
    showDocuLab.font = Font(14);
    [showDocuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(docuImageV.mas_bottom).offset(KSIphonScreenH(11));
        make.centerX.equalTo(docuImageV.mas_centerX);
    }];
    
    [documentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(docuImageV);
        make.bottom.equalTo(showDocuLab.mas_bottom).offset(2);
        make.centerX.equalTo(documentBtn.mas_centerX);
        make.centerY.equalTo(documentBtn.mas_centerY);
    }];
    
    
    // 录视频
    UIButton *recordVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:recordVideoBtn];
    recordVideoBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [recordVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(documentBtn.mas_right);
        make.width.height.equalTo(documentBtn);
        make.centerY.equalTo(documentBtn.mas_centerY);
    }];
    [recordVideoBtn addTarget:self action:@selector(selectRecordVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *recordVideoView = [[UIView alloc]init];
    [recordVideoBtn addSubview:recordVideoView];
    recordVideoView.userInteractionEnabled = NO;

    UIImageView *recordVideoImageV = [[UIImageView alloc]init];
    [recordVideoView addSubview:recordVideoImageV];
    recordVideoImageV.image = [UIImage imageNamed:@"annex_recorderVideo"];
    [recordVideoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(recordVideoView);
    }];

    UILabel *showRecordVideoLab = [[UILabel alloc]init];
    [recordVideoView addSubview:showRecordVideoLab];
    showRecordVideoLab.text = @"录视频";
    showRecordVideoLab.textColor = [UIColor colorCommonBlackColor];
    showRecordVideoLab.font = Font(14);
    [showRecordVideoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recordVideoImageV.mas_bottom).offset(KSIphonScreenH(11));
        make.centerX.equalTo(recordVideoImageV.mas_centerX);
    }];
    
    [recordVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(recordVideoImageV);
        make.bottom.equalTo(showRecordVideoLab.mas_bottom).offset(2);
        make.centerX.equalTo(recordVideoBtn.mas_centerX);
        make.centerY.equalTo(recordVideoBtn.mas_centerY);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(photoBtn.mas_top);
        make.bottom.equalTo(documentBtn.mas_bottom);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
   
}
// 移除视图
-(void)removeBigBgView{
    self.removeView();
    [self removeFromSuperview];
}
// 取消视图
-(void) selectCancelBtn:(UIButton *) sender{
    [self removeFromSuperview];
}
// 文档
-(void) selectDocumentBtn:(UIButton *) sender{
    self.switchVideo();
}
// 图片
-(void) selectPhotoBtn:(UIButton *) sender{
    self.switchPhotoLibary();
}
// 相机
-(void) selectcameraBtn:(UIButton *) sneder{
    self.switchCemera();
}
// 音频
-(void) selectAudioBtn:(UIButton *) sender{
    self.switchAudioList();
}
// 录音
-(void) selectRecorderBtn:(UIButton *) sender{
    self.switchRecording();
}
// 录视频
-(void) selectRecordVideoBtn:(UIButton *) sender{
    self.switchRecordVideo();
}



@end
