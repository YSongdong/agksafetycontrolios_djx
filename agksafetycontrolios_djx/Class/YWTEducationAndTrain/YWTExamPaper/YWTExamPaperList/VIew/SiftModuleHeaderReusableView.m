//
//  SiftModuleHeaderReusableView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "SiftModuleHeaderReusableView.h"

@interface SiftModuleHeaderReusableView ()

@property (weak, nonatomic) IBOutlet UIView *headerLineBgView;

@end


@implementation SiftModuleHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerLineBgView.backgroundColor = [UIColor colorLineCommonBlueColor];
    
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.titleNameLab.text = dict[@"title"];
    
}
@end
