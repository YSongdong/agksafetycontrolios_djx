//
//  updatePhotoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTUpdatePhotoTableViewCell.h"

@implementation YWTUpdatePhotoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCollectionVew];
    }
    return self;
}

-(void) createCollectionVew{
    
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
    
    self.updateColletionBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.updateColletionBtn];
    [self.updateColletionBtn setTitle:@"立即上传" forState:UIControlStateNormal];
    [self.updateColletionBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.updateColletionBtn.titleLabel.font = Font(16);
    [self.updateColletionBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.updateColletionBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.updateColletionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(10));
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.updateColletionBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.updateColletionBtn.layer.masksToBounds = YES;
    [self.updateColletionBtn addTarget:self action:@selector(selectBeginBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) selectBeginBtn :(UIButton *) sender{
    self.selectActionBlock();
}
-(void)setShowUpdateBtnStatu:(showCellUpdateBtnStatu)showUpdateBtnStatu{
    _showUpdateBtnStatu = showUpdateBtnStatu;
    if (showUpdateBtnStatu == cellUpdateBtnNotUploaded) {
        self.updateColletionBtn.hidden = NO;
        // 未上传
        [self.updateColletionBtn setTitle:@"立即采集" forState:UIControlStateNormal];
        [self.updateColletionBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    }else if (showUpdateBtnStatu == cellUpdateBtnCollectionPhoto){
        self.updateColletionBtn.hidden = NO;
        // 采集照片中
        [self.updateColletionBtn setTitle:@"立即上传" forState:UIControlStateNormal];
        [self.updateColletionBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    }else if (showUpdateBtnStatu == cellUpdateBtnFristHome){
        self.updateColletionBtn.hidden = NO;
        // 首次登陆
        [self.updateColletionBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [self.updateColletionBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    }else if (showUpdateBtnStatu == cellUpdateBtnCheckError){
        self.updateColletionBtn.hidden = NO;
        // 审核失败
        [self.updateColletionBtn setTitle:@"重新采集" forState:UIControlStateNormal];
        [self.updateColletionBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    }else{
        self.updateColletionBtn.hidden = YES;
    }
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
