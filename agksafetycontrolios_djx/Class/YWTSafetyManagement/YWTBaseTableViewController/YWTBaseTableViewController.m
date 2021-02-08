//
//  BaseTableViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseTableViewController.h"

#import "YWTBaseRecordController.h"
#import "YWTBaseDetailController.h"
#import "YWTAnnexRecordController.h"
#import "YWTAnnexLookOverJSController.h"
#import "YWTBaseRecordController.h"

#import "YWTBaseBottomToolView.h"
#import "YWTBaseAddAnnexPushView.h"
#import "HQPickerView.h"
#import "OSSManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AVKit/AVKit.h>
#import "OSSAuthModel.h"
#import "JCVideoRecordView.h"
#import "UIView+JCAddition.h"
#import "JCVideoRecordManager.h"

#import "YWTSafetyChenkUserInfoCell.h"
#define SAFETYCHENKUSERINFO_CELL  @"YWTSafetyChenkUserInfoCell"
#import "YWTBaseTechnicalDisclCell.h"
#define BASETECHNICALDISCL_CELL @"YWTBaseTechnicalDisclCell"
#import "YWTSafetyChenkUnitCell.h"
#define SAFETYCHENKUNIT_CELL @"YWTSafetyChenkUnitCell"
#import "YWTBaseWorkMeetingCell.h"
#define BASEWORKMEETIONG_CELL @"YWTBaseWorkMeetingCell"
#import "YWTBaseViolationCell.h"
#define BASEVIOLATION_CELL @"YWTBaseViolationCell"
#import "YWTBaseAnnexCell.h"
#define BASEANNEX_CELL @"YWTBaseAnnexCell"

@interface YWTBaseTableViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
HQPickerViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
AnnexRecordControllerDelegate,
TZImagePickerControllerDelegate
>
// 附件view
@property (nonatomic,strong) YWTBaseAddAnnexPushView *addAnnexPushView;
// 确定view
@property (nonatomic,strong) YWTBaseBottomToolView *toolView;
//自定义选择器
@property (nonatomic,strong) HQPickerView *hpPickerView;
// 附件view
@property (nonatomic,strong)  YWTCWVoiceView *vioceView;
/*播放*/
@property (nonatomic,strong) AVAudioPlayer * avPlay;
// 录视频view
@property (nonatomic, strong) JCVideoRecordView *recordView;

@property (nonatomic,strong) UITableView *BaseTableView;
// 配置数据源
@property (nonatomic,strong) NSMutableArray *settingArr;
//上传数据源
@property (nonatomic,strong) NSMutableArray *configDataArr;
// 附件数据源
@property (nonatomic,strong) NSMutableArray *annexDataArr;
// 记录文件大小
@property (nonatomic,strong) NSString *uploadSize;
// 记录 必录描述文字
@property (nonatomic,strong) NSString *infoRemorkStr;
// 附件arr
@property (nonatomic,strong) NSMutableArray *enclosureArr;

@property (nonatomic,strong) MBProgressHUD *HUD;

// 判断是提交还是存入草稿   默认YES  提交  NO 存入草稿
@property (nonatomic,assign) BOOL isSumbitBtn;

@end

@implementation YWTBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // 默认YES  提交
    self.isSumbitBtn = YES;
    // 设置导航栏
    [self setNavi];
    // 创建底部提交按钮
    [self createSubmitBtn];
    // 创建TableView
    [self createTableView];
    // 获取配置数据
    [self requestCheckSetting];
    // 获取阿里云OSS配置参数
    [self requestUploadOSSConfig];
    
    if (self.saveDataType == showBaseSaveDataAlterType && self.scoureType == showBaseAlterSoucreType) {
        [self requestWithCheckInfos];
    }
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.BaseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-CGRectGetHeight(self.toolView.frame))];
    [self.view addSubview:self.BaseTableView];
    
    self.BaseTableView.delegate = self;
    self.BaseTableView.dataSource = self;
    self.BaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.BaseTableView.backgroundColor =  [UIColor colorViewBackGrounpWhiteColor];
    
    [self.BaseTableView registerClass:[YWTSafetyChenkUserInfoCell class] forCellReuseIdentifier:SAFETYCHENKUSERINFO_CELL];
    [self.BaseTableView registerClass:[YWTBaseTechnicalDisclCell class] forCellReuseIdentifier:BASETECHNICALDISCL_CELL];
    [self.BaseTableView registerClass:[YWTSafetyChenkUnitCell class] forCellReuseIdentifier:SAFETYCHENKUNIT_CELL];
    [self.BaseTableView registerClass:[YWTBaseWorkMeetingCell class] forCellReuseIdentifier:BASEWORKMEETIONG_CELL];
    [self.BaseTableView registerClass:[YWTBaseViolationCell class] forCellReuseIdentifier:BASEVIOLATION_CELL];
    [self.BaseTableView registerClass:[YWTBaseAnnexCell class] forCellReuseIdentifier:BASEANNEX_CELL];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.configDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        if (self.veiwBaseType == showViewControllerSafetyType) {
            //  安全检查
            YWTSafetyChenkUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:SAFETYCHENKUSERINFO_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellType = showBaseCellSafetyType;
            cell.dict = self.configDataArr[indexPath.row];
            return cell;
        }else if (self.veiwBaseType == showViewControllerMeetingType){
            // 班前班后会
            YWTSafetyChenkUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:SAFETYCHENKUSERINFO_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellType = showBaseCellMeetingType;
            cell.dict = self.configDataArr[indexPath.row];
            return cell;
        }else if (self.veiwBaseType == showViewControllerViolationType){
            // // 违章
            YWTBaseTechnicalDisclCell *cell = [tableView dequeueReusableCellWithIdentifier:BASETECHNICALDISCL_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.baseType = showBaseViolationType;
            cell.dict = self.configDataArr[indexPath.row];
            return cell;
        }else{
             // 技术
            YWTBaseTechnicalDisclCell *cell = [tableView dequeueReusableCellWithIdentifier:BASETECHNICALDISCL_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.baseType = showBaseTechnicalType;
            cell.dict = self.configDataArr[indexPath.row];
            return cell;
        }
    }else if (indexPath.row == 1){
        if (self.veiwBaseType == showViewControllerSafetyType) {
            //  安全检查
            YWTSafetyChenkUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:SAFETYCHENKUNIT_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 修改
            if (self.scoureType == showBaseAlterSoucreType) {
                cell.dict = self.configDataArr[indexPath.row];
            }
            // 选择电压等级
            cell.selectVoltageLevel = ^{
                [weakSelf createHPPickView];
            };
            // 输入
            cell.selectRutureKeyBord = ^(NSInteger index, NSString * _Nonnull textStr) {
                [weakSelf createCheckTextField:index andTextStr:textStr andIndexPath:indexPath];
            };
            // 内容
            cell.selectContentKeyBord = ^(NSString * _Nonnull contentStr) {
                NSMutableDictionary *contentDict = weakSelf.configDataArr[indexPath.row];
                contentDict[@"securityCheckContent"] = contentStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            };
            return cell;
        }else if (self.veiwBaseType == showViewControllerMeetingType){
            // 班前班后会
            YWTBaseWorkMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:BASEWORKMEETIONG_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellType = showBaseWorkMeetingType;
            // 修改
            if (self.scoureType == showBaseAlterSoucreType) {
                cell.dict = self.configDataArr[indexPath.row];
            }
            // 输入
            cell.selectRutureKeyBord = ^(NSInteger index, NSString * _Nonnull textStr) {
                [weakSelf createCheckTextField:index andTextStr:textStr andIndexPath:indexPath];
            };
            // 内容
            cell.selectContentKeyBord = ^(NSString * _Nonnull contentStr) {
                NSMutableDictionary *contentDict = weakSelf.configDataArr[indexPath.row];
                contentDict[@"classRecordContent"] = contentStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            };
            return cell;
        }else if (self.veiwBaseType == showViewControllerViolationType){
            // // 违章
            YWTBaseViolationCell *cell = [tableView dequeueReusableCellWithIdentifier:BASEVIOLATION_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 修改
            if (self.scoureType == showBaseAlterSoucreType) {
                cell.dict = self.configDataArr[indexPath.row];
            }
            // 选择电压等级
            cell.selectViolation  = ^{
                [weakSelf createHPPickView];
            };
            // 输入
            cell.selectRutureKeyBord = ^(NSInteger index, NSString * _Nonnull textStr) {
                [weakSelf createCheckTextField:index andTextStr:textStr andIndexPath:indexPath];
            };
            // 内容
            cell.selectContentKeyBord = ^(NSString * _Nonnull contentStr) {
                NSMutableDictionary *contentDict = weakSelf.configDataArr[indexPath.row];
                contentDict[@"violationHanContent"] = contentStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            };
            return cell;
        }else{
            // 技术
            YWTBaseWorkMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:BASEWORKMEETIONG_CELL forIndexPath:indexPath];
            cell.cellType = showBaseWorkTechnicalType;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 修改
            if (self.scoureType == showBaseAlterSoucreType) {
                cell.dict = self.configDataArr[indexPath.row];
            }
            // 输入
            cell.selectRutureKeyBord = ^(NSInteger index, NSString * _Nonnull textStr) {
                [weakSelf createCheckTextField:index andTextStr:textStr andIndexPath:indexPath];
            };
            // 内容
            cell.selectContentKeyBord = ^(NSString * _Nonnull contentStr) {
                NSMutableDictionary *contentDict = weakSelf.configDataArr[indexPath.row];
                contentDict[@"technicalDisclosureContent"] = contentStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            };
            return cell;
        }
    }else{
        // 附件
        YWTBaseAnnexCell *cell = [tableView dequeueReusableCellWithIdentifier:BASEANNEX_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.scoureType == showBaseAlterSoucreType) {
            //修改模式
            cell.cellType = showAnnexCellAlterType;
        }else{
            //添加模式
             cell.cellType = showAnnexCellAddType;
        }
        
        if (self.veiwBaseType == showViewControllerViolationType) {
            // 违章处理
            cell.annexCellType = showBaseAnnexCellViolationType;
        }else{
            cell.annexCellType = showBaseAnnexCellNomalType;
        }
        cell.annexArr = self.annexDataArr;
        // 记录 必录描述文字
        cell.infoRemorkStr = self.infoRemorkStr;
        // 添加附件按钮
        cell.baseAddAnnex = ^{
             [weakSelf createAddAnnexView];
        };
        // 删除数据源
        cell.selectDelBtn = ^(NSInteger index) {
            // 删除数据源
            [weakSelf.annexDataArr removeObjectAtIndex:index];
            // 刷新UI
            [weakSelf.BaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        // 播放视频
        cell.selectVodplay = ^(NSDictionary * _Nonnull annexDict) {
            if (self.scoureType == showBaseAddSoucreType) {
                // 添加
                NSString *typeStr = [NSString stringWithFormat:@"%@",annexDict[@"type"]];
                if ([typeStr isEqualToString:@"video"]) {
                    // 视频
                    [weakSelf createVodpalyView:annexDict];
                }else if ([typeStr isEqualToString:@"audio"]){
                    // 音频
                    [weakSelf createAudioPlay:annexDict];
                }else if ([typeStr isEqualToString:@"images"]){
                    [weakSelf createCheckPhoto:annexDict];
                }
            }else{
               // 修改
                [weakSelf createAlterStatuFileDict:annexDict];
            }
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return KSIphonScreenH(82);
    }else if (indexPath.row == 1){
        if (self.veiwBaseType == showViewControllerSafetyType) {
            //  安全检查
            return KSIphonScreenH(280);
        }else if (self.veiwBaseType == showViewControllerMeetingType){
            // 班前班后会
            return KSIphonScreenH(240);
        }else if (self.veiwBaseType == showViewControllerViolationType){
            // // 违章
            return KSIphonScreenH(280);
        }else{
            // 技术
            return KSIphonScreenH(250);
        }
    }else{
        if (self.annexDataArr.count == 0) {
            if (self.veiwBaseType == showViewControllerViolationType) {
                // 违章处理
                return KSIphonScreenH(130);
            }else if (self.veiwBaseType == showViewControllerSafetyType){
                //安全检查
                return KSIphonScreenH(160);
            }else{
                return KSIphonScreenH(145);
            }
        }else{
            NSInteger index = self.annexDataArr.count;
            CGFloat  cellHeight = index * KSIphonScreenH(40);
            if (self.veiwBaseType == showViewControllerViolationType) {
                // 违章处理
               return KSIphonScreenH(130)+cellHeight;
            }else if (self.veiwBaseType == showViewControllerSafetyType){
                //安全检查
                return KSIphonScreenH(160)+cellHeight;
            }else{
                return KSIphonScreenH(145)+cellHeight;
            }
        }
    }
}
#pragma mark --- 创建添加附件view --------
-(void) createAddAnnexView{
    __weak typeof(self) weakSelf = self;
    self.addAnnexPushView = [[YWTBaseAddAnnexPushView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self.view addSubview:self.addAnnexPushView];
    
    // 取消视图
    self.addAnnexPushView.removeView = ^{
        [weakSelf.vioceView removeFromSuperview];
    };

    // 打开视频
    self.addAnnexPushView.switchVideo = ^{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = weakSelf;
        //相册选取==UIImagePickerControllerSourceTypeSavedPhotosAlbum（打开所有视频，而不是列表）
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //设置选取类型，只能是视频
        imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    };
    // 打开相机
    self.addAnnexPushView.switchCemera = ^{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *photos = [[UIImagePickerController alloc]init];
            photos.sourceType = UIImagePickerControllerSourceTypeCamera;
            photos.modalPresentationStyle = UIModalPresentationFullScreen;
            photos.delegate = weakSelf;
            [weakSelf presentViewController:photos animated:YES completion:nil];
        }else{
            [weakSelf.view showErrorWithTitle:@"当前设备部支持访问" autoCloseTime:0.5];
        }
    };
    // 打开相册
    self.addAnnexPushView.switchPhotoLibary = ^{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:weakSelf];
            imagePickerVC.iconThemeColor = [UIColor colorLineCommonBlueColor];
            imagePickerVC.showPhotoCannotSelectLayer = YES;
            imagePickerVC.allowPickingVideo = NO;
            imagePickerVC.allowTakePicture = NO;
            imagePickerVC.barItemTextColor = [UIColor colorLineCommonBlueColor];
            imagePickerVC.naviBgColor = [UIColor colorTextWhiteColor];
            imagePickerVC.oKButtonTitleColorNormal = [UIColor colorLineCommonBlueColor];
            imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [weakSelf presentViewController:imagePickerVC animated:YES completion:nil];
        }else{
            [weakSelf.view showErrorWithTitle:@"当前设备部支持访问" autoCloseTime:0.5];
        }
    };
    // 打开音频列表
    self.addAnnexPushView.switchAudioList = ^{
        YWTAnnexRecordController *recordListVC = [[YWTAnnexRecordController alloc]init];
        recordListVC.delegate = weakSelf;
        [weakSelf.navigationController pushViewController:recordListVC animated:YES];
    };
    // 打开录音
    self.addAnnexPushView.switchRecording = ^{
        weakSelf.vioceView = [[YWTCWVoiceView alloc]init];
        [weakSelf.view addSubview:weakSelf.vioceView];
        [weakSelf.vioceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
            make.height.equalTo(@(KSIphonScreenH(270)));
        }];
        __weak typeof(weakSelf) strongSelf = weakSelf;
        // 选择确定按钮
        weakSelf.vioceView.selectTureBtn = ^(NSDictionary *dict) {
            // 移除view
            [strongSelf.vioceView removeFromSuperview];
            // 关闭附件view
            [strongSelf.addAnnexPushView removeFromSuperview];
            //添加到附件数据中
            [weakSelf.annexDataArr addObject:dict];
            // 刷新数据
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            [weakSelf.BaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
    };
    
   // 打开录视频
    self.addAnnexPushView.switchRecordVideo = ^{
        weakSelf.recordView = [[JCVideoRecordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        // 取消按钮
        weakSelf.recordView.cancelBlock = ^{
            
        };
        // 点击确定
        weakSelf.recordView.completionBlock = ^(NSURL *fileUrl) {
            // 关闭附件view
            [weakSelf.addAnnexPushView removeFromSuperview];
            NSString *fileStr = [fileUrl absoluteString];
            NSArray *fileArr = [fileStr componentsSeparatedByString:@"/"];
            NSString *nameStr = [NSString stringWithFormat:@"%@/%@",fileArr[fileArr.count -2],[fileArr lastObject]];
            NSData *fileData = [NSData dataWithContentsOfURL:fileUrl];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"typeName"] =[fileArr lastObject];
            param[@"vodio"] = [fileUrl absoluteString];
            param[@"filePath"] = fileData;
            param[@"objectKey"] = nameStr;
            param[@"name"] = [fileArr lastObject];
            param[@"type"] = @"video";
            param[@"size"] = [NSString stringWithFormat:@"%f",[JCVideoRecordManager getfileSize:[fileUrl absoluteString]]];

            //添加到附件数据中
            [weakSelf.annexDataArr addObject:param];
            // 刷新数据
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            [weakSelf.BaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [weakSelf.recordView present];
    };
}
#pragma mark - UIImagePickerControllerDelegate代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 关闭附件view
    [self.addAnnexPushView removeFromSuperview];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        // 相册
        if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            //获取编辑后的URL
            NSURL * videoXT_URL;
            if (@available(iOS 11.0, *)) {
                videoXT_URL = [info objectForKey:UIImagePickerControllerImageURL];
            }else{
                videoXT_URL = [info objectForKey:UIImagePickerControllerReferenceURL];
            }
            //获取的图片
            UIImage *imagePhoto = info[UIImagePickerControllerOriginalImage];
            // 转换成文件流
            NSData *filePath = UIImageJPEGRepresentation(imagePhoto, 0.5);
            // 获取文件名称
            NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
            NSArray *imageArr = [[url absoluteString] componentsSeparatedByString:@"?"];
            NSString *urlStr = imageArr[1];
            NSArray *imageNameArr = [urlStr componentsSeparatedByString:@"="];
            NSString *imageName = imageNameArr[1];
            NSArray *arr = [imageName componentsSeparatedByString:@"&"];
            NSString *imageNameStr = arr[0];
            NSString *tyepStr = [imageNameArr[2] lowercaseString];
            NSMutableString *nameStr = [NSMutableString string];
            [nameStr appendString:imageNameStr];
            [nameStr appendString:@"."];
            [nameStr appendString:imageNameArr[2]];
            NSString *dateString =[NSString stringWithFormat:@"IOS-OSS-%@",[YWTTools getNowTimeFeildNameFormatter:@"YYYY-MM-dd-HH-mm-ss"]];
            NSString *name = [NSString  stringWithFormat:@"%@.%@", dateString,tyepStr];
            NSString *fileName = [NSString  stringWithFormat:@"images/%@.%@", dateString,tyepStr];
            param[@"typeName"] =name;
            param[@"filePath"] = filePath;
            param[@"objectKey"] = fileName;
            param[@"name"] = name;
            param[@"image"] = imagePhoto;
            param[@"type"] = @"images";
            param[@"size"] = @"0";
        }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //获取的图片
            UIImage *imagePhoto = info[UIImagePickerControllerOriginalImage];
            // 转换成文件流
            NSData *filePath = UIImageJPEGRepresentation(imagePhoto, 0.5);
            NSString *dateString = [NSString stringWithFormat:@"IOS-OSS-%@",[YWTTools getNowTimeFeildNameFormatter:@"YYYY-MM-dd-HH-mm-ss"]];
            NSString *typeName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            NSString *fileName = [NSString  stringWithFormat:@"images/%@.jpg", dateString];
            param[@"typeName"] =typeName;
            param[@"filePath"] = filePath;
            param[@"image"] = imagePhoto;
            param[@"objectKey"] = fileName;
            param[@"name"] = typeName;
            param[@"type"] = @"images";
            param[@"size"] = @"0";
        }
    } else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie]) {
        NSURL * videoXT_URL;
        // 获取系统版本
        if (@available(iOS 11.0, *)) {
            videoXT_URL = [info objectForKey:UIImagePickerControllerMediaURL];
        }else{
            videoXT_URL = [info objectForKey:UIImagePickerControllerReferenceURL];
        }
        // 把视频文件转nsdata
        NSData *fileData = [NSData dataWithContentsOfURL:videoXT_URL];
        
        // 获取文件名称
        NSString *fileNameStr =[[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
        //获取视频的url（所有视频都有这个值）
        NSArray *imageArr = [fileNameStr componentsSeparatedByString:@"?"];
        NSString *urlStr = imageArr[1];
        NSArray *imageNameArr = [urlStr componentsSeparatedByString:@"="];
        NSString *imageName = imageNameArr[1];
        NSArray *arr = [imageName componentsSeparatedByString:@"&"];
        NSString *imageNameStr = arr[0];
        NSString *tyepStr = [imageNameArr[2] lowercaseString];
        NSMutableString *nameStr = [NSMutableString string];
        [nameStr appendString:imageNameStr];
        [nameStr appendString:@"."];
        [nameStr appendString:imageNameArr[2]];
        NSString *dateString =[NSString stringWithFormat:@"IOS-OSS-%@",[YWTTools getNowTimeFeildNameFormatter:@"YYYY-MM-dd-HH-mm-ss"]];
        NSString *fileName = [NSString  stringWithFormat:@"video/%@.%@", dateString,tyepStr];
        NSString *name = [NSString  stringWithFormat:@"%@.%@", dateString,tyepStr];
        param[@"typeName"] =nameStr;
        param[@"vodio"] = [videoXT_URL absoluteString];
        param[@"filePath"] = fileData;
        param[@"objectKey"] = fileName;
        param[@"name"] = name;
        param[@"type"] = @"video";
        param[@"size"] = [NSNumber numberWithInteger:fileData.length];
    }
    //添加到附件数据中
    [self.annexDataArr addObject:param];
    // 刷新数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.BaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //一定要关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 多图选择
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    // 关闭附件view
    [self.addAnnexPushView removeFromSuperview];
    
    for (int i = 0 ; i < photos.count; i++) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        //获取的图片
        UIImage *imagePhoto = photos[i];
        // 转换成文件流
        NSData *filePath = UIImageJPEGRepresentation(imagePhoto, 0.5);
        // 获取文件名称
        PHAsset *asset = assets[i];
        NSString *imageNameStr = [asset valueForKey:@"filename"];
        NSString *dateString =[NSString stringWithFormat:@"IOS-OSS-%@",[YWTTools getNowTimeFeildNameFormatter:@"HH-mm-ss"]];
        NSString *name = [NSString  stringWithFormat:@"%@%@", dateString,imageNameStr];
        NSString *fileName = [NSString  stringWithFormat:@"images/%@%@", dateString,imageNameStr];
        param[@"typeName"] =name;
        param[@"filePath"] = filePath;
        param[@"objectKey"] = fileName;
        param[@"name"] = name;
        param[@"image"] = imagePhoto;
        param[@"type"] = @"images";
        param[@"size"] = [NSNumber numberWithInteger:filePath.length];
        //添加到附件数据中
        [self.annexDataArr addObject:param];
    }
    // 刷新数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.BaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //一定要关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ---  图片多选返回 ---------
-(void)selectBackBtn:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ---创建视频播放View --------
-(void) createVodpalyView:(NSDictionary *) dict{
    AVPlayerViewController *ctrl = [[AVPlayerViewController alloc] init];
    NSString *urlName;
    if ([[dict allKeys] containsObject:@"url"]) {
         urlName = dict[@"filePath"];
    }else{
        urlName = dict[@"vodio"];
    }
    NSURL *url = [NSURL URLWithString:urlName];
    ctrl.player = [[AVPlayer alloc]initWithURL:url];
    [self presentViewController:ctrl animated:YES completion:nil];
}
#pragma mark ---创建音频播放 --------
-(void) createAudioPlay:(NSDictionary *) dict{
    NSString *urlName;
    if ([[dict allKeys] containsObject:@"url"]) {
        urlName = [NSString stringWithFormat:@"%@",dict[@"url"]];
    }else{
        urlName = [NSString stringWithFormat:@"%@",dict[@"audio"]];
    }
    YWTBaseVodPlayView *playView = [[YWTBaseVodPlayView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    playView.filePath= urlName;
    [self.view addSubview:playView];
}
#pragma mark ---创建查看大图 --------
-(void) createCheckPhoto:(NSDictionary *) dict{
    NSMutableArray *items = [NSMutableArray array];
    UIImageView *imageView = [[UIImageView alloc]init];
    UIImage * image = dict[@"image"];
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView image:image];
    [items addObject:item];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:self];
}
#pragma mark -----修改查看文件 ----------
-(void) createAlterStatuFileDict:(NSDictionary *)dict{
    __weak typeof(self) weakSelf = self;
    if (![[dict allKeys] containsObject:@"url"]) {
        // 添加
        NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
        if ([typeStr isEqualToString:@"video"]) {
            // 视频
            [weakSelf createVodpalyView:dict];
        }else if ([typeStr isEqualToString:@"audio"]){
            // 音频
            [weakSelf createAudioPlay:dict];
        }else if ([typeStr isEqualToString:@"images"]){
            [weakSelf createCheckPhoto:dict];
        }
    }
    
    if ([[dict allKeys] containsObject:@"url"]) {
        // 修改
        NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
        if ([typeStr isEqualToString:@"images"]) {
            // 图片
            NSMutableArray *items = [NSMutableArray array];
            UIImageView *imageView = [[UIImageView alloc]init];
            NSString *urlStr = [NSString stringWithFormat:@"%@",dict[@"url"]];
            NSURL *url = [NSURL URLWithString:urlStr];
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:url];
            [items addObject:item];
            KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
            [browser showFromViewController:weakSelf];
        }else if ([typeStr isEqualToString:@"video"]){
            // 视频
            AVPlayerViewController *ctrl = [[AVPlayerViewController alloc] init];
            NSString *urlStr = [NSString stringWithFormat:@"%@",dict[@"url"]];
            NSURL *url = [NSURL URLWithString:urlStr];
            ctrl.player = [[AVPlayer alloc]initWithURL:url];
            [weakSelf presentViewController:ctrl animated:YES completion:nil];
        }else if ([typeStr isEqualToString:@"audio"]){
            // 音频
            [weakSelf createAudioPlay:dict];
        }else if ([typeStr isEqualToString:@"pdf"]){
            // pdf
            YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
            NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
            jsVC.mIdStr = midStr;
            jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
            jsVC.fileType = @"1";
            [self.navigationController pushViewController:jsVC animated:YES];
        }else if ([typeStr isEqualToString:@"doc"]){
            // doc
            YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
            NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
            jsVC.mIdStr = midStr;
            jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
            jsVC.fileType = @"1";
            [self.navigationController pushViewController:jsVC animated:YES];
        }else if ([typeStr isEqualToString:@"ppt"]){
            // ppt
            YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
            NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
            jsVC.mIdStr = midStr;
            jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
            jsVC.fileType = @"1";
            [self.navigationController pushViewController:jsVC animated:YES];
        }else if ([typeStr isEqualToString:@"xls"]){
            // xls
            YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
            NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
            jsVC.mIdStr = midStr;
            jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
            jsVC.fileType = @"1";
            [self.navigationController pushViewController:jsVC animated:YES];
        }else{
            // 其他
            [self.view showErrorWithTitle:@"无法打开" autoCloseTime:0.5];
        }
    }
}
#pragma mark  ---- AnnexRecordControllerDelegate ----
-(void) selectAudioListDict:(NSDictionary *)dcit{
    // 关闭附件view
    [self.addAnnexPushView removeFromSuperview];
    //添加到附件数据中
    [self.annexDataArr addObject:dcit];
    // 刷新数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.BaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark --- 创建安全检查输入 --------
-(void) createCheckTextField:(NSInteger) index andTextStr:(NSString *)textStr andIndexPath:(NSIndexPath *)indexPath{
     __weak typeof(self) weakSelf = self;
    NSMutableDictionary *contentDict = weakSelf.configDataArr[indexPath.row];
    contentDict[@"userId"] = [YWTUserInfo obtainWithUserId];
    contentDict[@"realName"] = [YWTUserInfo obtainWithRealName];
    switch (index) {
        case 1:{
            if (self.veiwBaseType ==  showViewControllerSafetyType) {
                //安全检查
                // 检查单位名称
                contentDict[@"beingCheckUnitName"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerMeetingType){
                //班前班后会
                // 工作地点
                contentDict[@"classRecordAddress"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerViolationType){
                //违章处理
                 //违章人员
                contentDict[@"violationUserInfo"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
                //技术交底
                   // 工作地点
                contentDict[@"technicalDisclosureAddress"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }
            break;
        }
        case 2:{
            if (self.veiwBaseType ==  showViewControllerSafetyType) {
                //安全检查
                // 检查地点
                contentDict[@"securityCheckAddress"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerMeetingType){
                //班前班后会
                // 工作票
                contentDict[@"workTicketNumber"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerViolationType){
                //违章处理
                  // 违章单位
                contentDict[@"violationUnitName"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
                //技术交底
                 // 工作票
                contentDict[@"workTicketNumber"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }
            break;
        }
        case 3:{
            if (self.veiwBaseType ==  showViewControllerSafetyType) {
                //安全检查
                // 工作票号
                contentDict[@"workTicketNumber"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerMeetingType){
                //班前班后会
                // 标题
                contentDict[@"classRecordTitle"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerViolationType){
                //违章处理
                 //违章事由
                contentDict[@"violationHanTitle"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
                //技术交底
                // 标题
                contentDict[@"technicalDisclosureTitle"] = textStr;
                [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            }
            break;
        }
        case 4:{
            // 检查标题
            contentDict[@"securityCheckTitle"] = textStr;
            [weakSelf.configDataArr replaceObjectAtIndex:indexPath.row withObject:contentDict];
            break;
        }
        default:
            break;
    }
}
#pragma mark --- 注册阿里云OSS --------
-(void)registeredAliOss{
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc]initWithFederationTokenGetter:^OSSFederationToken * _Nullable{
        // 构造请求访问您的业务server
        NSURL * url = [NSURL URLWithString:HTTP_ATTAPPUPLOADOSSSINGNCONFIG_URL];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
        NSURLSession * session = [NSURLSession sharedSession];
        // 发送请求
        NSURLSessionTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [tcs setError:error];
            }
            [tcs setResult:data];
        }];
        [sessionTask resume];
        // 需要阻塞等待请求返回
        [tcs.task waitUntilFinished];
        // 解析结果
        if (tcs.task.error) {
            NSLog(@"get token error: %@", tcs.task.error);
            return nil;
        } else{
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:tcs.task.result options:kNilOptions error:nil];
            OSSFederationToken * token = [OSSFederationToken new];
            token.tAccessKey = [object objectForKey:@"AccessKeyId"];
            token.tSecretKey = [object objectForKey:@"AccessKeySecret"];
            token.tToken = [object objectForKey:@"SecurityToken"];
            token.expirationTimeInGMTFormat = [object objectForKey:@"Expiration"];
            NSLog(@"get token: %@", object);
            return token;
        }
    }];
    OSSClientConfiguration *cfg = [[OSSClientConfiguration alloc] init];
    cfg.maxRetryCount = 3;
    cfg.timeoutIntervalForRequest = 15;
    cfg.isHttpdnsEnable = NO;
    cfg.crc64Verifiable = YES;
    NSString *endpointStr = [NSString stringWithFormat:@"http://%@",[NSString stringWithFormat:@"%@",[OSSManager sharedManager].oSSDataDict[@"endpoint"]]];
    OSSClient *defaultClient = [[OSSClient alloc] initWithEndpoint:endpointStr credentialProvider:credential clientConfiguration:cfg];
    [OSSManager sharedManager].defaultClient = defaultClient;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    NSString *btnTitleStr;
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        self.customNavBar.title = self.moduleNameStr;
        btnTitleStr = @"检查记录";
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        self.customNavBar.title = self.moduleNameStr;
        btnTitleStr = @"班会记录";
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        self.customNavBar.title = self.moduleNameStr;
        btnTitleStr = @"处理记录";
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        self.customNavBar.title = self.moduleNameStr;
        btnTitleStr = @"交底记录";
    }
    // 存入草稿 并且是编辑中 修改页面
    if (self.saveDataType == showBaseSaveDataAlterType &&
        self.scoureType == showBaseAlterSoucreType) {
        self.customNavBar.title = self.moduleNameStr;
        btnTitleStr = @"删除记录";
    }
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //检查记录
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:btnTitleStr forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    [self.customNavBar setOnClickRightButton:^{
        //  存入草稿 并且是编辑中 修改页面  删除按钮
        if (self.saveDataType == showBaseSaveDataAlterType &&
            self.scoureType == showBaseAlterSoucreType) {
            // 删除
            [weakSelf getWithShowPromptStr:@"是否删除该记录!" andTypeStr:@"2"];
            return ;
        }
        // 跳转到记录页面
        [weakSelf pushBaseRecordController];
    }];
}
#pragma mark --- 跳转到记录页面 --------
-(void) pushBaseRecordController{
    YWTBaseRecordController *recordVC = [[YWTBaseRecordController alloc]init];
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        //安全检查
        recordVC.recordType = showBaseRecordSafetyType;
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        //班前班后会
        recordVC.recordType = showBaseRecordMeetingType;
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        //违章处理
        recordVC.recordType = showBaseRecordViolationType;
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        //技术交底
        recordVC.recordType = showBaseRecordTechnoloType;
    }
    [self.navigationController pushViewController:recordVC animated:YES];
}
#pragma mark --- 自定义选择器 --------
-(void)createHPPickView{
    _hpPickerView = [[HQPickerView alloc]initWithFrame:self.view.bounds];
    _hpPickerView.delegate = self ;
    if (self.veiwBaseType == showViewControllerSafetyType ) {
        _hpPickerView.customArr = self.settingArr;
        _hpPickerView.timeLab.text = @"电压等级";
    }else if (self.veiwBaseType == showViewControllerViolationType){
        _hpPickerView.customArr = @[@"一般",@"严重",@"特别严重"];
        _hpPickerView.timeLab.text = @"违章等级";
    }
    [self.view addSubview:self.hpPickerView];
}
#pragma mark --- HQPickerViewDelegate --------
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSMutableDictionary *contentDict = self.configDataArr[1];
    if (self.veiwBaseType == showViewControllerSafetyType ) {
       //安全检查
        YWTSafetyChenkUnitCell *cell = [self.BaseTableView cellForRowAtIndexPath:indexPath];
        cell.voltageLevelLab.text = text;
        cell.showVoltageLevelLab.hidden = YES;
        // 贴换数据源
        contentDict[@"voltageLevels"] = text;
        [self.configDataArr replaceObjectAtIndex:1 withObject:contentDict];
    }else if (self.veiwBaseType == showViewControllerViolationType){
        YWTBaseViolationCell *cell = [self.BaseTableView cellForRowAtIndexPath:indexPath];
        cell.ViolaGradeLab.text = text;
        cell.showViolaGradeLab.hidden = YES;
        // 贴换数据源
        contentDict[@"levels"] = text;
        [self.configDataArr replaceObjectAtIndex:1 withObject:contentDict];
    }
}
#pragma mark --- 创建底部提交按钮 --------
-(void)createSubmitBtn{
    [self.view addSubview:self.toolView];
    __weak typeof(self) weakSelf = self;
    // 确定
    self.toolView.selectSubmitBtn = ^{
        weakSelf.isSumbitBtn = YES;
        
        // 添加字段
        NSMutableDictionary *mutabDict =  weakSelf.configDataArr[1];
        mutabDict[@"revokeIs"] = @"1";
        [weakSelf.configDataArr replaceObjectAtIndex:1 withObject:mutabDict];
        
        [weakSelf judeContentTextCompleteType:@"1"];
    };
    
    // 存入草稿
    self.toolView.selectSaveDraftBtn = ^{
        //
        weakSelf.isSumbitBtn = NO;

        // 添加字段
        NSMutableDictionary *mutabDict =  weakSelf.configDataArr[1];
        mutabDict[@"revokeIs"] = @"3";
        [weakSelf.configDataArr replaceObjectAtIndex:1 withObject:mutabDict];
        
        [weakSelf judeContentTextCompleteType:@"2"];
    };
}
// promptStr : 1 提交 2 存入草稿  typeStr 1 提交 2 删除按钮
-(void) getWithShowPromptStr:(NSString *)promptStr  andTypeStr:(NSString *)typeStr{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:promptStr preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([typeStr isEqualToString:@"1"]) {
            [weakSelf selectSubmitTureBtn];
        }else if ([typeStr isEqualToString:@"2"]){
            // 删除
            [weakSelf  requestManagemetCenterRevokels];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 判断内容是否编辑完整   typeStr : 1 提交 2 存入草稿
-(void) judeContentTextCompleteType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    if (self.configDataArr.count == 0) {
        return;
    }
    NSDictionary *dict = self.configDataArr[1];
    if (![self getJudgeDataSoucre:dict]) {
        [weakSelf.view showErrorWithTitle:@"请填写完整!" autoCloseTime:0.5];
        return;
    }
    
    if ([typeStr isEqualToString:@"1"]) {
        [weakSelf getWithShowPromptStr:@"您确定提交吗!" andTypeStr:@"1"];
    }else{
        [weakSelf getWithShowPromptStr:@"您确定存入草稿吗!" andTypeStr:@"1"];
    }
}
// 点击确定按钮
-(void) selectSubmitTureBtn{
    __weak typeof(self) weakSelf = self;
   
    // 只能在同一时间点击一次 提交按钮变不可能
    self.toolView.submitBtn.enabled = NO;
    
    if (self.scoureType == showBaseAddSoucreType) {
        // 添加
        //没有附件 直接上传
        if (self.annexDataArr.count == 0) {
            weakSelf.enclosureArr = [NSMutableArray array];
            [weakSelf requestWithSecurityCheckLists];
            return;
        }
        // 加载动画
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.bezelView.color =[UIColor colorWithWhite:0 alpha:0.7];
        self.HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
        
        // 多文件上传
        [[OSSManager sharedManager] uploadfilePathDict:self.annexDataArr isAsync:YES callback:^(BOOL success, NSString * _Nonnull msg, NSError * _Nonnull error) {
            if (success) {
                for (NSDictionary *dict in weakSelf.annexDataArr) {
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    param[@"type"] = dict[@"type"];
                    param[@"objectKey"] = dict[@"objectKey"];
                    param[@"name"] = dict[@"name"];
                    param[@"size"] = dict[@"size"];
                    [weakSelf.enclosureArr addObject:param];
                }
                [weakSelf requestWithSecurityCheckLists];
            }else{
                // 隐藏
                [weakSelf.HUD hideAnimated:YES];
                // 提交按钮变可能
                self.toolView.submitBtn.enabled = YES;
                
                [weakSelf.view showErrorWithTitle:@"文件上传失败!" autoCloseTime:0.5];
                
                return ;
            }
        }];
    }else{
    // 修改
        //没有附件 直接上传
        NSMutableArray *newAnnexArr = [NSMutableArray array];
        for (NSDictionary *dict in self.annexDataArr) {
            if (![[dict allKeys] containsObject:@"url"]) {
                [newAnnexArr addObject:dict];
            }else{
                // 把之前添加的附件传给后台
                [weakSelf.enclosureArr addObject:dict];
            }
        }
        if (newAnnexArr.count == 0) {
            [weakSelf requestWithSecurityCheckLists];
            return;
        }
        // 加载动画
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.bezelView.color =[UIColor colorWithWhite:0 alpha:0.7];
        self.HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
        
        // 多文件上传
        [[OSSManager sharedManager] uploadfilePathDict:newAnnexArr isAsync:YES callback:^(BOOL success, NSString * _Nonnull msg, NSError * _Nonnull error) {
            if (success) {
                for (NSDictionary *dict in newAnnexArr) {
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    param[@"type"] = dict[@"type"];
                    param[@"objectKey"] = dict[@"objectKey"];
                    param[@"name"] = dict[@"name"];
                    param[@"size"] = dict[@"size"];
                    [weakSelf.enclosureArr addObject:param];
                }
                [weakSelf requestWithSecurityCheckLists];
            }else{
                // 隐藏
                [weakSelf.HUD hideAnimated:YES];
                // 提交按钮变可能
                self.toolView.submitBtn.enabled = YES;
                
                [weakSelf.view showErrorWithTitle:@"文件上传失败!" autoCloseTime:0.5];
                return ;
            }
        }];
    }
}
// 判断是否都输入数据
-(BOOL) getJudgeDataSoucre:(NSDictionary *) dict{
    BOOL isData =  NO;
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        //安全检查
        isData = [[dict allKeys] containsObject:@"beingCheckUnitName"];
        isData = [[dict allKeys] containsObject:@"workTicketNumber"];
        isData = [[dict allKeys] containsObject:@"securityCheckAddress"];
        isData = [[dict allKeys] containsObject:@"securityCheckTitle"];
        isData = [[dict allKeys] containsObject:@"securityCheckContent"];
//        isData = [[dict allKeys] containsObject:@"voltageLevels"];
    
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        //班前班后会
        isData = [[dict allKeys] containsObject:@"workTicketNumber"];
        isData = [[dict allKeys] containsObject:@"classRecordAddress"];
        isData = [[dict allKeys] containsObject:@"classRecordTitle"];
//        isData = [[dict allKeys] containsObject:@"classRecordContent"];
        
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        //违章处理
        isData = [[dict allKeys] containsObject:@"violationUserInfo"];
        isData = [[dict allKeys] containsObject:@"violationUnitName"];
        isData = [[dict allKeys] containsObject:@"violationHanTitle"];
        isData = [[dict allKeys] containsObject:@"violationHanContent"];
        isData = [[dict allKeys] containsObject:@"levels"];
        
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        //技术交底
        isData = [[dict allKeys] containsObject:@"workTicketNumber"];
        isData = [[dict allKeys] containsObject:@"technicalDisclosureAddress"];
        isData = [[dict allKeys] containsObject:@"technicalDisclosureTitle"];
        isData = [[dict allKeys] containsObject:@"technicalDisclosureContent"];
    }
    return isData;
}
// 组装数据源
-(NSMutableArray *) createAssemblyDataDict:(NSDictionary *)alterDict{
    NSMutableArray *dataArr = [NSMutableArray array];
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        // 安全检查
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = alterDict[@"realName"];
        userDict[@"userId"] = alterDict[@"userId"];
        userDict[@"platformId"] = alterDict[@"platformId"];
        userDict[@"unitId"] = alterDict[@"unitId"];
        userDict[@"type"] = alterDict[@"type"];
        userDict[@"unitName"] = alterDict[@"unitName"];
        userDict[@"time"] = [YWTTools timestampSwitchTime:[YWTTools getNowTimestamp] andFormatter:@"YYYY.MM.dd HH:mm"];
        userDict[@"id"] = alterDict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"beingCheckUnitName"] = alterDict[@"beingCheckUnitName"];
        contentDict[@"securityCheckAddress"] = alterDict[@"securityCheckAddress"];
        contentDict[@"voltageLevels"] = alterDict[@"voltageLevels"];
        contentDict[@"workTicketNumber"] = alterDict[@"workTicketNumber"];
        contentDict[@"securityCheckTitle"] = alterDict[@"securityCheckTitle"];
        contentDict[@"securityCheckContent"] = alterDict[@"securityCheckContent"];
        [dataArr addObject:contentDict];
        
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        // 会议
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = alterDict[@"realName"];
        userDict[@"userId"] = alterDict[@"userId"];
        userDict[@"unitId"] = alterDict[@"unitId"];
        userDict[@"type"] = alterDict[@"type"];
        userDict[@"unitName"] = alterDict[@"unitName"];
        userDict[@"platformId"] = alterDict[@"platformId"];
        userDict[@"id"] = alterDict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"workTicketNumber"] = alterDict[@"workTicketNumber"];
        contentDict[@"classRecordAddress"] = alterDict[@"classRecordAddress"];
        contentDict[@"classRecordTitle"] = alterDict[@"classRecordTitle"];
        contentDict[@"classRecordContent"] = alterDict[@"classRecordContent"];
        [dataArr addObject:contentDict];
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        // 违章
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] =alterDict[@"realName"];
        userDict[@"userId"] = alterDict[@"userId"];
        userDict[@"unitId"] = alterDict[@"unitId"];
        userDict[@"type"] = alterDict[@"type"];
        userDict[@"unitName"] = alterDict[@"unitName"];
        userDict[@"platformId"] = alterDict[@"platformId"];
        userDict[@"id"] = alterDict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"violationUserInfo"] = alterDict[@"violationUserInfo"];
        contentDict[@"violationUnitName"] = alterDict[@"violationUnitName"];
        contentDict[@"levels"] = alterDict[@"levels"];
        contentDict[@"violationHanTitle"] = alterDict[@"violationHanTitle"];
        contentDict[@"violationHanContent"] = alterDict[@"violationHanContent"];
        [dataArr addObject:contentDict];
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        // 技术
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = alterDict[@"realName"];
        userDict[@"userId"] = alterDict[@"userId"];
        userDict[@"unitId"] = alterDict[@"unitId"];
        userDict[@"type"] = alterDict[@"type"];
        userDict[@"unitName"] = alterDict[@"unitName"];
        userDict[@"platformId"] = alterDict[@"platformId"];
        userDict[@"id"] = alterDict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"technicalDisclosureAddress"] = alterDict[@"technicalDisclosureAddress"];
        contentDict[@"workTicketNumber"] = alterDict[@"workTicketNumber"];
        contentDict[@"technicalDisclosureTitle"] = alterDict[@"technicalDisclosureTitle"];
        contentDict[@"technicalDisclosureContent"] = alterDict[@"technicalDisclosureContent"];
        [dataArr addObject:contentDict];
    }
    [dataArr addObject:alterDict[@"enclosure"]];
    return dataArr;
}
#pragma mark --- get  --------
-(YWTBaseBottomToolView *)toolView{
    if (!_toolView) {
       _toolView = [[YWTBaseBottomToolView alloc]initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-KSIphonScreenH(70), KScreenW, KSIphonScreenH(70))];
        if (self.saveDataType == showBaseSaveDataSubmitType ) {
            // 更新提交按钮
           [_toolView updateSubmitBtnUI];
        }
    }
    return  _toolView;
}
-(NSMutableArray *)enclosureArr{
    if (!_enclosureArr) {
        _enclosureArr = [NSMutableArray array];
    }
    return _enclosureArr;
}
-(NSMutableArray *)annexDataArr{
    if (!_annexDataArr) {
        _annexDataArr = [NSMutableArray array];
    }
    return _annexDataArr;
}
-(NSMutableArray *)configDataArr{
    if (!_configDataArr) {
        _configDataArr = [NSMutableArray array];
    }
    return _configDataArr;
}
-(NSMutableArray *)settingArr{
    if (!_settingArr) {
        _settingArr = [NSMutableArray array];
    }
    return _settingArr;
}
-(void)setVeiwBaseType:(showViewControllerType)veiwBaseType{
    _veiwBaseType = veiwBaseType;
}
-(void)setScoureType:(showBaseSoucreType)scoureType{
    _scoureType = scoureType;
}
-(void)setSaveDataType:(showBaseSaveDataType)saveDataType{
    _saveDataType = saveDataType;
}
-(void)setEditIdStr:(NSString *)editIdStr{
    _editIdStr = editIdStr;
//    [self requestWithCheckInfos];
}
-(void)setAlterDataArr:(NSMutableArray *)alterDataArr{
    _alterDataArr = alterDataArr;
    [self.configDataArr addObjectsFromArray:alterDataArr.copy];
    self.annexDataArr = [NSMutableArray arrayWithArray:alterDataArr[2]];
    [self.BaseTableView reloadData];
}
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark ---全检查添加-------
-(void) requestWithSecurityCheckLists{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    if (self.scoureType == showBaseAddSoucreType) {
        param[@"doType"] = @"1";
        // 只有添加提交的时候 才能触发任务
        if (self.isSumbitBtn) {
            param[@"taskid"] = self.taskIdStr;
        }
    }else{
        param[@"doType"] = @"2";
    }
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict addEntriesFromDictionary:self.configDataArr[0]];
    [dataDict addEntriesFromDictionary:self.configDataArr[1]];
    dataDict[@"enclosure"] = self.enclosureArr;
    param[@"data"] = [YWTTools convertToJsonData:dataDict];
    
    NSString *url;
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        //安全检查
        url = HTTP_ATTAPPCHANGSECURITYCHECKLISTS_URL;
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        //班前班后会
        url = HTTP_ATTAPPCHANGECLASSRECORDLISTS_URL;
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        //违章处理
        url = HTTP_ATTAPPCHANFWCIOLARIONHANLISTS_URL;
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        //技术交底
        url =  HTTP_ATTAPPCHANGETECHNICALDISCLOSURELISTS_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 隐藏
        [self.HUD hideAnimated:YES];
        // 提交按钮可用
        self.toolView.submitBtn.enabled = YES;
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 提交情况
            if (self.isSumbitBtn) {
                YWTBaseDetailController *detaVC = [[YWTBaseDetailController alloc]init];
                detaVC.toolType = showBaseToolNormalType;
                if (self.veiwBaseType ==  showViewControllerSafetyType) {
                    //安全检查
                    detaVC.detailType = showBaseDetailSafetyType;
                }else if (self.veiwBaseType ==  showViewControllerMeetingType){
                    //班前班后会
                    detaVC.detailType = showBaseDetailMeetingType;
                }else if (self.veiwBaseType ==  showViewControllerViolationType){
                    //违章处理
                    detaVC.detailType = showBaseDetailViolationType;
                }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
                    //技术交底
                    detaVC.detailType = showBaseDetailTechnoloType;
                }
                detaVC.idStr = [NSString stringWithFormat:@"%@",showdata[@"id"]];
                
                [self.navigationController  pushViewController:detaVC animated:YES];
                
                return;
            }
            
            // 存入草稿
            YWTBaseRecordController *baseRecordVC = [[YWTBaseRecordController alloc]init];
            if (self.veiwBaseType ==  showViewControllerSafetyType) {
                //安全检查
                baseRecordVC.recordType = showBaseRecordSafetyType;
            }else if (self.veiwBaseType ==  showViewControllerMeetingType){
                //班前班后会
                baseRecordVC.recordType = showBaseRecordMeetingType;
            }else if (self.veiwBaseType ==  showViewControllerViolationType){
                //违章处理
                baseRecordVC.recordType = showBaseRecordViolationType;
            }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
                //技术交底
                baseRecordVC.recordType = showBaseRecordTechnoloType;
            }
            [self.navigationController  pushViewController:baseRecordVC animated:YES];
        }
    }];
}
#pragma mark ---全检查的配置数组--------
-(void) requestCheckSetting{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        //安全检查
        param[@"type"] = @"1";
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        //班前班后会
        param[@"type"] = @"2";
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        //违章处理
        param[@"type"] = @"4";
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        //技术交底
        param[@"type"] = @"3";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSECURITYCHECKSETTING_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            // 添加
            if (self.scoureType == showBaseAddSoucreType) {
                NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
                if (self.veiwBaseType ==  showViewControllerSafetyType) {
                    //安全检查
                    userDict[@"realName"] = showdata[@"realName"];
                    userDict[@"userId"] = showdata[@"userId"];
                    userDict[@"platformId"] = showdata[@"platformId"];
                    userDict[@"unitId"] = showdata[@"unitId"];
                    userDict[@"type"] = showdata[@"type"];
                    userDict[@"unitName"] = showdata[@"unitName"];
                    userDict[@"time"] = [YWTTools timestampSwitchTime:[YWTTools getNowTimestamp] andFormatter:@"YYYY.MM.dd HH:mm"];
                }else if (self.veiwBaseType ==  showViewControllerMeetingType || self.veiwBaseType ==  showViewControllerTechnoloType ||  self.veiwBaseType ==  showViewControllerViolationType){
                    //班前班后会
                    userDict[@"realName"] = showdata[@"realName"];
                    userDict[@"userId"] = showdata[@"userId"];
                    userDict[@"platformId"] = showdata[@"platformId"];
                    userDict[@"unitId"] = showdata[@"unitId"];
                    userDict[@"type"] = showdata[@"type"];
                    userDict[@"unitName"] = showdata[@"unitName"];
                }
                [self.configDataArr addObject:userDict];
                
                NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
                [self.configDataArr addObject:contentDict];
                
                [self.configDataArr addObject:self.annexDataArr];
            }
            if (self.veiwBaseType ==  showViewControllerSafetyType) {
                // 安全检查   电压等级
                NSArray *arr = (NSArray *)showdata[@"list"];
                [self.settingArr addObjectsFromArray:arr];
            }
            // 记录文件大小
            self.uploadSize = [NSString stringWithFormat:@"%@",showdata[@"uploadSize"]];
            // 记录 必录描述文字
            self.infoRemorkStr = [NSString stringWithFormat:@"%@",showdata[@"infoRemork"]];
            
            [self.BaseTableView reloadData];
        }
    }];
}

#pragma mark ------获取阿里云OSS配置参数 ---------
-(void) requestUploadOSSConfig{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPUPLOADOSSSINGNCONFIG_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 赋值
            [OSSManager sharedManager].oSSDataDict = showdata;
            
            // 创建单列模型
            [OSSAuthModel shareInstance].AccessKeyId =[NSString stringWithFormat:@"%@",showdata[@"AccessKeyId"]];
            [OSSAuthModel shareInstance].AccessKeySecret =[NSString stringWithFormat:@"%@",showdata[@"AccessKeySecret"]];
            [OSSAuthModel shareInstance].SecurityToken =[NSString stringWithFormat:@"%@",showdata[@"SecurityToken"]];
            [OSSAuthModel shareInstance].endpoint =[NSString stringWithFormat:@"http://%@",showdata[@"endpoint"]];
            [OSSAuthModel shareInstance].Expiration =[NSString stringWithFormat:@"%@",showdata[@"Expiration"]];
            [OSSAuthModel shareInstance].bucket =[NSString stringWithFormat:@"%@",showdata[@"bucket"]];
        }
    }];
}
#pragma mark ---存入草稿 编辑中 请求详情页面 ------
-(void)requestWithCheckInfos{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    NSString *url ;
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        //安全检查
        //安全检查详情
        param[@"checkId"] = self.editIdStr;
        url = HTTP_ATTAPPSECURITYCHECKINFOS_URL;
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        //班前班后会
        param[@"classId"] = self.editIdStr;
        url = HTTP_ATTAPPCLASSRECORDINFOS_URL;
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        //违章处理
        param[@"classId"] = self.editIdStr;
        url = HTTP_ATTAPPVIOLATIONHANINFOS_URL;
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        //技术交底
        param[@"classId"] = self.editIdStr;
        url = HTTP_ATTAPPTECHNICALDISCLOSUREINFOS_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *editArr = [self createAssemblyDataDict:showdata];
            
            [self.configDataArr addObjectsFromArray:editArr.copy];
            
            self.annexDataArr = [NSMutableArray arrayWithArray:editArr[2]];
            
            [self.BaseTableView reloadData];
        }
    }];
}
#pragma mark -------- 撤销 ------
-(void) requestManagemetCenterRevokels{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    NSDictionary *dict = self.configDataArr[0];
    param[@"id"] = [NSString stringWithFormat:@"%@",dict[@"id"]];
    param[@"revokeIs"] = @"3";
    if (self.veiwBaseType ==  showViewControllerSafetyType) {
        param[@"type"] = @"1";
    }else if (self.veiwBaseType ==  showViewControllerMeetingType){
        param[@"type"] = @"2";
    }else if (self.veiwBaseType ==  showViewControllerViolationType){
        param[@"type"] = @"4";
    }else if (self.veiwBaseType ==  showViewControllerTechnoloType){
        param[@"type"] = @"3";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSAFETYMANAGEMETCENTERREVOKEIS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        // 跳转到记录页面
        [self pushBaseRecordController];
    }];
}








@end
