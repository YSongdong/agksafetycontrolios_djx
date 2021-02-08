//
//  SDTools.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTools.h"

#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>


@implementation YWTTools
//touken和userid 返回新touken
+(NSString *)getNewToken{
    NSString *str =[YWTTools md5:[NSString stringWithFormat:@"%@%@",[YWTUserInfo obtainWithUserId],[YWTUserInfo obtainWithToken]]];
    return str;
}
//md5加密
+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}
//获取当前网络状态
+ (NSString *)getNetworkTypeByReachability
{
    NSString *network = @"";
    switch ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]) {
        case NotReachable:
            network = @"NONE";
            break;
        case ReachableViaWiFi:
            network = @"WIFI";
            break;
        case ReachableViaWWAN:
            network = @"WWAN";
            break;
        default:
            break;
    }
    if ([network isEqualToString:@""]) {
        network = @"NONE";
    }
    return network;
}

//图片显示
+(void)sd_setImageView:(UIImageView *)imageView WithURL:(NSString *)str andPlaceholder:(NSString *)placeholderStr
{
    if ([str isEqualToString:@""] || [str isKindOfClass:[NSNull class]] || str == nil) {
        NSURL *url =  [NSURL URLWithString:@""];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeholderStr]options:SDWebImageRetryFailed];
    }else{
        NSURL *url =  [NSURL URLWithString:str];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeholderStr]options:SDWebImageRetryFailed];
    }
}
//字条串是否包含有某字符串
+(BOOL)getHasBigStr:(NSString *) bigStr rangeOfString:(NSString *)samilStr{
    BOOL isHas = NO;
    if ([bigStr rangeOfString:samilStr].location == NSNotFound) {
        isHas = NO;
    } else {
        isHas = YES;
    }
    return isHas;
}

//手机型号
+ (NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    return deviceModel;
}
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, KScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height;
}
// *  改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space andFont:(UIFont*)font {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
/*
 根据颜色生成图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color andCGRect:(CGRect)imageRect andCornersSize:(float)cornerRadius{
    // 开始画图的上下文
    UIGraphicsBeginImageContext(imageRect.size);
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, imageRect.size.width, imageRect.size.height));
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // 绘制图片
    [image drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image1;
}
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小 spaceStr 行间距
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(CGFloat)font withWidth:(CGFloat)width withSpace:(CGFloat)spaceStr{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = spaceStr;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, KScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

// id转json字符串方法
+(NSString *)convertToJsonData:(id )dataArr{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
// JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 改变字体和颜色
 
 @param totalStr 总文字
 @param textStr 改变的文字
 @param textColor 改变文字颜色
 @return    UIlabel  富文本
 */
+(NSMutableAttributedString *) getAttrbuteTotalStr:(NSString *)totalStr  andAlterTextStr:(NSString *)textStr andTextColor:(UIColor *)textColor andTextFont:(UIFont *) textFont{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:totalStr];
    NSRange range;
    range = [totalStr rangeOfString:textStr];
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:textFont range:range];
    }
    return attributStr;
}

//传入 秒  得到 xx:xx:xx
+(NSString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
    return format_time;
}
// 计算任意2个时间的之间的间隔
+(NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime andFormatter:(NSString *)format{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:format];//根据自己的需求定义格式
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
#pragma mark - 获取当前时间的 时间戳
+(NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return timeSp;
}
// 根据当前时间 获取出文件名
+(NSString *) getNowTimeFeildNameFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return  dateString;
}
// 根据文件地址返回大小
+(long long) fileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager =[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    return 0;
}
// 根据 monitor 判断是否开启人脸 YES 是 NO 不是 默认不开启
+(BOOL) getWithFaceMonitorStr:(NSString *)monitorStr{
    BOOL isFace = NO;
    isFace = [monitorStr isEqualToString:@"1"] ? YES : NO;
    return isFace;
}

// 根据返回的文件大小是否超过5M
+(BOOL) getWithFileSizePass5MFileNameStr:(NSString *)fileName{
    BOOL isPass = NO;
    double fileSize = [fileName doubleValue];
    if (fileSize > 5*1024*1024) {
        isPass = YES;
    }
    return isPass;
}

// 字符串转出html 显示
+(NSString *) getWithNSStringGoHtmlString:(NSString*)htmlStr{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UILabel *lab = [UILabel alloc];
    lab.attributedText =attrStr;
    return lab.text;
}
//根据颜色值来生成UIImage
+ (UIImage *)imageWithColor:(UIColor *)color{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}
// UILabel 富文本
/*
 nameStr : 传入的文字
 colorStr   : 要想修改的文字
 */
+(NSMutableAttributedString *) getAttrbuteTextStr:(NSString *)textStr andAlterColorStr:(NSString *)colorStr andColor:(UIColor *)textColor  andFont:(UIFont*)textFont{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSRange range;
    range = [textStr rangeOfString:colorStr];
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:textFont range:range];
    }
    return attributStr;
}

// 判断是否要变颜色  YES 改变   NO 不改变  默认 NO
+(BOOL) judgePlatFormChangeColor{
    BOOL isColor = NO;
    NSString *codeStr = [YWTUserInfo obtainWithLoginPlatformCode];
    if ([codeStr isEqualToString:@"111000"]) {
        isColor = YES;
    }
    return isColor;
}
@end
