//
//  SDTools.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTTools : NSObject
//touken和userid 返回新touken
+(NSString *)getNewToken;
//md5加密
+ (NSString *)md5:(NSString *)string;
//获取当前网络状态
+ (NSString *)getNetworkTypeByReachability;
//图片显示 placeholderStr 默认图片
+(void)sd_setImageView:(UIImageView *)imageView WithURL:(NSString *)str andPlaceholder:(NSString *)placeholderStr;
//手机型号
+ (NSString*)deviceModelName;
//字条串是否包含有某字符串
+(BOOL)getHasBigStr:(NSString *) bigStr rangeOfString:(NSString *)samilStr;
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space andFont:(UIFont*)font;
/*
 根据颜色生成图片
 */
+(UIImage*)imageWithColor:(UIColor*)color andCGRect:(CGRect)imageRect andCornersSize:(float)cornerRadius;
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小 spaceStr 行间距
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(CGFloat)font withWidth:(CGFloat)width withSpace:(CGFloat )spaceStr;

// id转json字符串方法
+(NSString *)convertToJsonData:(id )dataArr;

// JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 改变字体和颜色
 
 @param totalStr 总文字
 @param textStr 改变的文字
 @param textColor 改变文字颜色
 @return    UIlabel  富文本
 */
+(NSMutableAttributedString *) getAttrbuteTotalStr:(NSString *)totalStr  andAlterTextStr:(NSString *)textStr andTextColor:(UIColor *)textColor andTextFont:(UIFont*)textFont;

//传入 秒  得到 xx:xx:xx
+(NSString *)getMMSSFromSS:(NSString *)totalTime;

// 计算任意2个时间的之间的间隔
+(NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime andFormatter:(NSString *)format;
// 将某个时间戳转化成 时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
// 获取当前时间的 时间戳
+(NSInteger)getNowTimestamp;
// 根据当前时间 获取出文件名
+(NSString *) getNowTimeFeildNameFormatter:(NSString *)format;
// 根据文件地址返回大小
+(long long) fileSizeAtPath:(NSString*)filePath;
// 根据 monitor 判断是否 开启人脸 YES 是 NO 不是 默认不开启
+(BOOL) getWithFaceMonitorStr:(NSString *)monitorStr;

// 根据返回的文件大小是否超过5M  YES 超过  默认 NO   
+(BOOL) getWithFileSizePass5MFileNameStr:(NSString *)fileName;

// 字符串转出html 显示
+(NSString *) getWithNSStringGoHtmlString:(NSString*)htmlStr;
//根据颜色值来生成UIImage
+ (UIImage *)imageWithColor:(UIColor *)color;
//  
+(NSMutableAttributedString *) getAttrbuteTextStr:(NSString *)textStr andAlterColorStr:(NSString *)colorStr andColor:(UIColor *)textColor andFont:(UIFont*)textFont;

// 判断是否要变颜色  YES 改变   NO 不改变  默认 NO
+(BOOL) judgePlatFormChangeColor;

@end

NS_ASSUME_NONNULL_END
