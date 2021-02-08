//
//  YWTDetailInfoCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTDetailInfoCell.h"



#import "YWTImageListView.h"



@interface YWTDetailInfoCell ()
// 头像
@property (nonatomic,strong) UIImageView *avatarImageV;
// 名称
@property (nonatomic,strong) UILabel * nickNameLab;
// 部门
@property (nonatomic,strong) UILabel * departmentNameLab;
// 时间
@property (nonatomic,strong) UILabel * timeLab;
// 正文
@property (nonatomic,strong) UILabel * linkLabel;
// 图片view
@property (nonatomic,strong) YWTImageListView *imageListView;


@end

@implementation YWTDetailInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createInfoCell];
    }
    return self;
}
-(void) createInfoCell{
    WS(weakSelf);

    // 头像视图
    _avatarImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kCellTo, kBlank+10, kAvatarWidth, kAvatarWidth)];
    [self addSubview:_avatarImageV];
    _avatarImageV.image = [UIImage imageNamed:@"pary_list_uset"];
    _avatarImageV.layer.cornerRadius = kAvatarWidth/2;
    _avatarImageV.layer.masksToBounds = YES;
    
    //
    UIView *useinfoView = [[UIView alloc]init];
    useinfoView.userInteractionEnabled = NO;
    [self addSubview:useinfoView];
    
    // 名称
    _nickNameLab = [[UILabel alloc]init];
    [useinfoView addSubview:_nickNameLab];
    _nickNameLab.text = @"";
    _nickNameLab.textColor = [UIColor colorPatryNickNameColor];
    _nickNameLab.font = Font(16);
    [_nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(useinfoView);
    }];
    
    // 部门
    _departmentNameLab = [[UILabel alloc]init];
    [useinfoView addSubview:_departmentNameLab];
    _departmentNameLab.textColor = [UIColor colorCommonGreyBlackColor];
    _departmentNameLab.font = Font(12);
    _departmentNameLab.text = @"";
    [_departmentNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLab.mas_bottom).offset(2);
        make.left.equalTo(weakSelf.nickNameLab.mas_left);
    }];
    
    // 时间
    _timeLab = [[UILabel alloc]init];
    [useinfoView addSubview:_timeLab];
    _timeLab.textColor = [UIColor colorCommonGreyBlackColor];
    _timeLab.font = Font(12);
    _timeLab.text = @"";
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(useinfoView.mas_right);
        make.centerY.equalTo(weakSelf.nickNameLab.mas_centerY);
    }];
    
    [useinfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLab.mas_top);
        make.left.equalTo(weakSelf.avatarImageV.mas_right).offset(13);
        make.right.equalTo(weakSelf).offset(-kCellTo);
        make.bottom.equalTo(weakSelf.departmentNameLab.mas_bottom);
        make.centerY.equalTo(weakSelf.avatarImageV.mas_centerY);
    }];
    
    // 正文
    _linkLabel = [UILabel new];
    [self addSubview:_linkLabel];
    _linkLabel.textColor = [UIColor colorCommonBlackColor];
    _linkLabel.numberOfLines  = 0 ;
    _linkLabel.font = Font(15);
   

    // 图片区
    _imageListView = [[YWTImageListView alloc] initWithFrame:CGRectZero];
    [_imageListView setSingleTapHandler:^(YWTImageView *imageView) {
        
    }];
    [self addSubview:_imageListView];
    
    // 视频view
    _cellVideoView = [[YWTCellVideoView alloc]initWithFrame:CGRectZero];
    [self addSubview:_cellVideoView];
    _cellVideoView.selectPlayVideo = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
            [weakSelf.delegate selectOPerateMenu:weakSelf operateType:3];
        }
    };
}

-(void)setModel:(YWTPartyEemberAreaModel *)model{
    _model = model;
    // 头像
    [YWTTools sd_setImageView:_avatarImageV WithURL:model.photo andPlaceholder:@"pary_list_uset"];
    // 昵称
    _nickNameLab.text = model.realname;
    // 单位
    _departmentNameLab.text = model.company;
    // 时间
    _timeLab.text = model.createtime;
    // 正文
    CGFloat bottom = _avatarImageV.bottom + kPaddingValue;
    CGFloat rowHeight = 0;
    if ([model.content length]) {
        _linkLabel.text = model.content;
        CGFloat contentHeight = [YWTTools getSpaceLabelHeight:_linkLabel.text withFont:15 withWidth:KScreenW-24 withSpace:3];
        _linkLabel.frame = CGRectMake(kCellTo, bottom, KScreenW-24, contentHeight);
        bottom = _linkLabel.bottom + kCellTo;
    }else{
        rowHeight = 0;
        _linkLabel.text = @"";
        bottom = _avatarImageV.bottom + kPaddingValue;
    }
    
    // 图片
    _imageListView.imageModel = model;
    if ([model.filelist count] > 0) {
        _imageListView.origin = CGPointMake(_avatarImageV.left, bottom);
        bottom = _imageListView.bottom + kCellTo;
    }
    
    // 视频view
    // 隐藏v视频view
    _cellVideoView.hidden = YES;
    if ([model.types isEqualToString:@"3"]) {
        // 隐藏v视频view
        _cellVideoView.hidden = NO;
        _cellVideoView.coverUrlStr = model.preview;
        _cellVideoView.frame = CGRectMake(kCellTo, bottom, KScreenW-24, 135);
        bottom = _cellVideoView.bottom + kCellTo;
    }
    rowHeight = bottom+10;
    
    _model.rowHeight =  rowHeight;
}

// 图片渲染
- (void)loadPicture{
    [_imageListView loadPicture];
}
- (NSAttributedString*)addSeeMoreButton:(YYLabel*)label  more:(NSString*)more moreColor:(UIColor*)morecolor before:(NSString*)before tapAction:(void(^)(UIView*containerView,NSAttributedString*text,NSRange range ,CGRect rect ))blockTapAction{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",before? before:@"",more ? more :@""]];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:morecolor];
    hi.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        blockTapAction(containerView,text,range,rect);
    };
    
    text.yy_color = morecolor;
    text.yy_font =Font(16);
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:more]];
    
    YYLabel*seeMore = [[YYLabel alloc]init];
    seeMore.attributedText= text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
    
    label.truncationToken= truncationToken;
    
    return truncationToken;
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
