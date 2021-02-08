//
//  FileMarkTableViewCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTFileMarkTableViewCell.h"

@interface YWTFileMarkTableViewCell ()

// 类型
@property (nonatomic,strong) UILabel *typeTitleLab;

// 内容
@property (nonatomic,strong) UILabel *contentLab;

@end


@implementation YWTFileMarkTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createFileMarkCell];
    }
    return self;
}
-(void) createFileMarkCell{
    __weak typeof(self) weakSelf = self;
    
    self.typeTitleLab = [[UILabel alloc]init];
    [self addSubview:self.typeTitleLab];
    self.typeTitleLab.text = @"文件描述";
    self.typeTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.typeTitleLab.font = BFont(16);
    [self.typeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(17));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(13));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(13));
    }];
    
    // 内容
    self.contentLab = [[UILabel alloc]init];
    [self addSubview:self.contentLab];
    self.contentLab.text = @"";
    self.contentLab.textColor = [UIColor colorCommonBlackColor];
    self.contentLab.font = Font(15);
    self.contentLab.numberOfLines = 0;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeTitleLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(13));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(13));
    }];
}


-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 类型
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeStr isEqualToString:@"video"]) {
         // 视频
        self.typeTitleLab.text = @"视频描述";
    }else if ([typeStr isEqualToString:@"audio"]) {
        // 音频
        self.typeTitleLab.text = @"音频描述";
    }else{
       self.typeTitleLab.text = @"文件描述";
    }
    
    // 内容
    NSString *descrStr = [NSString stringWithFormat:@"%@",dict[@"descr"]];
    self.contentLab.text = descrStr;
}

// 计算高度
+(CGFloat) getWithFileMarkHeightCell:(NSDictionary *)dict{
    CGFloat height = KSIphonScreenH(40);
    
    // 内容
    NSString *descrStr = [NSString stringWithFormat:@"%@",dict[@"descr"]];
    CGFloat descHeight = [YWTTools getSpaceLabelHeight:descrStr withFont:15 withWidth:KScreenW-KSIphonScreenW(26) withSpace:2];
    height += descHeight;
    
    height += KSIphonScreenH(13);
    
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
