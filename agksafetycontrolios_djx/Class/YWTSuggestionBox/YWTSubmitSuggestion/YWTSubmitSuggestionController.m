//
//  YWTSubmitSuggestionController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/12.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSubmitSuggestionController.h"

#import "YWTSelectUnitController.h"
#import "YWTBoxRecordController.h"
#import "YWTSuggestionBoxDetail.h"

#import "YWTSelectBaseCell.h"
#import "YWTSubimtOpinionCell.h"
#import "YWTSubmitSendMethodCell.h"
#import "YWTSubmitBtnCell.h"
#import "YWTSubmitTopGrayCell.h"
#import "HQPickerView.h"


@interface YWTSubmitSuggestionController ()
<
UITableViewDelegate,
UITableViewDataSource,
HQPickerViewDelegate,
YWTSubmitBtnCellDelegate,
YWTSelectUnitControllerDelegate
>
// 顶部灰色
@property (nonatomic,strong) YWTSubmitTopGrayCell *submitTopGrayCell;
// 选择类型
@property (nonatomic,strong) YWTSelectBaseCell *selectTypeCell;
// 接受类型
@property (nonatomic,strong) YWTSelectBaseCell *AcceeptanceTypeCell;
// 意见内容
@property (nonatomic,strong) YWTSubimtOpinionCell *opinionCell;
// 发送类型
@property (nonatomic,strong) YWTSubmitSendMethodCell *sendMethodCell;
//提交按钮
@property (nonatomic,strong) YWTSubmitBtnCell *submitBtnCell;

@property (nonatomic,strong) UITableView   *submitTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) HQPickerView *hpPickerView;
@property (nonatomic,strong) NSString *targetIdStr;
@end

@implementation YWTSubmitSuggestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.targetIdStr = @"";
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    // 设置导航栏
    [self setNavi];
    //加载数据源
    [self loadData];
    //
    [self.view addSubview:self.submitTableView];
}
#pragma mark --- UITableViewDataSource--------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArr[indexPath.row];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return KSIphonScreenH(10);
    }else if (indexPath.row == 3) {
        return KSIphonScreenH(150);
    }else if (indexPath.row == 5){
        return KSIphonScreenH(130);
    }else{
        return KSIphonScreenH(45);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        // 收起键盘
        [self.opinionCell.fsTextView resignFirstResponder];
        // 选择器
        [self createHPPickView];
    }else if (indexPath.row == 2){
        // 收起键盘
        [self.opinionCell.fsTextView resignFirstResponder];
        
        NSString *targetStr = self.selectTypeCell.baseLab.text ;
        if ([targetStr isEqualToString:@""]) {
            [self.view showErrorWithTitle:@"请选择向单位或者个人意见!" autoCloseTime:0.5];
            // 取消选中状态
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            return;
        }
        
        YWTSelectUnitController *unitVC = [[YWTSelectUnitController alloc]init];
        if (self.AcceeptanceTypeCell.cellType == SelectBaseCellSelectType ) {
            unitVC.selectType =  SelectPersonType ;
        }else{
            unitVC.selectType =  SelectUnitType ;
        }
        unitVC.delegate = self;
        [self.navigationController pushViewController:unitVC animated:YES];
    }else if (indexPath.row == 4){
        // 匿名
        self.sendMethodCell.sendMethodBtn.selected = !self.sendMethodCell.sendMethodBtn.selected;
    }
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark --- HQPickerViewDelegate --------
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text{
    self.selectTypeCell.placeholderLab.hidden = YES;
    self.selectTypeCell.baseLab.text = text;
    self.targetIdStr = @"";
    self.AcceeptanceTypeCell.baseLab.text = @"";
    self.AcceeptanceTypeCell.placeholderLab.hidden = NO;
    if ([text isEqualToString:@"向单位提意见"]) {
        self.AcceeptanceTypeCell.cellType = SelectBaseCellAcceeptanceType;
        self.AcceeptanceTypeCell.placeholderLab.text = @"请选择意见接受单位";
    }else{
        self.AcceeptanceTypeCell.cellType = SelectBaseCellSelectType;
        self.AcceeptanceTypeCell.placeholderLab.text = @"请选择意见接受人员";
    }
}
#pragma mark ----  YWTSelectUnitControllerDelegate ----
//选中的Id
-(void) selectSelectUnitTargetIdStr:(NSString*)targetId targetName:(NSString *)targeName{
    self.targetIdStr =  targetId;
    self.AcceeptanceTypeCell.baseLab.text = targeName;
    self.AcceeptanceTypeCell.placeholderLab.hidden = YES;
}
#pragma mark --- 加载数据源--------
-(void) loadData{
    [self.dataArr addObject:self.submitTopGrayCell];
    [self.dataArr addObject:self.selectTypeCell];
    [self.dataArr addObject:self.AcceeptanceTypeCell];
    [self.dataArr addObject:self.opinionCell];
    [self.dataArr addObject:self.sendMethodCell];
    [self.dataArr addObject:self.submitBtnCell];
}
#pragma mark --- 自定义选择器 --------
-(void)createHPPickView{
    _hpPickerView = [[HQPickerView alloc]initWithFrame:self.view.bounds];
    _hpPickerView.delegate = self ;
    _hpPickerView.customArr = @[@"向单位提意见",@"向个人提意见"];
    _hpPickerView.timeLab.text = @"";
    [self.view addSubview:_hpPickerView];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"意见箱";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"意见记录" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    [self.customNavBar setOnClickRightButton:^{
        YWTBoxRecordController *recordVC = [[YWTBoxRecordController alloc]init];
        [weakSelf.navigationController pushViewController:recordVC animated:YES];
        [weakSelf pushSuccesClearData];
    }];
}

#pragma mark --- 清除数据 --------
-(void) pushSuccesClearData{
    WS(weakSelf);
    weakSelf.targetIdStr = @"";
    weakSelf.selectTypeCell.baseLab.text = @"";
    weakSelf.selectTypeCell.placeholderLab.hidden = NO;
    weakSelf.selectTypeCell.placeholderLab.text = @"向单位提意见";
    weakSelf.AcceeptanceTypeCell.baseLab.text = @"";
    weakSelf.AcceeptanceTypeCell.placeholderLab.hidden = NO;
    weakSelf.AcceeptanceTypeCell.placeholderLab.text = @"请选择意见接受单位";
    weakSelf.opinionCell.fsTextView.text = @"";
    weakSelf.sendMethodCell.sendMethodBtn.selected = NO;
}
#pragma mark ---  YWTSubmitBtnCellDelegate ----
// 提交
-(void) selectSubmitCellBtn{
    NSString *targetStr = self.selectTypeCell.baseLab.text ;
    if ([targetStr isEqualToString:@""]) {
        [self.view showErrorWithTitle:@"请选择向单位或者个人意见!" autoCloseTime:0.5];
        return;
    }
    if ([self.targetIdStr isEqualToString:@""]) {
        [self.view showErrorWithTitle:@"请选择接收意见的单位或者个人!" autoCloseTime:0.5];
        return;
    }
    if (self.opinionCell.fsTextView.text.length == 0) {
        [self.view showErrorWithTitle:@"请输入意见内容" autoCloseTime:0.5];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    // 1实名 2匿名
    NSString *types = self.sendMethodCell.sendMethodBtn.selected == YES ? @"2" : @"1";
    param[@"types"] = types;
    // 1是给个人2是给单位
    NSString *target = self.AcceeptanceTypeCell.cellType == SelectBaseCellSelectType ? @"1" : @"2" ;
    param[@"target"] = target;
    // 目标id【target 1传个人id 2传单位id】
    param[@"targetid"] = self.targetIdStr;
    // 提交的意见
    param[@"content"] = self.opinionCell.fsTextView.text;
    // 任务id
    param[@"taskid"]= self.taskIdStr;
    [self requestOpinionSubmit:param.copy];
}
#pragma mark --- get --------
-(UITableView *)submitTableView{
    if (!_submitTableView) {
        _submitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSTabbarH-KSNaviTopHeight)];
        _submitTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _submitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _submitTableView.delegate = self;
        _submitTableView.dataSource = self;
        _submitTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _submitTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _submitTableView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(YWTSubmitTopGrayCell *)submitTopGrayCell{
    if (!_submitTopGrayCell) {
        _submitTopGrayCell = [[YWTSubmitTopGrayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TOPGRAYTYPE"];
        _submitTopGrayCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _submitTopGrayCell;
}
-(YWTSelectBaseCell *)selectTypeCell{
    if (_selectTypeCell == nil) {
        _selectTypeCell = [[YWTSelectBaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SELECTTYPE"];
        _selectTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _selectTypeCell;
}
-(YWTSelectBaseCell *)AcceeptanceTypeCell{
    if (_AcceeptanceTypeCell == nil) {
        _AcceeptanceTypeCell = [[YWTSelectBaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ACCEEPTANCETPYE"];
        _AcceeptanceTypeCell.cellType = SelectBaseCellAcceeptanceType;
    }
    return _AcceeptanceTypeCell;
}
-(YWTSubimtOpinionCell *)opinionCell{
    if (_opinionCell == nil) {
        _opinionCell = [[YWTSubimtOpinionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OPINIONTPYE"];
        _opinionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _opinionCell;
}
-(YWTSubmitSendMethodCell *)sendMethodCell{
    if (_sendMethodCell == nil) {
        _sendMethodCell = [[YWTSubmitSendMethodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SENDMETHODTPYE"];
        _sendMethodCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _sendMethodCell;
}
-(YWTSubmitBtnCell *)submitBtnCell{
    if (_submitBtnCell == nil) {
        _submitBtnCell = [[YWTSubmitBtnCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SUBIMTBTNTPYE"];
        _submitBtnCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _submitBtnCell.delegate = self;
    }
    return _submitBtnCell;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma  mark ----  数据相关 -------
-(void) requestOpinionSubmit:(NSDictionary *)param{
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSUGGESTIONBOXOPINIONSUBMISSION_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            NSString *idStr = [NSString stringWithFormat:@"%@",showdata[@"id"]];
            YWTSuggestionBoxDetail *detailVC = [[YWTSuggestionBoxDetail alloc]init];
            detailVC.suggestionBoxId = idStr;
            [self.navigationController pushViewController:detailVC animated:YES];
            [self pushSuccesClearData];
        }
    }];
}

@end
