//
//  BaseWorkMeetingCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/******************** 班前班后会   ***************/
typedef enum {
    showBaseWorkMeetingType = 0,  // 班前班后会
    showBaseWorkTechnicalType ,   // 技术交底
}showBaseWorkType;

@interface YWTBaseWorkMeetingCell : UITableViewCell
// 类型
@property (nonatomic,assign) showBaseWorkType cellType;
// 工作地点
@property (nonatomic,strong) UITextView *workAddressTextView;
// 工作编号
@property (nonatomic,strong) UITextView *workNumerTextView;
// 会议标题
@property (nonatomic,strong) UITextView *meetTitleTextView;

@property (nonatomic,strong) FSTextView *fsTextView;

@property (nonatomic,strong) NSDictionary *dict;
// 点击完成
@property (nonatomic,copy) void(^selectRutureKeyBord)(NSInteger index,NSString *textStr);
// 内容
@property (nonatomic,copy) void(^selectContentKeyBord)(NSString *contentStr);
@end

NS_ASSUME_NONNULL_END
