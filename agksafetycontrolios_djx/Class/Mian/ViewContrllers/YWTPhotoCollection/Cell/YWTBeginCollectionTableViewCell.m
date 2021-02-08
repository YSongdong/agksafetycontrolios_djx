//
//  BeginCollectionTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBeginCollectionTableViewCell.h"

@interface YWTBeginCollectionTableViewCell ()



@end

@implementation YWTBeginCollectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCollectionVew];
    }
    return self;
}

-(void) createCollectionVew{
    
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
    
    self.colletionBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.colletionBtn];
    [self.colletionBtn setTitle:@"重新采集" forState:UIControlStateNormal];
    [self.colletionBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.colletionBtn.titleLabel.font = Font(16);
    self.colletionBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.colletionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.colletionBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.colletionBtn.layer.masksToBounds = YES;
    self.colletionBtn.layer.borderWidth = 1;
    self.colletionBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    [self.colletionBtn addTarget:self action:@selector(selectBeginBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) selectBeginBtn :(UIButton *) sender{
    self.selectCollectionBlock();
}
-(void)setShowBtnStatu:(showCollectionBtnStatu)showBtnStatu{
    _showBtnStatu = showBtnStatu;
    if (showBtnStatu == cellPhotoCollectionPhoto) {
        self.colletionBtn.hidden = NO;
    }else{
        self.colletionBtn.hidden = YES;
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
