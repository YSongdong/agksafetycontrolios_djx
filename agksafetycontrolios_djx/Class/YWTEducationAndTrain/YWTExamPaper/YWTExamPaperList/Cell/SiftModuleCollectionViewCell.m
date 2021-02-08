//
//  SiftModuleCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "SiftModuleCollectionViewCell.h"

@interface SiftModuleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *moduleBgView;
@property (weak, nonatomic) IBOutlet UILabel *moduleTitleLab;

@end

@implementation SiftModuleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.moduleBgView.layer.cornerRadius = 4;
    self.moduleBgView.layer.masksToBounds = YES;
    
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.moduleTitleLab.text = dict[@"title"];
    
    // isSelect  1 选中 2 不选中
    NSString *isSelectStr = [NSString stringWithFormat:@"%@",dict[@"isSelect"]];
    if ([isSelectStr isEqualToString:@"1"]) {
        self.moduleBgView.backgroundColor = [UIColor  colorWithHexString:@"#fbe4e2"];
        self.moduleTitleLab.textColor = [UIColor colorLineCommonBlueColor];
    }else{
        self.moduleBgView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        self.moduleTitleLab.textColor = [UIColor colorCommonGreyBlackColor];
    }

}



@end
