//
//  ExamPaperListSiftView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperListSiftView.h"

#import "SiftModuleCollectionViewCell.h"
#define SIFTMOUDLECOLLECTIONVIEW_CELL @"SiftModuleCollectionViewCell"
#import "SiftModuleHeaderReusableView.h"
#define SIFTMODULEHEADERREUSABLEVIEW  @"SiftModuleHeaderReusableView"

#define SIFTMODULEFOOTERREUSABLEVIEW  @"Footer"

@interface YWTExamPaperListSiftView ()
<
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource
>
// 筛选Collectionview
@property (nonatomic,strong) UICollectionView *siftCollectView;
// 数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
//选中IndexPath
@property (nonatomic,strong) NSMutableArray *selectIndexPathArr;
@end

@implementation YWTExamPaperListSiftView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createListSiftView];
        [self createSubmitBtnView];
    }
    return self;
}
#pragma mark ----按钮点击事件------
//重置
-(void)selectReplaceAction:(UIButton *) sender{
    // 添加交互
    sender.backgroundColor =[UIColor colorLineCommonGreyBlackColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    });
    for (int i=0; i<self.dataArr.count; i++) {
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:self.dataArr[i]];
        NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:mutableDict[@"children"]];
        
        for (int j=0; j< mutableArr.count; j++) {
            if (j == 0) {
                NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:mutableArr[j]];
                mutableDict[@"isSelect"] = @"1";
                //贴换
                [mutableArr replaceObjectAtIndex:j withObject:mutableDict];
            }else{
                NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:mutableArr[j]];
                mutableDict[@"isSelect"] = @"2";
                //贴换
                [mutableArr replaceObjectAtIndex:j withObject:mutableDict];
            }
        }
        mutableDict[@"children"] = mutableArr.copy;
        //贴换
        [self.dataArr replaceObjectAtIndex:i withObject:mutableDict];
    }
    
    [self.selectIndexPathArr removeAllObjects];
    for (int i=0; i<self.dataArr.count; i++) {
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:i];
        [self.selectIndexPathArr addObject:indexPath];
    }
    [self.siftCollectView reloadData];
    //筛选
    if ([self.delegate respondsToSelector:@selector(selectSubmitBtnTagIdStr:)]) {
        [self.delegate selectSubmitBtnTagIdStr:@""];
    }
}
//确定
-(void)selectTrueAction:(UIButton *) sender{
    
    NSMutableString *tagIdStr = [NSMutableString string];
    for (int i=0; i< self.selectIndexPathArr.count; i++) {
        NSIndexPath *indexPath = self.selectIndexPathArr[i];
        NSDictionary *dict = self.dataArr[indexPath.section];
        NSArray *arr = dict[@"children"];
        NSDictionary *childrenDict = arr[indexPath.row];
        [tagIdStr appendString:[NSString stringWithFormat:@"%@",childrenDict[@"id"]]];
        if (i != self.selectIndexPathArr.count-1) {
            [tagIdStr appendString:@","];
        }
    }
    
//    for (NSIndexPath *indexPath in self.selectIndexPathArr) {
//        NSDictionary *dict = self.dataArr[indexPath.section];
//        NSArray *arr = dict[@"children"];
//        NSDictionary *childrenDict = arr[indexPath.row];
//        [tagIdStr appendString:[NSString stringWithFormat:@"%@",childrenDict[@"id"]]];
//        [tagIdStr appendString:@","];
//    }
    // 如果是空类
    if ([tagIdStr isKindOfClass:[NSNull class]] || tagIdStr == nil || tagIdStr.length == 0) {
        //筛选
        if ([self.delegate respondsToSelector:@selector(selectSubmitBtnTagIdStr:)]) {
            [self.delegate selectSubmitBtnTagIdStr:@""];
        }
    }else{
        //筛选
        if ([self.delegate respondsToSelector:@selector(selectSubmitBtnTagIdStr:)]) {
            [self.delegate selectSubmitBtnTagIdStr:tagIdStr];
        }
    }
}
-(void) createSubmitBtnView{
    __weak typeof(self) weakSelf = self;
    UIView *bottomView = [[UIView alloc]init];
    [self addSubview:bottomView];
    bottomView.backgroundColor  = [UIColor colorTextWhiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSTabbarH);
        make.height.equalTo(@(KSIphonScreenH(56)));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bottomView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.equalTo(@1);
    }];
    
    UIButton *replaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:replaceBtn];
    [replaceBtn setTitle:@"重置" forState:UIControlStateNormal];
    [replaceBtn setTitleColor:[UIColor colorCommon65GreyBlackColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = Font(14);
    [replaceBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#f8f8f8"]] forState:UIControlStateNormal];
    [replaceBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#989898" alpha:0.8]] forState:UIControlStateHighlighted];
    [replaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(KSIphonScreenW(12));
        make.top.equalTo(bottomView).offset(KSIphonScreenH(12));
        make.bottom.equalTo(bottomView).offset(-KSIphonScreenH(12));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    replaceBtn.layer.cornerRadius = 3;
    replaceBtn.layer.masksToBounds = YES;
    [replaceBtn addTarget:self action:@selector(selectReplaceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:trueBtn];
    [trueBtn setTitle:@"确定" forState:UIControlStateNormal];
    [trueBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    trueBtn.titleLabel.font = Font(14);
    [trueBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [trueBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(replaceBtn.mas_right).offset(10);
        make.right.equalTo(bottomView).offset(-12);
        make.width.height.equalTo(replaceBtn);
        make.centerY.equalTo(replaceBtn.mas_centerY);
    }];
    trueBtn.layer.cornerRadius = 3;
    trueBtn.layer.masksToBounds = YES;
    [trueBtn addTarget:self action:@selector(selectTrueAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) createListSiftView{
    self.backgroundColor  =[UIColor colorTextWhiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = KSIphonScreenW(10);
    layout.minimumInteritemSpacing = KSIphonScreenH(10);
    layout.sectionInset = UIEdgeInsetsMake(KSIphonScreenH(15), KSIphonScreenW(12), KSIphonScreenH(15), KSIphonScreenW(12));
    
    self.siftCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSIphonScreenH(7), KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-KSIphonScreenH(56)) collectionViewLayout:layout];
    [self addSubview:self.siftCollectView];
    self.siftCollectView.dataSource = self;
    self.siftCollectView.delegate = self;
    self.siftCollectView.backgroundColor  = [UIColor colorTextWhiteColor];
 
    [self.siftCollectView registerNib:[UINib nibWithNibName:SIFTMOUDLECOLLECTIONVIEW_CELL bundle:nil] forCellWithReuseIdentifier:SIFTMOUDLECOLLECTIONVIEW_CELL];

    [self.siftCollectView registerNib:[UINib nibWithNibName:SIFTMODULEHEADERREUSABLEVIEW bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SIFTMODULEHEADERREUSABLEVIEW];
    [self.siftCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SIFTMODULEFOOTERREUSABLEVIEW];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *dict = self.dataArr[section];
    NSArray *arr = dict[@"children"];
    return arr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SiftModuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SIFTMOUDLECOLLECTIONVIEW_CELL forIndexPath:indexPath];
    NSDictionary *dict = self.dataArr[indexPath.section];
    NSArray *arr = dict[@"children"];
    cell.dict = arr[indexPath.row];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KScreenW-KSIphonScreenW(50))/3, KSIphonScreenH(33));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, KSIphonScreenH(33));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 1);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SiftModuleHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SIFTMODULEHEADERREUSABLEVIEW forIndexPath:indexPath];
        headerView.dict =self.dataArr[indexPath.section];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SIFTMODULEFOOTERREUSABLEVIEW forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        return footerView;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *statuIndexPath = self.selectIndexPathArr[indexPath.section];
    NSMutableDictionary *mutableDict = self.dataArr[indexPath.section];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:mutableDict[@"children"]];
    
    //把上次选中还原
    NSMutableDictionary *oldDict = [NSMutableDictionary dictionaryWithDictionary:mutableArr[statuIndexPath.row]];
    oldDict[@"isSelect"] = @"2";
    //贴换
    [mutableArr replaceObjectAtIndex:statuIndexPath.row withObject:oldDict];
    
    //把当前变为选中状态
    NSMutableDictionary *nowDict = [NSMutableDictionary dictionaryWithDictionary:mutableArr[indexPath.row]];
    nowDict[@"isSelect"] = @"1";
    //贴换
    [mutableArr replaceObjectAtIndex:indexPath.row withObject:nowDict];
    
    mutableDict[@"children"] = mutableArr.copy;
    [self.dataArr replaceObjectAtIndex:indexPath.section withObject:mutableDict];
    
    statuIndexPath = indexPath;
    [self.selectIndexPathArr replaceObjectAtIndex:indexPath.section withObject:statuIndexPath];
    
    //刷新
    [self.siftCollectView reloadData];
  
}
#pragma  mark  组装 安全管理筛选数据 -----
-(void) createSafetControNSArryData{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    mutableDict[@"title"] = @"按数据状态";
    NSArray *nameArr = @[@"全部",@"已提交",@"编辑中",@"已撤销"];
    NSMutableArray *contentArr = [NSMutableArray array];
    for (int i= 0; i< nameArr.count; i++) {
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"title"] = nameArr[i];
        if (i == 0) {
            contentDict[@"isSelect"]= @"1";
        }else{
            contentDict[@"isSelect"]= @"2";
        }
        if (i == 2) {
           contentDict[@"id"] = [NSNumber numberWithInt:3];
        }else if (i == 3) {
            contentDict[@"id"] = [NSNumber numberWithInt:2];
        }else{
           contentDict[@"id"] = [NSNumber numberWithInt:i];
        }
        [contentArr addObject:contentDict];
    }
    mutableDict[@"children"] = contentArr;
    // 移除默认选中数据
    [self.selectIndexPathArr removeAllObjects];
    // 添加默认选中数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.selectIndexPathArr addObject:indexPath];
    
    // 删除所有数据源
    [self.dataArr removeAllObjects];
    // 添加
    [self.dataArr addObject:mutableDict];
    
    // 刷新UI
    [self.siftCollectView reloadData];
}
#pragma  mark ------ get -----

-(NSMutableArray *)selectIndexPathArr{
    if (!_selectIndexPathArr) {
        _selectIndexPathArr  =[NSMutableArray array];
    }
    return _selectIndexPathArr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setSiftType:(showListSiftType)siftType{
    _siftType = siftType;
    // 安全管理 记录
    if (siftType == showListSiftSafetContolRecordType) {
        [self createSafetControNSArryData];
        return;
    }
    [self requestTagExamData];
}

#pragma mark -----请求筛选数据接口--------
-(void) requestTagExamData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =[YWTTools getNewToken];
    if (self.siftType == showListSiftLabayExerType) {
        param[@"types"] =@"1";
    }else if(self.siftType == showListSiftMockTestType){
        // 试卷练习
        param[@"types"] =@"2";
    }else if(self.siftType == showListSiftRiskDisplayType){
        // 风险展示
        param[@"types"] =@"3";
    }else if(self.siftType == showListSiftExposureStationType){
        // 曝光台
        param[@"types"] =@"4";
    }else if (self.siftType == showListSiftMyStudiesType){
        // 学习中心
         param[@"types"] =@"5";
    }else if (self.siftType == showListSiftTaskCenterType){
        // 任务中心
        param[@"types"] = @"6";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIFILTEREXAM_URL params:param withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            // 移除数据源
            [self.dataArr removeAllObjects];
            // 添加数据源
            [self.dataArr addObjectsFromArray:showdata];
            
            if (self.dataArr.count == 0) {
                [self.siftCollectView reloadData];
                return;
            }
            
            for (int i=0; i<self.dataArr.count; i++) {
                NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:self.dataArr[i]];
                NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:mutableDict[@"children"]];
                for (int j=0; j<mutableArr.count; j++) {
                    NSMutableDictionary *childDict = [NSMutableDictionary dictionaryWithDictionary:mutableArr[j]];
                    if (j == 0) {
                        childDict[@"isSelect"] = @"1";
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                        [self.selectIndexPathArr addObject:indexPath];
                    }else{
                        childDict[@"isSelect"] = @"2";
                    }
                    [mutableArr replaceObjectAtIndex:j withObject:childDict];
                }
                mutableDict[@"children"] = mutableArr.copy;
                [self.dataArr replaceObjectAtIndex:i withObject:mutableDict];
            }
            // 刷新UI
            [self.siftCollectView reloadData];
        }
    }];
}



@end
