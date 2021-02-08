//
//  AttendanceChenkController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/13.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceChenkController.h"

#import "YWTBaseRecordController.h"
#import "YWTShowLocatPromentView.h"
#import "YWTInfoAttandanceCheckView.h"

@interface YWTAttendanceChenkController ()
<
BMKMapViewDelegate,
BMKLocationManagerDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>{
    NSTimer *_timer;
}
@property (nonatomic,strong) CLLocationManager *locationManagerSystem;
// 确认签到框
@property (nonatomic,strong) YWTInfoAttandanceCheckView *checkView;
//提示权限view
@property (nonatomic,strong) YWTShowLocatPromentView *showLocatView;
// 百度地图
@property (nonatomic, strong) BMKMapView *mapView;
// 百度定位
@property (nonatomic,strong) BMKLocationManager *locationManager;
// 人脸规则字典
@property (nonatomic,strong) NSMutableDictionary *montiorDict;
// 大头针
@property (nonatomic,strong) BMKPointAnnotation* annotation;
// 定位位置
@property (nonatomic,strong) UILabel *locationAddressLab;
// 考勤签到按钮
@property (nonatomic,strong) UIButton *attendanceChenkBtn;
// 重新定位
@property (nonatomic,strong) UIButton *againLocatBtn;
// 记录用户的位置信息
@property (nonatomic,strong) CLLocation *userLocation;
// 记录服务器端拉下来的时间
@property (nonatomic,assign) NSInteger timerInterval;
// 记录人脸状态
@property (nonatomic,strong) NSString *faceIsStr;
// 记录签到备注
@property (nonatomic,strong) NSString *noteMarkStr;
// 记录备注图片数组
@property (nonatomic,strong) NSMutableArray *markImageArr;
//  人脸识别的返回图片
@property (nonatomic,strong) NSString *faceVierBackPhoto;
// 人脸识别照片
@property (nonatomic,strong) UIImage *faceImage;
// 判断是不是人脸识别弹框
@property (nonatomic,assign) BOOL isFaceError;
// 判断是否开启人脸识别
@property (nonatomic,assign) BOOL isFaceMontior;

@end

@implementation YWTAttendanceChenkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认 时间
    self.timerInterval = 0;
    self.faceIsStr = @"2";
    self.noteMarkStr = @"";
    self.faceVierBackPhoto = @"";
    self.isFaceError = NO;
    self.isFaceMontior = NO;
    // 设置导航栏
    [self setNavi];
    // 创建工具view
    [self createBMKMapView];
    // 创建定位
    [self createLocationManager];
    // 请求人脸规则
    [self requestAttendanceData];
    
    // 定位权限弹窗不显示，原因是苹果要求调用请求。
    if (![self getUserLocationAuth]) {
        _locationManagerSystem = [[CLLocationManager alloc]init];
        [_locationManagerSystem requestWhenInUseAuthorization];
    }
    
    //app从后台推到前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFore) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgound) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
    _annotation = nil;
    // 移除定时器
    [self removeTimer];
    // 停止定位
    [_locationManager stopUpdatingHeading];
}
#pragma mark ---- 判断用户手机授权定位服务 ------
-(void) createLocationAuthorizationServer{
    BOOL enable = [CLLocationManager locationServicesEnabled];
    NSInteger state = [CLLocationManager authorizationStatus];
    if (!enable || 2 > state) {
        if (8 <= [[UIDevice currentDevice].systemVersion floatValue]) {
            NSLog(@"系统位置权限授权弹窗");
            // 系统位置权限授权弹窗
            CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
    }
}
- (BOOL)getUserLocationAuth {
    BOOL result = NO;
    switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
            break;
            case kCLAuthorizationStatusRestricted:
            break;
            case kCLAuthorizationStatusDenied:
            break;
            case kCLAuthorizationStatusAuthorizedAlways:
            result = YES;
            break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            result = YES;
            break;
            
        default:
            break;
    }
    return result;
}
#pragma mark --- 创建定位--------
-(void) createLocationManager{
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 6;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 3;
    //返回逆地理编码信息
    [_locationManager setLocatingWithReGeocode:YES];
    //开启持续定位
    [_locationManager startUpdatingLocation];

}

#pragma mark ------- BMKLocationManagerDelegate ---
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error {
    if (error){
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    } if (location) {//得到定位信息，添加annotation
        // 在地图上显示位置
        [self.mapView setCenterCoordinate:location.location.coordinate];
        // 添加自定义大头针
        self.annotation.coordinate = location.location.coordinate;
        // 把大头针添加到地图上
        [self.mapView addAnnotation:self.annotation];
        // 记录用户位置
        self.userLocation = location.location;
        // 定位地址
        NSString *addressStr;
        if ([location.rgcData.province isEqualToString:location.rgcData.city]) {
            addressStr = [NSString stringWithFormat:@"%@%@%@",location.rgcData.province,location.rgcData.street,location.rgcData.locationDescribe];
        }else{
             addressStr = [NSString stringWithFormat:@"%@%@%@%@",location.rgcData.province,location.rgcData.city,location.rgcData.street,location.rgcData.locationDescribe];
        }
        self.locationAddressLab.text = addressStr;
    }
}
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusDenied:{
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                //用户拒绝开启用户权限
                [self.view addSubview:self.showLocatView];
            }
            break;
        }
        default:
            break;
    }
}
// 绘制标记
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.image = [UIImage imageNamed:@"base_safety_myLocation"];
        // 设置该标注点动画显示
        newAnnotationView.animatesDrop = NO;
        return newAnnotationView;
    }
    return nil;
}

#pragma mark --- 创建地图view --------
-(void) createBMKMapView{
    __weak typeof(self) weakSelf = self;
    self.mapView = [[BMKMapView alloc]init];
    [self.view addSubview:self.mapView];
    self.mapView.delegate = self;
    [_mapView setZoomLevel:16];
    //隐藏比例尺
    _mapView.showMapScaleBar = NO;
    //显示定位图层
    _mapView.showsUserLocation = YES;
    
    //添加大头针
    self.annotation = [[BMKPointAnnotation alloc]init];

    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
        make.left.right.equalTo(weakSelf.view);
    }];
    
    UIView *toolView = [[UIView alloc]init];
    [self.view addSubview:toolView];
    toolView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mapView.mas_bottom);
        make.right.left.equalTo(weakSelf.view);
        make.height.equalTo(@(KSIphonScreenH(168)));
        make.bottom.equalTo(@(-KSTabbarH));
    }];
    
    UIView *addressView = [[UIView alloc]init];
    [toolView addSubview:addressView];
    addressView.backgroundColor = [UIColor colorTextWhiteColor];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(toolView);
    }];
    
    self.locationAddressLab = [[UILabel alloc]init];
    [addressView addSubview:self.locationAddressLab];
    self.locationAddressLab.text = @"";
    self.locationAddressLab.textColor = [UIColor colorCommonBlackColor];
    self.locationAddressLab.font = BFont(18);
    self.locationAddressLab.numberOfLines = 0;
    [self.locationAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView).offset(KSIphonScreenH(18));
        make.left.equalTo(addressView).offset(KSIphonScreenW(12));
        make.right.equalTo(addressView).offset(-KSIphonScreenW(12));
    }];
    
    UIView *attendanceBtnView = [[UIView alloc]init];
    [toolView addSubview:attendanceBtnView];
    attendanceBtnView.backgroundColor = [UIColor colorTextWhiteColor];
    [attendanceBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView.mas_bottom).offset(1);
        make.bottom.equalTo(toolView);
        make.width.height.equalTo(addressView);
        make.centerX.equalTo(addressView.mas_centerX);
    }];
    
    // 考勤签到按钮
    self.attendanceChenkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [attendanceBtnView addSubview:self.attendanceChenkBtn];
    [self.attendanceChenkBtn setTitle:@"08:30:39 考勤签到" forState:UIControlStateNormal];
    [self.attendanceChenkBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.attendanceChenkBtn.titleLabel.font = Font(17);
    [self.attendanceChenkBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.attendanceChenkBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.attendanceChenkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(attendanceBtnView).offset(KSIphonScreenW(22));
        make.right.equalTo(attendanceBtnView).offset(-KSIphonScreenW(22));
        make.height.equalTo(@(KSIphonScreenH(46)));
        make.centerY.equalTo(attendanceBtnView.mas_centerY);
    }];
    self.attendanceChenkBtn.layer.cornerRadius = KSIphonScreenH(46)/2;
    self.attendanceChenkBtn.layer.masksToBounds = YES;
    [self.attendanceChenkBtn addTarget:self action:@selector(selectAttendanceBtn:) forControlEvents:UIControlEventTouchUpInside];

    // 重新定位
    self.againLocatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.againLocatBtn];
    [self.againLocatBtn setTitle:@" 重新定位" forState:UIControlStateNormal];
    [self.againLocatBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    self.againLocatBtn.titleLabel.font = BFont(18);
    [self.againLocatBtn setImage:[UIImage imageNamed:@"base_safety_location"] forState:UIControlStateNormal];
    self.againLocatBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.againLocatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(toolView.mas_top).offset(-KSIphonScreenH(10));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(11));
        make.width.equalTo(@110);
        make.height.equalTo(@30);
    }];
    self.againLocatBtn.layer.cornerRadius = 4;
    self.againLocatBtn.layer.shadowOffset =  CGSizeMake(0, 2);           //阴影的偏移量
    self.againLocatBtn.layer.shadowOpacity = 0.3;                        //阴影的不透明度
    self.againLocatBtn.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;//阴影的颜色
    [self.againLocatBtn addTarget:self action:@selector(selectAgainBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加定时器
    [self addTimer];
}
#pragma mark ----- 按钮点击事件 --------
// 重新定位
-(void) selectAgainBtn:(UIButton *) sender{
    self.locationAddressLab.text = @"";
    // 移除大头针
    [_mapView removeAnnotation:self.annotation];
    //开启持续定位
    [_locationManager startUpdatingLocation];
}
// 考勤签到
-(void) selectAttendanceBtn:(UIButton *) sender{
    if ([self.locationAddressLab.text isEqualToString:@""]) {
        [self.view showErrorWithTitle:@"没有获取到当前用户位置信息" autoCloseTime:0.5];
        return;
    }
    
    //默认不开启人脸
    self.isFaceMontior = NO;
    
    // 判断是否开启人脸规则
    if (self.montiorDict.count == 0) {
        // 配置用户签到数据
        [self createAttendanceDataSoucre];
      
        return;
    }
    // 是否开启人脸 1 开启 2不开启
    NSString *discernStr = [NSString stringWithFormat:@"%@",self.montiorDict[@"discern"]];
    if ([discernStr isEqualToString:@"2"]) {
        // 配置用户签到数据
        [self createAttendanceDataSoucre];
        return;
    }
    //开启人脸
    self.isFaceMontior = YES;
    // 调人脸识别
    self.monitorRules = self.montiorDict[@"monitorRules"];
    [self passRulesConductFaceVeri:[self createFaveVerificationStr:@"start"]];
}
#pragma mark - ---  配置用户签到数据  --------
-(void) createAttendanceDataSoucre{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"unitId"] = [YWTUserInfo obtainWithCompanyId];
    param[@"unitName"] = [YWTUserInfo obtainWithCompany];
    param[@"address"] = self.locationAddressLab.text;
    param[@"sign"] = [self getSignAddressJSON:self.userLocation];
    // 不开启人脸
    if (!self.isFaceMontior) {
        param[@"status"] = @"1";
        param[@"faceIs"] = @"3";
    }else{
       // 开启人脸
        if ([self.faceIsStr isEqualToString:@"1"]) {
            // 人脸正常
            param[@"status"] = @"1";
            param[@"faceIs"] = @"1";
        }else{
            // 人脸异常
            param[@"status"] = @"2";
            param[@"faceIs"] = @"2";
        }
    }
    param[@"note"] = self.noteMarkStr;
    param[@"img"] = self.faceVierBackPhoto;
    param[@"taskid"] = self.taskIdStr;
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"versionAppNumber"] = localVersion;
    //获取系统版本 例如：9.2
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    param[@"versionNumber"] = sysVersion;
    param[@"version"] = [YWTTools deviceModelName];
    
    // 签到
    [self requestAttendanceCheckIn:param.copy];
}
// 返回 json字符串
-(NSString *) getSignAddressJSON:(CLLocation*) location{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"lng"] = [NSNumber numberWithDouble:location.coordinate.longitude];
    dict[@"lat"] = [NSNumber numberWithDouble:location.coordinate.latitude];
    NSString *signStr = [YWTTools convertToJsonData:dict];
    return signStr;
}
#pragma mark ------人脸识别 delectable -----
// 人脸采集成功回调方法
-(void)returnFaceSuccessImage:(NSDictionary *)dict{
    // 记录t
    self.faceImage = dict[@"faceSuccess"];
    // 调人脸对比接口
    [self requestAttendanceFaceRecoginition];
}
-(void)codeTimeOut{
    if (self.isFaceError) {
        self.mapView.hidden = NO;
    }
}
-(void)closeViewControll{
    if (self.isFaceError) {
        self.mapView.hidden = NO;
    }
}
#pragma mark - - - 创建人脸识别识别view ---------
-(void) createFaceErrorView{
    self.checkView = [[YWTInfoAttandanceCheckView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    [self.view addSubview:self.checkView];
    __weak typeof(self) weakSelf = self;
    self.checkView.addressStr = self.locationAddressLab.text;
    // 打开相册
    self.checkView.openLibary = ^{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *photos = [[UIImagePickerController alloc]init];
            photos.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            photos.allowsEditing = YES;
            photos.delegate = weakSelf;
            [weakSelf presentViewController:photos animated:YES completion:nil];
        }else{
            [weakSelf.view showErrorWithTitle:@"当前设备部支持访问" autoCloseTime:0.5];
        }
    };
    // 查看大图
    self.checkView.selectBigPhoto = ^(NSDictionary * _Nonnull dict) {
        [weakSelf chenkBigImageView:dict];
    };
    
    // 重新验证
    self.checkView.selectAgainVierf = ^{
        // 隐藏失败提示框
        weakSelf.checkView.hidden =  YES;
        // 是人脸失败
        weakSelf.isFaceError = YES;
        // 调人脸识别
        [weakSelf passRulesConductFaceVeri:[weakSelf createFaveVerificationStr:@"start"]];
    };
    // 确认签到
    self.checkView.selectTureAttendance = ^(NSDictionary * _Nonnull dict) {
        weakSelf.noteMarkStr = dict[@"noteStr"];
        weakSelf.markImageArr = [NSMutableArray arrayWithArray:dict[@"markImageArr"]];
        [weakSelf createAttendanceDataSoucre];
    };
}
#pragma mark ---------查看大图------
// 1 添加备注 2查看备注
-(void) chenkBigImageView:(NSDictionary *)dict {
    NSInteger index = [dict[@"indexPath"] integerValue];
    NSArray *arr = dict[@"imageArr"];
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<arr.count-1; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView image:arr[i]];
        [items addObject:item];
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:index];
    [browser showFromViewController:self];
}
#pragma mark - - - NSTimer ---------
- (void)addTimer {
    [self removeTimer];
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}
- (void)beginUpdateUI {
    if (self.timerInterval == 0) {
        self.timerInterval  = [self getNowTimestamp];
    }
    self.timerInterval ++;
    
    NSString *btnTitleStr = [NSString stringWithFormat:@"%@ 考勤签到",[self getWithTimerStr:self.timerInterval]];
    [self.attendanceChenkBtn setTitle:btnTitleStr forState:UIControlStateNormal];
}
// 时间戳 转 时间
-(NSString *) getWithTimerStr:(NSInteger) serverInterval{
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:serverInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString  = [formatter stringFromDate: date];
    return dateString;
}
#pragma mark - 获取当前时间的 时间戳
-(NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
    return timeSp;
}
#pragma mark --- 从后台推倒前台 --------
// 进入前台
-(void)enterFore{
    // 添加定时器
    [self addTimer];
    // 重新定位
    [self selectAgainBtn:nil];
}
// 进入后台
-(void)enterBackgound{
    // 清空定位地址
    self.locationAddressLab.text = @"";
    // 移除定时器
    [self removeTimer];
    // 移除大头针
    [_mapView removeAnnotation:self.annotation];
    // 移除 定位
    [_locationManager stopUpdatingHeading];
}
#pragma mark - UIImagePickerControllerDelegate代理 --------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取选中的原始图片
    //    UIImage *img = info[UIImagePickerControllerOriginalImage];
    
    //获取编辑后的图片
    UIImage *img1 = info[UIImagePickerControllerOriginalImage];
    
    //一定要关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 赋值
    self.checkView.libaryImage = img1;

}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title =self.moduleNameStr;
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //检查记录
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"签到记录" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    [self.customNavBar setOnClickRightButton:^{
        YWTBaseRecordController *recordVC = [[YWTBaseRecordController alloc]init];
        recordVC.recordType = showBaseRecordCheckType;
        [weakSelf.navigationController pushViewController:recordVC animated:YES];
    }];
}
#pragma mark ----- get ------
-(YWTShowLocatPromentView *)showLocatView{
    if (!_showLocatView) {
        _showLocatView  = [[YWTShowLocatPromentView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    }
    return _showLocatView;
}
-(NSMutableDictionary *)montiorDict{
    if (!_montiorDict) {
        _montiorDict = [NSMutableDictionary dictionary];
    }
    return _montiorDict;
}
-(NSMutableArray *)markImageArr{
    if (!_markImageArr) {
        _markImageArr = [NSMutableArray array];
    }
    return _markImageArr;
}
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark ----- 获取人脸规则 ------
-(void) requestAttendanceData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"unitId"] = [YWTUserInfo obtainWithCompanyId];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPATTENDANCEDATAQUERY_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        self.montiorDict = [NSMutableDictionary dictionaryWithDictionary:showdata];
    }];
}
#pragma mark ------ 用户签到 -----
-(void) requestAttendanceCheckIn:(NSDictionary *)dict{
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:HTTP_ATTAPPATTENDANCECHECKIN_URL params:dict andData:self.markImageArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        YWTBaseRecordController *recordVC = [[YWTBaseRecordController alloc]init];
        recordVC.recordType = showBaseRecordCheckType;
        [self.navigationController pushViewController:recordVC animated:YES];
    }];
}
#pragma mark ------ 人脸识别 ------
-(void) requestAttendanceFaceRecoginition{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"unitId"] = [YWTUserInfo obtainWithCompanyId];
    param[@"unitName"] = [YWTUserInfo obtainWithCompany];
    NSMutableArray *dataArr= [NSMutableArray array];
    //图片旋转90度
    [dataArr addObject:[self.faceImage fixOrientation]];
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:HTTP_ATTAPPATTENDANCEFACERECOGNITION_URL params:param andData:dataArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            //  人脸识别的返回图片
            NSString *imgStr = [NSString stringWithFormat:@"%@",showdata[@"img"]];
            self.faceVierBackPhoto = imgStr;
            
            NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
            if ([succStr isEqualToString:@"1"]) {
                self.faceIsStr = @"1";
                // 人脸签到
                // 判断是不是人脸失败弹框
                if (self.isFaceError) {
                    // 显示失败提示框
                    self.checkView.hidden =  NO;
                    self.checkView.faceVerifStr = @"已通过";
                }else{
                    [self createAttendanceDataSoucre];
                }
            }else{
                self.faceIsStr = @"2";
                
                if (self.isFaceError) {
                    // 显示失败提示框
                    self.checkView.hidden =  NO;
                    self.checkView.faceVerifStr = @"未通过";
                }else{
                    // 创建人脸识别view
                    [self createFaceErrorView];
                }
            }
        }
    }];
}




@end
