//
//  YWTPartyMemberAreaAddController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/6.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTPartyMemberAreaAddController.h"

#import "TZImagePickerController.h"
#import "YWTAreaPlayVideoController.h"
#import "YWTPartyMemberAreaDetailController.h"

#import "YWTOSSManager.h"
#import "OSSAuthModel.h"

#import "YWTAddModel.h"
#import "YWTShowBackPromptView.h"
#import "YWTShowSendUnContainView.h"

#import "YWTBaseAreaHeaderView.h"
#define YWTBASEARAHEADER_VIEW @"YWTBaseAreaHeaderView"
#import "YWTParyMemberAreaAddPhotoCell.h"
#define YWTPARYMEMBERAREAADDPHOTO_CELL @"YWTParyMemberAreaAddPhotoCell"


@interface YWTPartyMemberAreaAddController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
TZImagePickerControllerDelegate
>
// 返回提示框
@property (nonatomic,strong) YWTShowBackPromptView *showBackPromptView;

@property (nonatomic,strong) YWTBaseAreaHeaderView *headerView;

@property (nonatomic,strong) MBProgressHUD *HUD;

@property (nonatomic,strong) UICollectionView *addCollectionView;

@property (nonatomic,strong) NSMutableArray *imageArr;

@end

@implementation YWTPartyMemberAreaAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    // 设置导航栏
    [self setNavi];
    //
    [self.view addSubview:self.addCollectionView];
    // 请求OSS配置
    [self requestUploadOSSConfig];
}
#pragma mark --- UICollectionViewDataSource --------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.imageArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.imageArr[section];
    if (self.areaType == partyAreaPhotoType ) {
        if (arr.count >= 10) {
            return 9;
        }
    }else{
        if (arr.count >= 2) {
            return 1;
        }
    }
    return arr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YWTParyMemberAreaAddPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YWTPARYMEMBERAREAADDPHOTO_CELL forIndexPath:indexPath];
    NSArray *arr = self.imageArr[indexPath.section];
    YWTAddModel *model = arr[indexPath.row];
    cell.photoImage =model.photoImege;
    if (arr.count-1 == indexPath.row) {
        cell.isShowDel = NO;
    }else{
        cell.isShowDel = YES;
    }
    WS(weakSelf);
    cell.selectDelImage = ^{
        // 取出数据源
        NSMutableArray *photoArr = weakSelf.imageArr[indexPath.section];
        //移除删除数据源
        [photoArr removeObjectAtIndex:indexPath.row];
        // 贴换数据源
        [weakSelf.imageArr replaceObjectAtIndex:indexPath.section withObject:photoArr];
        // 刷新UI
        [weakSelf.addCollectionView reloadData];
    };
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.areaType == partyAreaPhotoType ) {
        return CGSizeMake((KScreenW-24-12)/3, 113);
    }else{
        return CGSizeMake(KScreenW-24, 190);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.imageArr[indexPath.section];
    if (indexPath.row != arr.count -1) {
        // 预览
        if (self.areaType == partyAreaPhotoType ) {
            // 图片
            NSMutableArray *items = [NSMutableArray array];
            for (int i=0; i<arr.count-1; i++) {
                YWTAddModel *model = arr[i];
                UIImageView *imageView = [[UIImageView alloc]init];
                KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView image:model.photoImege];
                [items addObject:item];
            }
            KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:indexPath.row];
            [browser showFromViewController:self];
        }else{
            // 视频
            [self createPlayVideoIndex:indexPath];
        }
        return;
    }
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
    imagePickerVC.iconThemeColor = [UIColor colorLineCommonBlueColor];
    imagePickerVC.showPhotoCannotSelectLayer = YES;
    if (self.areaType == partyAreaPhotoType ) {
        imagePickerVC.allowPickingVideo = NO;
        // 是否允许显示图片
        imagePickerVC.allowPickingImage = YES;
    }else{
        imagePickerVC.allowPickingVideo = YES;
        // 是否允许显示图片
        imagePickerVC.allowPickingImage = NO;
    }
    imagePickerVC.barItemTextColor = [UIColor colorLineCommonBlueColor];
    imagePickerVC.naviBgColor = [UIColor colorTextWhiteColor];
    imagePickerVC.oKButtonTitleColorNormal = [UIColor colorLineCommonBlueColor];
    imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:YWTBASEARAHEADER_VIEW forIndexPath:indexPath];
        return self.headerView;
    }else{
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER" forIndexPath:indexPath];
        return footView;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 140);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 0.01);
}
#pragma mark --- 创建图片多选 --------
-(void) createImagePickerPhoto{
    
}
#pragma mark --- TZImagePickerControllerDelegate --------
// 多图选择
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    // 取出数据源
    NSMutableArray *addPhotoArr = self.imageArr[0];
    // 计算超出最多图片数
    if (photos.count+addPhotoArr.count > 10) {
        //
        [self.view showErrorWithTitle:@"已超出最多图片数" autoCloseTime:0.5];
        return;
    }
    // 添加照片
    for (int i=0; i<photos.count; i++) {
        YWTAddModel *model =[[ YWTAddModel alloc]init];
        // 取出照片
        UIImage *imagePhoto = photos[i];
        // 转换成文件流
        NSData *filePath = UIImageJPEGRepresentation(imagePhoto, 0.5);
        // 获取文件名称
        PHAsset *asset = assets[i];
        NSString *imageNameStr = [asset valueForKey:@"filename"];
        model.typeName  = imageNameStr;
        model.photoImege = imagePhoto;
        model.fileData = filePath;
        model.fileName = imageNameStr;
        model.type = @"images";
        NSString *fileName = [NSString  stringWithFormat:@"images/%@",imageNameStr];
        model.objectKey = fileName;
        [addPhotoArr insertObject:model atIndex:0];
    }
    // 贴换数据源
    [self.imageArr replaceObjectAtIndex:0 withObject:addPhotoArr];
    // 刷新UI
    [self.addCollectionView reloadData];
}
// 选择视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{
    // 取出数据源
    NSMutableArray *addPhotoArr = self.imageArr[0];
    YWTAddModel *model =[[ YWTAddModel alloc]init];
    model.photoImege = coverImage;
    // 获取文件名称
    NSString *imageNameStr = [asset valueForKey:@"filename"];
    model.fileName = imageNameStr;
    model.typeName  = imageNameStr;
    NSString *fileName = [NSString  stringWithFormat:@"video/%@",imageNameStr];
    model.objectKey = fileName;
    model.type = @"video";
    WS(weakSelf);
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
         AVURLAsset *urlAsset = (AVURLAsset *)asset;
        // 视频数据
        NSData *vedioData = [NSData dataWithContentsOfURL:urlAsset.URL];
        model.fileData = vedioData;
        model.urlStr = [urlAsset.URL  absoluteString];
        // 添加数据
        [addPhotoArr insertObject:model atIndex:0];
        // 贴换数据源
        [weakSelf.imageArr replaceObjectAtIndex:0 withObject:addPhotoArr];
        // 刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf.addCollectionView reloadData];
        });
    }];
}
#pragma mark ---  图片多选返回 ---------
-(void)selectBackBtn:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- ---- 播放视频 ------
-(void) createPlayVideoIndex:(NSIndexPath*)indexPath{
    NSArray *arr = self.imageArr[indexPath.section];
    YWTAreaPlayVideoController *playVC = [[YWTAreaPlayVideoController alloc]init];
    YWTAddModel *model = arr[indexPath.row];
    playVC.addModel = model;
    [self.navigationController pushViewController:playVC animated:YES];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"发文章";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        //取消第一响应者
        [weakSelf.headerView.fsTextView resignFirstResponder];
        // 没有内容 直接返回
        NSMutableArray *mutableArr = weakSelf.imageArr[0];
        if (weakSelf.headerView.fsTextView.text.length == 0 || mutableArr.count == 1) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return ;
        }
        // 有内容
        [weakSelf.view addSubview:weakSelf.showBackPromptView];
        __weak typeof(self) strongSelf = weakSelf;
        weakSelf.showBackPromptView.selectBackBtn = ^{
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
    };
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton setTitle:@"发送" forState:UIControlStateNormal];
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW-90, KSStatusHeight+7, 80, 30);
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    [self.customNavBar.rightButton setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[[UIColor colorLineCommonBlueColor]colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
    [self.customNavBar.rightButton setBackgroundImage:[YWTTools imageWithColor:[UIColor colorTextWhiteColor]] forState:UIControlStateNormal];
    [self.customNavBar.rightButton setBackgroundImage:[YWTTools imageWithColor:[[UIColor colorTextWhiteColor]colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
    self.customNavBar.rightButton.layer.cornerRadius = 30/2;
    self.customNavBar.rightButton.layer.masksToBounds = YES;
    self.customNavBar.onClickRightButton = ^{
        [weakSelf selectSubmitTureBtn];
    };
}
#pragma mark --- 清除数据 --------
-(void) pushSuccesClearData{
    //取消第一响应者
    [self.headerView.fsTextView resignFirstResponder];
    self.headerView.fsTextView.text = @"";
    NSMutableArray *mutableArr = self.imageArr[0];
    NSMutableArray *iconArr =[NSMutableArray array];
    [iconArr addObject:[mutableArr lastObject]];
    [self.imageArr replaceObjectAtIndex:0 withObject:iconArr];
    [self.addCollectionView reloadData];
}
#pragma mark ------  上传OSS  -------
-(void) selectSubmitTureBtn{
    //取消第一响应者
    [self.headerView.fsTextView resignFirstResponder];
    
    NSMutableArray  *mutableArr  = [NSMutableArray arrayWithArray:self.imageArr[0]];
    // 判断
    if (self.headerView.fsTextView.text.length == 0) {
        [self.view showErrorWithTitle:@"请填写完整！" autoCloseTime:0.5];
        return;
    }
    self.customNavBar.rightButton.enabled = NO;
    // 接收文件数组
    NSMutableArray *enclosureArr = [NSMutableArray array];
    //没有附件 直接上传
    if (mutableArr.count == 1) {
        [self requestReleaseSubmitLoadAnnexArr:enclosureArr.copy];
        return;
    }
    // 加载动画
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.bezelView.color =[UIColor colorWithWhite:0 alpha:0.7];
    self.HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
    WS(weakSelf);
    // 多文件上传
    [[YWTOSSManager sharedManager] uploadfilePathDict:mutableArr isAsync:YES callback:^(BOOL success, NSString * _Nonnull msg, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.customNavBar.rightButton.enabled = YES;
        });
        if (success) {
            for (int i=0; i< mutableArr.count-1; i++) {
                YWTAddModel *model = mutableArr[i];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                param[@"type"] = model.type;
                param[@"objectKey"] = model.objectKey;
                param[@"name"] = model.fileName;
                param[@"size"] = [NSNumber numberWithInteger:model.fileData.length];
                [enclosureArr addObject:param];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
               [self requestReleaseSubmitLoadAnnexArr:enclosureArr.copy];
            });
        }else{
            [weakSelf.HUD hideAnimated:YES];
            [weakSelf.view showErrorWithTitle:@"文件上传失败!" autoCloseTime:0.5];
            return ;
        }
    }];
}

#pragma mark -  ----- get 方法  -------
-(UICollectionView *)addCollectionView{
    if (!_addCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 6;
        layout.minimumInteritemSpacing = 6;
        layout.sectionInset = UIEdgeInsetsMake(6, 12, 6, 12);
        
        _addCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH) collectionViewLayout:layout];
        _addCollectionView.dataSource = self;
        _addCollectionView.delegate = self;
        _addCollectionView.backgroundColor = [UIColor colorTextWhiteColor];
        [_addCollectionView registerClass:[YWTParyMemberAreaAddPhotoCell class] forCellWithReuseIdentifier:YWTPARYMEMBERAREAADDPHOTO_CELL];
        [_addCollectionView registerClass:[YWTBaseAreaHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:YWTBASEARAHEADER_VIEW];
        [_addCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER"];
    }
    return _addCollectionView;
}
-(YWTShowBackPromptView *)showBackPromptView{
    if (!_showBackPromptView) {
        _showBackPromptView = [[YWTShowBackPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showBackPromptView;
}

-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
        NSMutableArray *arr = [NSMutableArray array];
        YWTAddModel *model = [[YWTAddModel alloc]init];
        if (self.areaType == partyAreaPhotoType ) {
            model.photoImege = [UIImage imageNamed:@"patry_add_photo_normal"];
        }else{
            model.photoImege = [UIImage imageNamed:@"patry_add_video_normal"];
        }
        [arr addObject:model];
        [_imageArr addObject:arr];
    }
    return _imageArr;
}
-(void)setAreaType:(partyAreaType)areaType{
    _areaType = areaType;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma  mark ---  数据相关 ------
-(void) requestReleaseSubmitLoadAnnexArr:(NSArray*)annexArr{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"content"] = self.headerView.fsTextView.text;
    NSString *typesStr = @"2";
    if (self.areaType == partyAreaPhotoType) {
        // 文章加图片
        typesStr = @"2";
    }else{
        typesStr = @"3";
    }
    param[@"types"] = typesStr;
    param[@"file"] = [YWTTools convertToJsonData:annexArr];
    param[@"taskid"] = self.taskIdStr;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTSERICEAPICOMMUNITYRELEASESUBMIT_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 隐藏
        [self.HUD hideAnimated:YES];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
//        NSString *idStr = [NSString stringWithFormat:@"%@",showdata[@"id"]];
//        YWTPartyMemberAreaDetailController *detailVC = [[YWTPartyMemberAreaDetailController alloc]init];
//        detailVC.idStr = idStr;
//        detailVC.detailType = partyAreaDetailOtherType;
//        [self.navigationController pushViewController:detailVC animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        // 删除数据源
        [self pushSuccesClearData];
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
            [YWTOSSManager sharedManager].oSSDataDict = showdata;
            
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




@end
