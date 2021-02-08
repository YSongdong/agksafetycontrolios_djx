//
//  MineViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTMineViewController.h"

#import "SDUserInfoTableViewCell.h"
#define SDUSERINFOTABLEVIEW_CELL @"SDUserInfoTableViewCell"

#import "YWTAlterLoginPwdVController.h"
#import "YWTBindIphoneViewController.h"
#import "YWTAlterBindIphoneController.h"
#import "YWTPhotoCollectionController.h"

@interface YWTMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mineTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 消息背景view
@property (nonatomic,strong) UIView *msgBgView;
// 消息内容lab
@property (nonatomic,strong) UILabel *unreadMsgLab;
@end

@implementation YWTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavi];
    // 加载数据源
    [self loadData];
    //创建TableView
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 请求个人资料
   [self requestPersonalInfoData];
    // 获取未读信息
   [self requestMsgMailMsgStatistics];
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.mineTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.mineTableView];
    
    self.mineTableView.delegate = self;
    self.mineTableView.dataSource = self;
    self.mineTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    [self.mineTableView registerNib:[UINib nibWithNibName:SDUSERINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDUSERINFOTABLEVIEW_CELL];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDUSERINFOTABLEVIEW_CELL forIndexPath:indexPath];
    NSArray *arr = self.dataArr[indexPath.section];
    cell.indexPath =  indexPath;
    cell.dict = arr[indexPath.row];
    if (indexPath.section != 0) {
        if (indexPath.row < 5) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return KSIphonScreenH(70);
    }else{
        return KSIphonScreenH(60);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else {
        return 11;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        // 点击头像
        NSArray *arr = self.dataArr[indexPath.section];
        NSDictionary *dict = arr[indexPath.row];
        NSString *vMobileStr = [NSString stringWithFormat:@"%@",dict[@"photoStatus"]];
        YWTPhotoCollectionController *photoVC = [[YWTPhotoCollectionController alloc]init];
        if ([vMobileStr isEqualToString:@"2"]) {
            //2未认证
            photoVC.photoStatu = photoStatuNotUploaded;
        }else if ([vMobileStr isEqualToString:@"1"]){
            //1认证
            photoVC.photoStatu = photoStatuCheckSucces;
        }else if ([vMobileStr isEqualToString:@"3"]){
            //认证不通过
            photoVC.photoStatu = photoStatuCheckError;
        }else if ([vMobileStr isEqualToString:@"4"]){
            //4审核中
            photoVC.photoStatu = photoStatuChecking;
        }
        [self.navigationController pushViewController:photoVC animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 5) {
            // 点击手机号cell
            NSArray *arr = self.dataArr[indexPath.section];
            NSDictionary *dict = arr[indexPath.row];
            NSString *vMobileStr = [NSString stringWithFormat:@"%@",dict[@"photoStatus"]];
            if ([vMobileStr isEqualToString:@"1"]){
                // 1是认证
                YWTAlterBindIphoneController *alterPhoneVC = [[YWTAlterBindIphoneController alloc]init];
                alterPhoneVC.bindStatu = showAlterBindNormalStatu;
                [self.navigationController pushViewController:alterPhoneVC animated:YES];
            }else{
                //   2是未认证
                YWTBindIphoneViewController *bindPhoneVC = [[YWTBindIphoneViewController alloc]init];
                bindPhoneVC.viewStatu = showViewNormalStatu;
                [self.navigationController pushViewController:bindPhoneVC animated:YES];
            }
        }else if (indexPath.row == 6){
            // 登录密码
            YWTAlterLoginPwdVController *pwdVC = [[YWTAlterLoginPwdVController alloc]init];
            pwdVC.pwdViewStatu = showPwdViewNormalStatu;
            [self.navigationController pushViewController:pwdVC animated:YES];
        }
    }
}

#pragma mark --- 加载数据数据源 --------
-(void) loadData{
    //移除数据源
    [self.dataArr removeAllObjects];
    
    NSString *isVMobileStr = [YWTUserInfo obtainWithVMobile];
    //判断手机绑定状态
    NSString *phoneStr=[isVMobileStr isEqualToString:@"2"] ? @"未绑定":[YWTUserInfo obtainWithMobile];
    //头像
    NSArray *headerArr = @[@{@"name":@"用户头像",@"desc":[YWTUserInfo obtainWithPhoto],@"photoStatus":[YWTUserInfo obtainWithVFace]}];
    NSArray *infoArr = @[@{@"name":@"真实姓名",@"desc":[YWTUserInfo obtainWithRealName],@"photoStatus":@""},
                         @{@"name":@"用户编号",@"desc":[YWTUserInfo obtainWithSN],@"photoStatus":@""},
                         @{@"name":@"单位名称",@"desc":[YWTUserInfo obtainWithCompany],@"photoStatus":@""},
                         @{@"name":@"职位/工种",@"desc":@"",@"photoStatus":@""},
                         @{@"name":@"身份证号",@"desc":@"",@"photoStatus":@""},
                         @{@"name":@"手机号码",@"desc":phoneStr,@"photoStatus":@""},
                         @{@"name":@"修改登录密码",@"desc":@"",@"photoStatus":@""}];
    [self.dataArr addObject:headerArr];
    [self.dataArr addObject:infoArr];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"个人资料";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    // 消息
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"sy_nav_ico02"]];
    self.customNavBar.onClickRightButton = ^{
        YWTMessageCenterController *msgVC = [[YWTMessageCenterController alloc]init];
        [weakSelf.navigationController pushViewController:msgVC animated:YES];
    };
    self.msgBgView = [[UIView alloc]init];
    [self.customNavBar addSubview:self.msgBgView];
    self.msgBgView.backgroundColor = [UIColor colorCommonRedColor];
    self.msgBgView.userInteractionEnabled =NO;
    [self.msgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.customNavBar.rightButton.mas_centerX).offset(8);
        make.centerY.equalTo(weakSelf.customNavBar.rightButton.mas_centerY).offset(-5);
        make.width.height.equalTo(@16);
    }];
    self.msgBgView.layer.cornerRadius = 8;
    self.msgBgView.layer.masksToBounds = YES;
    self.msgBgView.hidden = YES;
    // 未读消息lab
    self.unreadMsgLab = [[UILabel alloc]init];
    [self.msgBgView addSubview:self.unreadMsgLab];
    self.unreadMsgLab.text = @"10";
    self.unreadMsgLab.textColor = [UIColor colorTextWhiteColor];
    self.unreadMsgLab.font = Font(10);
    [self.unreadMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.msgBgView.mas_centerX);
        make.centerY.equalTo(weakSelf.msgBgView.mas_centerY);
    }];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark ----个人资料-----
-(void) requestPersonalInfoData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] =[YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPPERSONALCENTER_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 头像数组源
            NSMutableArray  *headerArr =[NSMutableArray arrayWithArray:self.dataArr[0]];
            NSMutableDictionary *headerDict = [NSMutableDictionary dictionaryWithDictionary:headerArr[0]];
            headerDict[@"desc"] = showdata[@"photo"];
            headerDict[@"photoStatus"] = [NSString stringWithFormat:@"%@",showdata[@"vFace"]];
            // 替换数据源
            [headerArr replaceObjectAtIndex:0 withObject:headerDict];
            [self.dataArr replaceObjectAtIndex:0 withObject:headerArr];
            
            // 用户信息数组源
             NSMutableArray *infoArr =[NSMutableArray arrayWithArray:self.dataArr[1]];
            // 真实姓名
            NSMutableDictionary *nameDict = [NSMutableDictionary dictionaryWithDictionary:infoArr[0]];
            nameDict[@"desc"] = showdata[@"realName"];
            nameDict[@"photoStatus"] =[NSString stringWithFormat:@"%@",showdata[@"sex"]];
            [infoArr replaceObjectAtIndex:0 withObject:nameDict];
            //用户编号
            NSMutableDictionary *snDict = [NSMutableDictionary dictionaryWithDictionary:infoArr[1]];
            snDict[@"desc"] = showdata[@"sn"];
            [infoArr replaceObjectAtIndex:1 withObject:snDict];
            //单位名称
            NSMutableDictionary *companyDict = [NSMutableDictionary dictionaryWithDictionary:infoArr[2]];
            companyDict[@"desc"] = showdata[@"company"];
            [infoArr replaceObjectAtIndex:2 withObject:companyDict];
            //职位
            NSMutableDictionary *positionNameDict = [NSMutableDictionary dictionaryWithDictionary:infoArr[3]];
            NSString *positionNameStr = [NSString stringWithFormat:@"%@",showdata[@"positionName"]];
            NSString *positionName;
            if ([positionNameStr isEqualToString:@"0"] || positionNameStr == nil || [positionNameStr isKindOfClass:[NSNull class]] || [positionNameStr isEqualToString:@""]) {
                positionName = @"无";
            }else{
                positionName = showdata[@"positionName"];
            }
            positionNameDict[@"desc"] = positionName;
            [infoArr replaceObjectAtIndex:3 withObject:positionNameDict];
            
            //身份证
            NSMutableDictionary *idCardDict = [NSMutableDictionary dictionaryWithDictionary:infoArr[4]];
            NSString *idCardStr =  [NSString stringWithFormat:@"%@",showdata[@"idCard"]];
            NSString *idCard;
            if ([idCardStr isEqualToString:@""] || idCardStr == nil || [positionNameStr isKindOfClass:[NSNull class]]) {
                idCard = @"未完善";
            }else{
                 idCard = showdata[@"idCard"];
            }
            idCardDict[@"desc"] = idCard;
            [infoArr replaceObjectAtIndex:4 withObject:idCardDict];
            //电话
            NSMutableDictionary *mobileDict = [NSMutableDictionary dictionaryWithDictionary:infoArr[5]];
            //判断手机绑定状态
            NSString *vMobileStr = [NSString stringWithFormat:@"%@",showdata[@"vMobile"]];
            NSString *phoneStr=[vMobileStr isEqualToString:@"2"] ? @"未绑定":showdata[@"mobile"];
            mobileDict[@"desc"] =phoneStr;
            mobileDict[@"photoStatus"] =[NSString stringWithFormat:@"%@",showdata[@"vMobile"]];
            [infoArr replaceObjectAtIndex:5 withObject:mobileDict];
            
            // 贴换数据源
            [self.dataArr replaceObjectAtIndex:1 withObject:infoArr];
    
            // 刷新UI
            [self.mineTableView reloadData];
            
            // 修改用户信息
            [YWTUserInfo alterUserInfoDictionary:showdata];
        }
    }];
}

// 获取未读消息当前数量
-(void) requestMsgMailMsgStatistics{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPMSGMAILMSGSTATISTICS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            NSNumber *num = showdata[@"num"];
            NSInteger number = [num integerValue];
            if (number > 0) {
                self.msgBgView.hidden = NO;
                self.unreadMsgLab.text = [NSString stringWithFormat:@"%ld",(long)number];
            }else{
                self.msgBgView.hidden = YES;
            }
        }
    }];
}



@end
