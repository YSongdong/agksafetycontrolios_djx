//
//  TempExamQuestTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempExamQuestTableViewCell.h"

@interface YWTTempExamQuestTableViewCell ()
// 答案 选项
@property (nonatomic,strong) UIButton *answerOptionBtn;
// 答案 文字
@property (nonatomic,strong) UILabel *answerTextLab;

@property (nonatomic,strong) UIView *answerBgView;
// 答案 图片
@property (nonatomic,strong) UIImageView *answerImageV;

@end

@implementation YWTTempExamQuestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createTempTableViewCell];
    }
    return self;
}
-(void )createTempTableViewCell{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.answerOptionBtn = [[UIButton alloc]init];
    [self addSubview:self.answerOptionBtn];
    [self.answerOptionBtn setTitle:@"A" forState:UIControlStateNormal];
    [self.answerOptionBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    self.answerOptionBtn.titleLabel.font = Font(15);
    self.answerOptionBtn.userInteractionEnabled = NO;
    [self.answerOptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(11));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.height.width.equalTo(@(28));
    }];
    self.answerOptionBtn.layer.cornerRadius = 28/2;
    self.answerOptionBtn.layer.masksToBounds = YES;
    self.answerOptionBtn.layer.borderWidth = 1;
    self.answerOptionBtn.layer.borderColor = [UIColor colorWithHexString:@"#d6d6d6"].CGColor;
    //
    [self.answerOptionBtn setImage:[UIImage imageNamed:@"ico_xh_xz"] forState:UIControlStateSelected];
    self.answerOptionBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
   
    // 答案文字
    self.answerTextLab = [[UILabel alloc]init];
    [self addSubview:self.answerTextLab];
    self.answerTextLab.text = @"正确";
    self.answerTextLab.textColor = [UIColor colorCommonBlackColor];
    self.answerTextLab.font = Font(17);
    self.answerTextLab.numberOfLines = 0;
    [self.answerTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.answerOptionBtn.mas_top).offset(KSIphonScreenH(4));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(60));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
    }];
    //设置行距
    [YWTTools changeLineSpaceForLabel:self.answerTextLab WithSpace:3 andFont:Font(17)];
    
    //答案view
    self.answerBgView = [[UIView alloc]init];
    [self addSubview:self.answerBgView];
    self.answerBgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.answerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.answerTextLab.mas_bottom).offset(KSIphonScreenH(2));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
        make.height.equalTo(@(KSIphonScreenH(140)));
    }];
    // 加阴影
     self.answerBgView.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
    // 设置阴影偏移量
     self.answerBgView.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
     self.answerBgView.layer.shadowOpacity =0.2;
    // 设置阴影半径
     self.answerBgView.layer.shadowRadius = 5;
    
    // 答案图片
    self.answerImageV = [[UIImageView alloc]init];
    [self.answerBgView addSubview:self.answerImageV];
    self.answerImageV.image = [UIImage imageNamed:@"quest_ImageNomal"];
    self.answerImageV.userInteractionEnabled = YES;
    self.answerImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.answerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.answerBgView).offset(1.5);
        make.bottom.right.equalTo(weakSelf.answerBgView).offset(-1.5);
    }];
    [self.answerImageV setClipsToBounds:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigImageTap)];
    [self.answerImageV addGestureRecognizer:tap];
}
-(void)setListModel:(OptionListModel *)listModel{
    _listModel = listModel;
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger answerfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"AnswerFont"]integerValue] : 15 ;
    // 选项按钮 title
    [self.answerOptionBtn setTitle:listModel.title forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    
    if (self.anserQuestType == showAnswerQuestPhotoAndTextType ) {
        self.answerTextLab.text = listModel.option;
        self.answerTextLab.font = Font(answerfontSize);
        if (![listModel.photo isEqualToString:@""]) {
            [YWTTools sd_setImageView:self.answerImageV WithURL:listModel.photo andPlaceholder:@"quest_ImageNomal"];
            [self.answerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.answerOptionBtn.mas_bottom).offset(KSIphonScreenH(5));
                make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
                make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
                make.height.equalTo(@(KSIphonScreenH(140)));
            }];
        }else{
            self.answerBgView.hidden = YES;
        }
    }else if (self.anserQuestType == showAnswerQuestPhotoType){
        if (![listModel.photo isEqualToString:@""]) {
            [YWTTools sd_setImageView:self.answerImageV WithURL:listModel.photo andPlaceholder:@"quest_ImageNomal"];
            
            [self.answerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.answerOptionBtn.mas_bottom).offset(KSIphonScreenH(5));
                make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
                make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
                make.height.equalTo(@(KSIphonScreenH(140)));
            }];
        }else{
            self.answerBgView.hidden = YES;
        }
    }else {
        self.answerTextLab.text = listModel.option;
        self.answerTextLab.font = Font(answerfontSize);
    }
    if (self.questMode == showQuestAnswerMode) {
         // 判断是否选中
        // 获取用户选择答案
        NSString *userAnswerStr = [[DataBaseManager sharedManager] getObtainUserSelectAnswer:self.questionModel.Id];
        
        if (![userAnswerStr isEqualToString:@""] && [userAnswerStr containsString:listModel.title]) {
            self.answerOptionBtn.selected = YES;
        }else{
             self.answerOptionBtn.selected = NO;
        }
    }
}
// 答案类型
-(void)setAnserQuestType:(showAnswerQuestType)anserQuestType{
    _anserQuestType = anserQuestType;
    __weak typeof(self) weakSelf = self;
    if (self.anserQuestType == showAnswerQuestPhotoAndTextType ) {
        // 图片加文字
        self.answerTextLab.hidden = NO;
        
        self.answerBgView.hidden = NO;
        
        [self.answerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.answerOptionBtn.mas_bottom).offset(KSIphonScreenH(5));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
            make.height.equalTo(@(KSIphonScreenH(140)));
        }];
    }else if (self.anserQuestType == showAnswerQuestTextType){
        // 只有文字
        self.answerTextLab.hidden = NO;
        // 隐藏 图片
        self.answerBgView.hidden = YES;
        
    }else if (self.anserQuestType == showAnswerQuestPhotoType){
        // 只有图片
        self.answerBgView.hidden = NO;
        // 隐藏
        self.answerTextLab.hidden = YES;
        
        [self.answerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.answerOptionBtn.mas_bottom).offset(KSIphonScreenH(2));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
            make.height.equalTo(@(KSIphonScreenH(140)));
        }];
    }
}
// 查看大图
-(void)selectBigImageTap{
    [XWScanImage scanBigImageWithImageView:self.answerImageV];
}
//计算高度
+(CGFloat)getLabelHeightWithDict:(OptionListModel *)listModel andQuestType:(showAnswerQuestType)quesType{
    CGFloat height = 0 ;
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger answerfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"AnswerFont"]integerValue] : 15 ;
    if (quesType == showAnswerQuestTextType) {
        // 纯文字
        UILabel *answerLab = [[UILabel alloc]init];
        answerLab.text = listModel.option;
        CGFloat answerHeight = [YWTTools getSpaceLabelHeight:answerLab.text withFont:answerfontSize withWidth:KScreenW-KSIphonScreenW(70) withSpace:6];
        
        height += answerHeight;
    }else if (quesType == showAnswerQuestPhotoType){
        // 纯图片
        height += KSIphonScreenH(35);
        if (![listModel.photo isEqualToString:@""]) {
             height += KSIphonScreenH(140);
        }
    }else if (quesType == showAnswerQuestPhotoAndTextType){
        // 图文混排
        UILabel *answerLab = [[UILabel alloc]init];
        answerLab.text = listModel.option;
        CGFloat answerHeight = [YWTTools getSpaceLabelHeight:answerLab.text withFont:answerfontSize withWidth:KScreenW-KSIphonScreenW(70) withSpace:6];
        
        height += answerHeight+KSIphonScreenH(20);
        
        // 纯图片
        if (![listModel.photo isEqualToString:@""]) {
            height += KSIphonScreenH(140);
        }
    }
    // 添加间距
    CGFloat nowHeight = height + KSIphonScreenH(20)< KSIphonScreenH(50) ? KSIphonScreenH(50) :height + KSIphonScreenH(20) ;
    
    return nowHeight;
}

#pragma mark -----get 方法- ------
//  答题模式
-(void)setQuestMode:(showExamQuestMode)questMode{
    _questMode = questMode;
}
-(void)setQuestionModel:(QuestionListModel *)questionModel{
    _questionModel = questionModel;
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
