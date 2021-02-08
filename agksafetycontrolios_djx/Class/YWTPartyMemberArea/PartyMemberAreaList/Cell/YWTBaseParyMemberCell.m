//
//  YWTBaseParyMemberCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTBaseParyMemberCell.h"


@implementation YWTBaseParyMemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCellView];
    }
    return self;
}
-(void) initCellView{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.cellBgView = [[UIView alloc]init];
    [self.contentView addSubview:self.cellBgView];
    self.cellBgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.cellBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.right.left.bottom.equalTo(weakSelf);
    }];
    
    // 点击详情背景
    self.clickBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cellBgView addSubview:self.clickBgBtn];
    [self.clickBgBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorTextWhiteColor]] forState:UIControlStateNormal];
    [self.clickBgBtn setBackgroundImage:[YWTTools imageWithColor:[[UIColor colorTextWhiteColor]colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
    [self.clickBgBtn addTarget:self action:@selector(selectArticleDetaAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 头像视图
    _avatarImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kCellTo, kBlank+10, kAvatarWidth, kAvatarWidth)];
    [self.clickBgBtn addSubview:_avatarImageV];
    _avatarImageV.image = [UIImage imageNamed:@"pary_list_uset"];
    _avatarImageV.layer.cornerRadius = kAvatarWidth/2;
    _avatarImageV.layer.masksToBounds = YES;
    
    //
    UIView *useinfoView = [[UIView alloc]init];
    useinfoView.userInteractionEnabled = NO;
    [self.clickBgBtn addSubview:useinfoView];
    
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
        make.right.equalTo(weakSelf.clickBgBtn).offset(-kCellTo);
        make.bottom.equalTo(weakSelf.departmentNameLab.mas_bottom);
        make.centerY.equalTo(weakSelf.avatarImageV.mas_centerY);
    }];
    
    
    // 正文
    _linkLabel = [YYLabel new];
    _linkLabel.textColor = [UIColor colorCommonBlackColor];
    _linkLabel.textVerticalAlignment = YYTextVerticalAlignmentBottom;
    [self.clickBgBtn addSubview:_linkLabel];
    [self.clickBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cellBgView);
        make.left.right.equalTo(weakSelf.cellBgView);
        make.bottom.equalTo(weakSelf.linkLabel.mas_bottom).offset(10);
    }];
    
    // 图片区
    _imageListView = [[YWTImageListView alloc] initWithFrame:CGRectZero];
    [_imageListView setSingleTapHandler:^(YWTImageView *imageView) {
        
    }];
    [self.cellBgView addSubview:_imageListView];
    
    // 视频view
    _cellVideoView = [[YWTCellVideoView alloc]initWithFrame:CGRectZero];
    [self.cellBgView addSubview:_cellVideoView];
    _cellVideoView.selectPlayVideo = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
            [weakSelf.delegate selectOPerateMenu:weakSelf operateType:3];
        }
    };
    
    // 操作view
    _menuView = [[YWTOperateMenuView alloc]initWithFrame:CGRectZero];
    [self.cellBgView addSubview:_menuView];
    // 点赞
    _menuView.selectLikeBtn = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
            [weakSelf.delegate selectOPerateMenu:weakSelf operateType:1];
        }
    };
    // 评论
    _menuView.selectCommentBtn = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
            [weakSelf.delegate selectOPerateMenu:weakSelf operateType:2];
        }
    };
}
// 选择详情
-(void) selectArticleDetaAction:(UIButton *) sender{
    if ([self.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
        [self.delegate selectOPerateMenu:self operateType:4];
    }
}

-(void)setModel:(YWTPartyEemberAreaModel *)model{
    _model = model;
    // 头像
    [YWTTools sd_setImageView:_avatarImageV WithURL:model.photo andPlaceholder:@"pary_list_uset"];
    // 昵称
    _nickNameLab.text = model.realname;
    // 文章浏览数
    [_menuView.viewingCountBtn setTitle:model.visitornum forState:UIControlStateNormal];
    // 文章回复数
    [_menuView.commentCountBtn setTitle:model.replynum forState:UIControlStateNormal];
    // 文章点赞数
    [_menuView.likeCountBtn setTitle:model.clickNum forState:UIControlStateNormal];
    // 单位
    _departmentNameLab.text = model.company;
    // 时间
    _timeLab.text = model.createtime;
    // 1 已点赞 2未点赞
    if ([model.give isEqualToString:@"1"]) {
        _menuView.likeCountBtn.selected = YES;
    }else{
        _menuView.likeCountBtn.selected = NO;
    }
    WS(weakSelf);
    // 正文
    CGFloat bottom = _avatarImageV.bottom + kPaddingValue;
    CGFloat rowHeight = 0;
    if ([model.content length]) {
        // 显示
        _linkLabel.hidden = NO;
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:model.content];
        [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,[model.content length])];
        _linkLabel.numberOfLines = 0;
        _linkLabel.preferredMaxLayoutWidth = KScreenW-24;
        _linkLabel.attributedText = attributedText;
        // 判断显示'全文'/'收起'
        CGFloat contentHeight = [_linkLabel.text boundingRectWithSize:CGSizeMake(KScreenW-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        if (contentHeight > 40) {
            //
            if (!model.isFullText) {
                contentHeight = 40;
                [self addSeeMoreButton:_linkLabel more:@"全文" moreColor:[UIColor colorWithHexString:@"#507daf"] before:@"..." tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                    if ([weakSelf.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
                        weakSelf.model.isFullText = YES;
                        [weakSelf.delegate selectOPerateMenu:weakSelf operateType:5];
                    }
                }];
            }else{
                [self addSeeMoreButton:_linkLabel more:@"收起" moreColor:[UIColor colorWithHexString:@"#507daf"] before:@"" tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                    if ([weakSelf.delegate respondsToSelector:@selector(selectOPerateMenu:operateType:)]) {
                        weakSelf.model.isFullText = NO;
                        [weakSelf.delegate selectOPerateMenu:weakSelf operateType:5];
                    }
                }];
            }
        }
        _linkLabel.font = Font(15);
        _linkLabel.frame = CGRectMake(kCellTo, bottom, KScreenW-24, contentHeight);
        bottom = _linkLabel.bottom + kPaddingValue;
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
    // 操作视图
    _menuView.frame = CGRectMake(0, bottom, KScreenW, 35);
    
    rowHeight = _menuView.bottom+10;
    
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
