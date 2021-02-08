//
//  NSString+YWTEncodingCharacters.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2020/3/5.
//  Copyright © 2020 世界之窗. All rights reserved.
//

#import "NSString+YWTEncodingCharacters.h"

#import <UIKit/UIKit.h>


@implementation NSString (YWTEncodingCharacters)

+(NSString*) byAddingAllCharactersStr:(NSString*)encodStr{
    NSString *encodedUrl = [encodStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#^{}\"[]|\\<> "].invertedSet];
    return encodedUrl;
}


@end
