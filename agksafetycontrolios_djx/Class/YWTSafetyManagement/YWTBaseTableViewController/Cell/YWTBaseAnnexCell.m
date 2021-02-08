//
//  BaseAnnexCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseAnnexCell.h"

#import "YWTAnnexTypeTableViewCell.h"
#define ANNEXTYPETABLEVIEW_CELL @"AnnexTypeTableViewCell"

#import "YWTAnnexTypeFooterView.h"

@interface YWTBaseAnnexCell ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) UITableView *annexTableView;

@property (nonatomic,strong) UILabel *showAnnexMarkLab;

@property (nonatomic,strong) UILabel *showAnnexLab;

@property (nonatomic,strong)  UIView *cellContentView;



@end

@implementation YWTBaseAnnexCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createBaseCellView];
    }
    return self;
}
-(void) createBaseCellView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.showAnnexLab = [[UILabel alloc]init];
    [bgView addSubview:self.showAnnexLab];
    self.showAnnexLab.text = @"附件";
    self.showAnnexLab.textColor =[UIColor colorCommonBlackColor];
    self.showAnnexLab.font = BFont(15);
    [self.showAnnexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(20));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
    }];
    
    self.showAnnexMarkLab = [[UILabel alloc]init];
    [bgView addSubview:self.showAnnexMarkLab];
    self.showAnnexMarkLab.text = @"(必录: 现场照片、工作票首页、现场安全检查表、到岗到位现场检查表)";
    self.showAnnexMarkLab.textColor =[UIColor colorCommonGreyBlackColor];
    self.showAnnexMarkLab.font = Font(12);
    self.showAnnexMarkLab.numberOfLines = 2;
    [self.showAnnexMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showAnnexLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.showAnnexLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
    }];
    
    self.cellContentView = [[UIView alloc]init];
    [bgView addSubview:self.cellContentView];
    self.cellContentView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showAnnexMarkLab.mas_bottom).offset(KSIphonScreenH(5));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(bgView);
    }];
    self.cellContentView.layer.cornerRadius = 8;
    self.cellContentView.layer.masksToBounds = YES;
    self.cellContentView.layer.borderWidth = 1;
    self.cellContentView.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    
    self.annexTableView = [[UITableView alloc]init];
    [self.cellContentView addSubview:self.annexTableView];
    [self.annexTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.cellContentView);
    }];
    self.annexTableView.delegate = self;
    self.annexTableView.dataSource = self;
    self.annexTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 禁止滑动
    self.annexTableView.scrollEnabled = NO;
    
    [self.annexTableView registerClass:[YWTAnnexTypeTableViewCell class] forCellReuseIdentifier:ANNEXTYPETABLEVIEW_CELL];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.annexArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTAnnexTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ANNEXTYPETABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellType == showAnnexCellAddType) {
        //添加模式
        cell.cellType = showAnnexTableCellAddType;
    }else{
        cell.cellType = showAnnexTableCellAlterType;
    }
    cell.dict = self.annexArr[indexPath.row];
    // 删除
    __weak typeof(self) weakSelf = self;
    cell.selectDelBtn = ^{
        weakSelf.selectDelBtn(indexPath.row);
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(40);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return KSIphonScreenH(80);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    YWTAnnexTypeFooterView *footerView = [[YWTAnnexTypeFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 88)];
    __weak typeof(self) weakSelf = self;
    // 添加附件
    footerView.addAnnex = ^{
        weakSelf.baseAddAnnex();
    };
    return footerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.annexArr[indexPath.row];
    self.selectVodplay(dict);
}

-(void)setAnnexArr:(NSMutableArray *)annexArr{
    _annexArr = annexArr;
    [self.annexTableView reloadData];
}
-(void)setInfoRemorkStr:(NSString *)infoRemorkStr{
    _infoRemorkStr = infoRemorkStr;
    if (![infoRemorkStr isEqualToString:@""]) {
        self.showAnnexMarkLab.text = [NSString stringWithFormat:@"(%@)",infoRemorkStr];
    }else{
        self.showAnnexMarkLab.text = @"";
    }
}
- (void)setAnnexCellType:(showBaseAnnexCellType)annexCellType{
    _annexCellType = annexCellType;
    __weak typeof(self) weakSelf = self;
    if (annexCellType == showBaseAnnexCellViolationType) {
        [self.cellContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.showAnnexLab.mas_bottom).offset(KSIphonScreenH(10));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
            make.bottom.equalTo(weakSelf);
        }];
        self.showAnnexMarkLab.hidden = YES;
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
