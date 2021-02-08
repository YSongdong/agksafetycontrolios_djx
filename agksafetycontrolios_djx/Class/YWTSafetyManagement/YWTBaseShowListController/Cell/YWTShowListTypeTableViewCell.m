//
//  ShowListTypeTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowListTypeTableViewCell.h"

#import "YWTListTypeCellHeaderView.h"

#import "YWTListTypeCellTableViewCell.h"
#define LISTTYPECELLTABLEVIEW_CELL @"ListTypeCellTableViewCell"

@interface YWTShowListTypeTableViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic,strong) UITableView *cellTableView;
// 数据源
@property (nonatomic,strong) NSMutableArray *cellDataArr;
//
@property (nonatomic,strong) UIButton *showMoreBtn;

@end

@implementation YWTShowListTypeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellTableView];
    }
    return self;
}
-(void) createCellTableView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(8);
    bgView.layer.masksToBounds = YES;
//    bgView.layer.borderWidth = 1;
//    bgView.layer.borderColor =  [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    self.showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.showMoreBtn];
    [self.showMoreBtn setImage:[UIImage imageNamed:@"base_show_arrowdown"] forState: UIControlStateNormal];
    [self.showMoreBtn setImage:[UIImage imageNamed:@"base_show_arrowup"] forState:UIControlStateSelected];
    [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView);
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    [self.showMoreBtn addTarget:self action:@selector(selectMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.showMoreBtn.hidden = YES;
    
    self.cellTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [bgView addSubview:self.cellTableView];
    self.cellTableView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.cellTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.bottom.equalTo(bgView).offset(-KSIphonScreenH(22));
    }];
    self.cellTableView.delegate = self;
    self.cellTableView.dataSource = self;
    //禁止滑动
    self.cellTableView.scrollEnabled = NO;
    self.cellTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.cellTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.cellTableView registerClass:[YWTListTypeCellTableViewCell class] forCellReuseIdentifier:LISTTYPECELLTABLEVIEW_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.cellTableView.estimatedRowHeight = 0;
        self.cellTableView.estimatedSectionFooterHeight = 0;
        self.cellTableView.estimatedSectionHeaderHeight = 0 ;
        self.cellTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellDataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BaseShowListModel *model = self.cellDataArr[section];
    NSArray *arr = model.enclosure;
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTListTypeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LISTTYPECELLTABLEVIEW_CELL forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaseShowListModel *model = self.cellDataArr[indexPath.section];
    NSArray *arr = model.enclosure;
    cell.dict = arr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(70);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    BaseShowListModel *model = self.cellDataArr[section];
    return [YWTListTypeCellHeaderView getTypeCellHeader:model];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YWTListTypeCellHeaderView *headerView = [[YWTListTypeCellHeaderView alloc]initWithFrame:CGRectZero];
    headerView.model = self.model;
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseShowListModel *model = self.cellDataArr[indexPath.section];
    NSArray *arr = model.enclosure;
    NSDictionary *dict = arr[indexPath.row];
    self.selectAnnex(dict);
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
// 点击
-(void)selectMoreBtn:(UIButton *) sender{
    NSArray *btnArr = self.model.enclosure;
    if (btnArr.count == 0) {
        // 没有展开
        return ;
    }
    CGFloat height = 0;
    // 计算header高度
    CGFloat headerHeight = [YWTListTypeCellHeaderView getTypeCellHeader:self.model];
    height += headerHeight;
    // 计算cell 的高度
    NSArray *arr = self.model.enclosure;
    CGFloat cellHeight = arr.count *KSIphonScreenH(71);
    height += cellHeight;
    height += KSIphonScreenH(20);
    sender.selected = !sender.selected;
    // 赋值
    self.model.cellHeight = height;
    if (sender.selected) {
        //
        self.model.isExqand = YES;
    }else{
         self.model.isExqand = NO;
    }
    self.selectMoreBtn(self.model);
}
-(void)setModel:(BaseShowListModel *)model{
    _model = model;
    [self.cellDataArr removeAllObjects];
    [self.cellDataArr addObject:model];
    [self.cellTableView reloadData];
    if (model.isExqand) {
        self.showMoreBtn.selected = YES;
    }else{
        self.showMoreBtn.selected = NO;
    }
    //判断是否要显示更多按钮
    if (model.enclosure.count > 1) {
        self.showMoreBtn.hidden = NO;
    }else{
        self.showMoreBtn.hidden = YES;
    }
}
-(NSMutableArray *)cellDataArr{
    if (!_cellDataArr) {
        _cellDataArr = [NSMutableArray array];
    }
    return _cellDataArr;
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
