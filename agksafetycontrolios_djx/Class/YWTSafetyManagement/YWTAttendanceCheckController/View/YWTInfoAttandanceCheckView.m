//
//  InfoAttandanceCheckView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTInfoAttandanceCheckView.h"

#import "YWTAttendanceChenkCell.h"
#define ATTENDANCECHENK_CELL @"YWTAttendanceChenkCell"

#import "YWTAttendanceCheckHeaderView.h"
#define ATTENDANCECHECKHEADERVIEW @"YWTAttendanceCheckHeaderView"

#import "YWTAttendanceCheckFooterView.h"
#define ATTENDANCECHECKFOOTERVIEW @"YWTAttendanceCheckFooterView"

@interface YWTInfoAttandanceCheckView ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic,strong) UICollectionView *checkCollecView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) YWTAttendanceCheckHeaderView *headerView;

@end

@implementation YWTInfoAttandanceCheckView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAttendanceView];
    }
    return self;
}
-(void) createAttendanceView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bigTag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigTap)];
    [bigBgView addGestureRecognizer:bigTag];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(40));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(40));
        make.height.equalTo(@(KSIphonScreenH(330)));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(2, 10, 5, 0);
 
    self.checkCollecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [bgView addSubview:self.checkCollecView];
    self.checkCollecView.delegate = self;
    self.checkCollecView.dataSource = self;
    self.checkCollecView.pagingEnabled = NO;
    self.checkCollecView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.checkCollecView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    [self.checkCollecView registerClass:[YWTAttendanceChenkCell class] forCellWithReuseIdentifier:ATTENDANCECHENK_CELL];
    [self.checkCollecView registerClass:[YWTAttendanceCheckHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ATTENDANCECHECKHEADERVIEW];
    [self.checkCollecView registerClass:[YWTAttendanceCheckFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ATTENDANCECHECKFOOTERVIEW];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    if (arr.count < 4) {
        return arr.count;
    }else{
        return 3;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YWTAttendanceChenkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ATTENDANCECHENK_CELL forIndexPath:indexPath];
    NSArray *arr = self.dataArr[indexPath.section];
    if (arr.count-1 == indexPath.row) {
        cell.delBtn.hidden = YES;
    }else{
        cell.delBtn.hidden = NO;
    }
    // 赋值
    cell.photoImage = arr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    // 点击删除
    cell.selectDelBtn = ^{
        NSMutableArray *normalArr = self.dataArr[indexPath.section];
        [normalArr removeObjectAtIndex:indexPath.row];
        // 贴换数据源
        [weakSelf.dataArr replaceObjectAtIndex:indexPath.section withObject:normalArr];
        // 刷新UI
        [weakSelf.checkCollecView reloadData];
    };
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.dataArr[indexPath.section];
    if (arr.count == 1) {
        // 添加图片
        self.openLibary();
    }else{
        if (arr.count-1 == indexPath.row) {
            if (arr.count == 4) {
                // 查看图片
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[@"indexPath"] = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
                dict[@"imageArr"] = arr;
                self.selectBigPhoto(dict.copy);
            }else{
                // 添加图片
                self.openLibary();
            }
        }else{
            // 查看图片
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"indexPath"] = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            dict[@"imageArr"] = arr;
            self.selectBigPhoto(dict.copy);
        }
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 60);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, KSIphonScreenH(216));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, KSIphonScreenH(50));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ATTENDANCECHECKHEADERVIEW forIndexPath:indexPath];
        self.headerView.addressStr = self.addressStr;
        __weak typeof(self) weakSelf = self;
        self.headerView.selectAgainVerif = ^{
            weakSelf.selectAgainVierf();
        };
        return self.headerView;
    }else{
        YWTAttendanceCheckFooterView *FootView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ATTENDANCECHECKFOOTERVIEW forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        // 取消
        FootView.cancelBtn = ^{
             // 移除键盘
            [weakSelf.headerView.fsTextView resignFirstResponder];
            [weakSelf removeFromSuperview];
        };
        // 确认签到
        FootView.submitCheckBtn = ^{
            // 移除键盘
            [weakSelf.headerView.fsTextView resignFirstResponder];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"noteStr"] = weakSelf.headerView.fsTextView.text;
            // 取出第一组
            NSMutableArray *imageArr = weakSelf.dataArr[0];
            // 移除最后一个
            [imageArr removeLastObject];
            param[@"markImageArr"] = imageArr;
            weakSelf.selectTureAttendance(param.copy);
            // 移除视图
            [weakSelf removeFromSuperview];
        };
        return FootView;
    }
}
// 移除view
-(void)selectBigTap{
    // 取消键盘第一效应
    [self.headerView.fsTextView resignFirstResponder];
//     [self removeFromSuperview];
}
#pragma mark ---- get 方法 -------
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        // 默认添加一个元素
        NSMutableArray *normalArr = [NSMutableArray array];
        [normalArr addObject:[UIImage imageNamed:@"base_attendance_add"]];
        [_dataArr addObject:normalArr];
    }
    return _dataArr;
}
-(void)setLibaryImage:(UIImage *)libaryImage{
    _libaryImage = libaryImage;
    NSMutableArray *normalArr = self.dataArr[0];
    [normalArr insertObject:libaryImage atIndex:0];
    // 贴换数据源
    [self.dataArr replaceObjectAtIndex:0 withObject:normalArr];
    // 刷新UI
    [self.checkCollecView reloadData];
}
-(void)setFaceVerifStr:(NSString *)faceVerifStr{
    _faceVerifStr = faceVerifStr;
    
    NSString *faceStr = [NSString stringWithFormat:@"身份验证： %@",faceVerifStr];
    if ([faceVerifStr isEqualToString:@"未通过"]) {
        self.headerView.faceVerifRultLab.attributedText = [YWTTools getAttrbuteTotalStr:faceStr andAlterTextStr:faceVerifStr andTextColor:[UIColor colorCommonRedColor] andTextFont:Font(12)];
    }else{
         self.headerView.faceVerifRultLab.attributedText = [YWTTools getAttrbuteTotalStr:faceStr andAlterTextStr:faceVerifStr andTextColor:[UIColor colorLineCommonBlueColor] andTextFont:Font(12)];
    }
}

-(void)setAddressStr:(NSString *)addressStr{
    _addressStr = addressStr;
}

@end
