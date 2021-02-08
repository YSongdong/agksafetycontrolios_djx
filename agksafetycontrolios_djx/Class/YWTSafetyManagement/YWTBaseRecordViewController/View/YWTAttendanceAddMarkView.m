//
//  AttendanceAddMarkView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceAddMarkView.h"

#import "YWTAttendanceChenkCell.h"
#define ATTENDANCECHENK_CELL @"AttendanceChenkCell"

#import "YWTAttendanceAddMarkHeaderView.h"
#define ATTENDANCEADDMARKHEADERVIEW  @"AttendanceAddMarkHeaderView"

#import "YWTAttendanceAddMarkFooterView.h"
#define ATTENDANCEADDMARKFOOTERVIEW  @"AttendanceAddMarkFooterView"

@interface YWTAttendanceAddMarkView ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong) UICollectionView *markCollectionView;
// 头部视图
@property (nonatomic,strong) YWTAttendanceAddMarkHeaderView *headerView;
// 尾部视图
@property (nonatomic,strong) YWTAttendanceAddMarkFooterView *footerView;

@property (nonatomic,strong)  UIView *bgView;

@end

@implementation YWTAttendanceAddMarkView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAddMarkView];
    }
    return self;
}
-(void) createAddMarkView{
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
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(40));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(40));
        make.height.equalTo(@(KSIphonScreenH(228)));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(2, 10, 5, 0);
    
    self.markCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.bgView addSubview:self.markCollectionView];
    self.markCollectionView.delegate = self;
    self.markCollectionView.dataSource = self;
    self.markCollectionView.pagingEnabled = NO;
    self.markCollectionView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.markCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.bgView);
    }];
    [self.markCollectionView registerClass:[YWTAttendanceChenkCell class] forCellWithReuseIdentifier:ATTENDANCECHENK_CELL];
    [self.markCollectionView registerClass:[YWTAttendanceAddMarkHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ATTENDANCEADDMARKHEADERVIEW];
    [self.markCollectionView registerClass:[YWTAttendanceAddMarkFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ATTENDANCEADDMARKFOOTERVIEW];
    
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
    if (self.markType == showAttendanceAddMarkType ) {
        cell.photoImage = arr[indexPath.row];
    }else{
        cell.photoImageStr = arr[indexPath.row];
    }
    __weak typeof(self) weakSelf = self;
    // 点击删除
    cell.selectDelBtn = ^{
        NSMutableArray *normalArr = self.dataArr[indexPath.section];
        [normalArr removeObjectAtIndex:indexPath.row];
        // 贴换数据源
        [weakSelf.dataArr replaceObjectAtIndex:indexPath.section withObject:normalArr];
        // 刷新UI
        [weakSelf.markCollectionView reloadData];
    };
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KSIphonScreenW(50), KSIphonScreenH(50));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, KSIphonScreenH(123));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, KSIphonScreenH(50));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ATTENDANCEADDMARKHEADERVIEW forIndexPath:indexPath];
        
        if (self.markType == showAttendanceAddMarkType) {
            self.headerView.markTitleLab.text = @"打卡备注";
        }else{
            self.headerView.markTitleLab.text = @"查看备注";
            self.headerView.fsTextView.placeholder = @" ";
            self.headerView.fsTextView.text = self.markConterStr;
            self.headerView.fsTextView.editable = NO;
        }
        return self.headerView;
    }else{
        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ATTENDANCEADDMARKFOOTERVIEW forIndexPath:indexPath];
        if (self.markType == showAttendanceAddMarkType) {
            [self.footerView.submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
        }else{
            [self.footerView.submitBtn setTitle:@"关闭" forState:UIControlStateNormal];
        }
        __weak typeof(self) weakSelf = self;
        // 提交
        self.footerView.selectSubmitBnt = ^{
            if (weakSelf.markType == showAttendanceLookMarkType) {
                // 查看
                weakSelf.selectCancelBtn([NSDictionary dictionary]);
                return ;
            }
            // 添加
            if (weakSelf.headerView.fsTextView.text.length == 0) {
                [weakSelf showErrorWithTitle:@"请填写备注信息" autoCloseTime:0.5];
                return ;
            }
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            // 转编码
            NSString * markNoteStr = [weakSelf.headerView.fsTextView.text stringByRemovingPercentEncoding];
            dict[@"markNote"] = markNoteStr;
            NSMutableArray *normalArr = weakSelf.dataArr[0];
            dict[@"imageArr"] =normalArr;
            weakSelf.selectCancelBtn(dict.copy);
        };
        return  self.footerView;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.dataArr[indexPath.section];
    if (self.markType == showAttendanceAddMarkType) {
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
    }else{
        // 查看图片
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"indexPath"] = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        dict[@"imageArr"] = arr;
        self.selectBigPhoto(dict.copy);
    }
}
// 移除视图
-(void) selectBigTap{
    [self removeFromSuperview];
}
// 用户选择图片后调用方法
-(void) addUserSelectPhoto:(UIImage *) selectImage{
    NSMutableArray *normalArr = self.dataArr[0];
    [normalArr insertObject:selectImage atIndex:0];
//    // 移除最后一个数据
//    if (normalArr.count == 4) {
//        [normalArr removeLastObject];
//    }
    // 贴换数据源
    [self.dataArr replaceObjectAtIndex:0 withObject:normalArr];
    // 刷新数据
    [self.markCollectionView reloadData];
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.markCollectionView reloadData];
}
-(void)setMarkConterStr:(NSString *)markConterStr{
    _markConterStr = markConterStr;
}
-(void)setMarkType:(showAttendanceMarkType)markType{
    _markType = markType;
    NSArray *arr = self.dataArr[0];
    if (arr.count == 0) {
        __weak typeof(self) weakSelf = self;
        [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(40));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(40));
            make.height.equalTo(@(KSIphonScreenH(190)));
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
    }
    [self.markCollectionView reloadData];
}



@end
