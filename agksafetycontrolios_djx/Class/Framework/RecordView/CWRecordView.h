//
//  CWRecordView.h
//  QQVoiceDemo
//
//  Created by chavez on 2017/10/11.
//  Copyright © 2017年 陈旺. All rights reserved.
//

#import <UIKit/UIKit.h>
//----------------------录音界面---------------------------------//
@interface CWRecordView : UIView

@property (nonatomic,copy) void(^selectTureBtn)(NSDictionary *dict);

// 结束录音
-(void) stopRecordBtn;

@end
