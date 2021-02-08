//
//  PhotoCollectionController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTPhotoCollectionController.h"

#import "YWTHeaderPhotoTableViewCell.h"
#define  HEADERPHOTOTABLEVIEW_CELL @"YWTHeaderPhotoTableViewCell"
#import "YWTBeginCollectionTableViewCell.h"
#define BEGINCOLLECTIONTABLEIVEW_CELL @"YWTBeginCollectionTableViewCell"
#import "PhotoMarkTableViewCell.h"
#define PHOTOMARKTABLEVIEW_CELL @"PhotoMarkTableViewCell"
#import "YWTUpdatePhotoTableViewCell.h"
#define UPDATEPHOTOTABLEVIEW_CELL @"YWTUpdatePhotoTableViewCell"


#import "YWTBindIphoneViewController.h"
#import "YWTAlterLoginPwdVController.h"

@interface YWTPhotoCollectionController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *photoTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation YWTPhotoCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 加载数据源
    [self loadData];
    // 创建TableView
    [self createTableView];
}
-(void) loadData{
    // 照片信息
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    userDict[@"checkStatu"] = [NSString stringWithFormat:@"%u",self.photoStatu];
    userDict[@"checkError"] = @"";
    if ([[YWTUserInfo obtainWithPhoto] isEqualToString:@""]) {
        userDict[@"checkPhoto"] = @"";
    }else{
        userDict[@"checkPhoto"] = [YWTUserInfo obtainWithPhoto];
    }
    [self.dataArr addObject:userDict];
    // 文字信息
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[@"text"] = @"";
    [self.dataArr addObject:textDict];
    
    [self.dataArr addObject:@""];
    
    [self.dataArr addObject:@""];
}
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
    self.photoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    [self.view insertSubview:self.photoTableView atIndex:0];
    
    self.photoTableView.dataSource= self;
    self.photoTableView.delegate = self;
    self.photoTableView.rowHeight = UITableViewAutomaticDimension;
    self.photoTableView.estimatedRowHeight = KSIphonScreenH(110);
    self.photoTableView.tableFooterView  = [[UIView alloc]initWithFrame:CGRectZero];
    self.photoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.photoTableView.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
    
    if (@available(iOS 11.0, *)) {
        self.photoTableView.estimatedRowHeight = 0;
        self.photoTableView.estimatedSectionFooterHeight = 0;
        self.photoTableView.estimatedSectionHeaderHeight = 0 ;
        self.photoTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.photoTableView registerClass:[YWTHeaderPhotoTableViewCell class] forCellReuseIdentifier:HEADERPHOTOTABLEVIEW_CELL];
    [self.photoTableView registerClass:[YWTBeginCollectionTableViewCell class] forCellReuseIdentifier:BEGINCOLLECTIONTABLEIVEW_CELL];
    [self.photoTableView registerClass:[YWTUpdatePhotoTableViewCell class] forCellReuseIdentifier:UPDATEPHOTOTABLEVIEW_CELL];
    [self.photoTableView registerNib:[UINib nibWithNibName:PHOTOMARKTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:PHOTOMARKTABLEVIEW_CELL];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        YWTHeaderPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HEADERPHOTOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.photoStatu == photoStatuNotUploaded) {
            cell.cellPhotoStatu = cellPhotoStatuNotUploaded;
        }else if (self.photoStatu == photoStatuCollectionPhoto){
            cell.cellPhotoStatu = cellPhotoStatuCollectionPhoto;
        }else if (self.photoStatu == photoStatuChecking){
            cell.cellPhotoStatu = cellPhotoStatuChecking;
        }else if (self.photoStatu == photoStatuCheckError){
            cell.cellPhotoStatu = cellPhotoStatuCheckError;
        }else if (self.photoStatu == photoStatuCheckSucces){
            cell.cellPhotoStatu = cellPhotoStatuCheckSucces;
        }else if (self.photoStatu == photoStatuFristHome){
            cell.cellPhotoStatu = cellPhotoStatuChecking;
        }
        cell.dict = self.dataArr[indexPath.row];
        return cell;
    }else if(indexPath.row == 1){
        PhotoMarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PHOTOMARKTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        YWTUpdatePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UPDATEPHOTOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.photoStatu == photoStatuNotUploaded) {
            cell.showUpdateBtnStatu = cellUpdateBtnNotUploaded;
        }else if (self.photoStatu == photoStatuCollectionPhoto){
            cell.showUpdateBtnStatu = cellUpdateBtnCollectionPhoto;
        }else if (self.photoStatu == photoStatuChecking){
            cell.showUpdateBtnStatu = cellUpdateBtnChecking;
        }else if (self.photoStatu == photoStatuCheckError){
            cell.showUpdateBtnStatu = cellUpdateBtnCheckError;
        }else if (self.photoStatu == photoStatuCheckSucces){
            cell.showUpdateBtnStatu =cellUpdateBtnCheckSucces;
        }else if (self.photoStatu == photoStatuFristHome){
            cell.showUpdateBtnStatu = cellUpdateBtnFristHome;
        }
        cell.selectActionBlock = ^{
            if (weakSelf.photoStatu == photoStatuNotUploaded || weakSelf.photoStatu == photoStatuCheckError) {
                // 调采集取人脸
                [weakSelf getRetrievalFaceConllection];
            }else if (weakSelf.photoStatu == photoStatuFristHome){
                  // 首次引导
                [weakSelf pushViewController];
            }else if (weakSelf.photoStatu == photoStatuCollectionPhoto){
                // 采集照片中  立即上传
                [weakSelf requestUploadFace];
            }
        };
        return cell;
    }else{
        YWTBeginCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BEGINCOLLECTIONTABLEIVEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.photoStatu == photoStatuCollectionPhoto) {
            cell.showBtnStatu = cellPhotoCollectionPhoto;
        }else{
            cell.showBtnStatu = cellPhotoCollectionSucces;
        }
        cell.selectCollectionBlock = ^{
            // 调采集取人脸
            [weakSelf getRetrievalFaceConllection];
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
       return KSNaviTopHeight+KSIphonScreenH(320);
    }else if(indexPath.row == 1){
        return KSIphonScreenH(140);
    }else if(indexPath.row == 2){
        return KSIphonScreenH(107);
    }else{
        return KSIphonScreenH(60);
    }
}
#pragma mark -----调取人脸采集--------
-(void)getRetrievalFaceConllection{
    __weak typeof(self) weakSelf = self;
    if ([[FaceSDKManager sharedInstance] canWork]) {
        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    }
    DetectionViewController* dvc = [[DetectionViewController alloc] init];
    dvc.outStatu = showCodeTimeOutStartStatu;
    SDRootNavigationController *navi = [[SDRootNavigationController alloc] initWithRootViewController:dvc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    dvc.fackBlcok = ^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //添加
            NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionaryWithDictionary:weakSelf.dataArr[0]];
            userInfoDict[@"checkPhoto"] = image;
            [weakSelf.dataArr replaceObjectAtIndex:0 withObject:userInfoDict];
            //改变状态
            weakSelf.photoStatu = photoStatuCollectionPhoto;
            // 刷新UI
            [weakSelf.photoTableView reloadData];
        });
    };
    //点击关闭视图
    dvc.closeViewControllBlock = ^{
       
    };
    // 如果超时
    dvc.CodeTimeoutBlock = ^{
        
    };
    [self presentViewController:navi animated:YES completion:nil];
}
// 跳转到那个页面
-(void)pushViewController{
    __weak typeof(self) weakSelf = self;
    // 判断是否绑定手机
    NSString *vMobileStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithVMobile]];
    if ([vMobileStr isEqualToString:@"2"]) {
        YWTBindIphoneViewController *bindVC = [[YWTBindIphoneViewController alloc]init];
        bindVC.viewStatu = showViewFristHomeStatu;
        [weakSelf.navigationController pushViewController:bindVC animated:YES];
        return ;
    }
    //修改登录密码
    YWTAlterLoginPwdVController *alterPwdVC = [[YWTAlterLoginPwdVController alloc]init];
    alterPwdVC.pwdViewStatu = showViewFristHomeStatu;
    [weakSelf.navigationController pushViewController:alterPwdVC animated:YES];

}
#pragma mark -----系统回调--------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.isFristHome) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isFristHome) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"用户留底照片";
    
    if (!self.isFristHome) {
        __weak typeof(self) weakSelf = self;
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
        self.customNavBar.onClickLeftButton = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
}
#pragma mark --- set 方法--------
-(void)setIsFristHome:(BOOL)isFristHome{
    _isFristHome = isFristHome;
}
-(void)setPhotoStatu:(collectionPhotoStatu)photoStatu{
    _photoStatu = photoStatu;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark ---- 上传人脸照片-----
-(void)requestUploadFace{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    NSMutableArray *faceArr = [NSMutableArray array];
    NSDictionary *faceDict = self.dataArr[0];
    
    UIImage *faceImage = (UIImage *)faceDict[@"checkPhoto"];
    [faceArr addObject:faceImage];
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:HTTP_ATTAPPFACEUPLOAD_URL params:param andData:faceArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (self.isFristHome) {
            //改变状态
            self.photoStatu = photoStatuFristHome;
        }else{
            //改变状态
            self.photoStatu = photoStatuChecking;
        }
        // 刷新UI
        [self.photoTableView reloadData];
    }];

}




@end
