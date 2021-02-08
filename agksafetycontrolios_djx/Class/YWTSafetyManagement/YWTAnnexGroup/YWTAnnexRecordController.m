//
//  AnnexRecordController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnnexRecordController.h"

#import "YWTShowNoSourceView.h"

#import "YWTRecordListTableViewCell.h"
#define RECORDLISTTABLEVIEW_CELL @"YWTRecordListTableViewCell"

@interface YWTAnnexRecordController ()
<
UITableViewDelegate,
UITableViewDataSource
>

// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) UITableView *recordTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
//  选中
@property (nonatomic,strong) NSIndexPath *selectIndexPath;

@end

@implementation YWTAnnexRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建Tableview
    [self createTableView];
    // 获取所有保存的音频文件
    [self getAllFileData];
}
#pragma mark --- 创建Tableview--------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+10, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
    [self.view addSubview:self.recordTableView];

    
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recordTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.recordTableView registerClass:[YWTRecordListTableViewCell class] forCellReuseIdentifier:RECORDLISTTABLEVIEW_CELL];
    
    // 添加空白页
    self.showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, CGRectGetHeight(self.recordTableView.frame))];
    self.showNoSoucreView.showMarkLab.text = @"暂无音频";
    [self.recordTableView addSubview:self.showNoSoucreView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTRecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECORDLISTTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.selectIndex = self.selectIndexPath;
    cell.fliePath = self.dataArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.selectIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        weakSelf.selectIndexPath = indexPath;
        [weakSelf.recordTableView reloadData];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(70);
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    if ([tableView isEqual:self.recordTableView]) {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    }
    return result;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        if (indexPath.row<[self.dataArr count]) {
            // 删除数据源
            NSString *fliePath = [self getSpliceCompleteFliePath:indexPath];
            // 文件管理类
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([[NSFileManager defaultManager]fileExistsAtPath:fliePath]) {
                // 移除文件
                [fileManager removeItemAtPath:fliePath error:nil];
            }
            //移除数据源的数据
            [self.dataArr removeObjectAtIndex:indexPath.row];
            //移除tableView中的数据
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    __weak typeof(self) weakSelf = self;
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:[NSString stringWithFormat:@"删除"] handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        // 删除数据源
        NSString *fliePath = [weakSelf getSpliceCompleteFliePath:indexPath];
        // 文件管理类
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([[NSFileManager defaultManager]fileExistsAtPath:fliePath]) {
            // 移除文件
            [fileManager removeItemAtPath:fliePath error:nil];
        }
        //移除数据源的数据
        [weakSelf.dataArr removeObjectAtIndex:indexPath.row];
        //移除tableView中的数据
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        // 判断是否显示空白页
        if (weakSelf.dataArr.count == 0) {
            weakSelf.showNoSoucreView.hidden = NO;
        }else{
            weakSelf.showNoSoucreView.hidden = YES;
        }
        // 这句很重要，退出编辑模式，隐藏左滑菜单
        [tableView setEditing:NO animated:YES];
        
        completionHandler(YES);
    }];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    config.performsFirstActionWithFullSwipe = NO;
    return config;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 拼接成完整的地址
    NSString *fliePath = [self getSpliceCompleteFliePath:indexPath];
    [self createAudioPlay:fliePath];
}
#pragma mark ---创建音频播放 --------
-(void) createAudioPlay:(NSString *) urlNameStr{
    YWTBaseVodPlayView *playView = [[YWTBaseVodPlayView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    playView.filePath= urlNameStr;
    [self.view addSubview:playView];
}
#pragma mark --- 获取所有保存的音频文件 --------
-(void ) getAllFileData{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    // 获取Documents路径
    NSString *cwFolderPath = [NSString stringWithFormat:@"%@/audio",documentDir];
    // 获取文件夹所有文件
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:cwFolderPath error:nil];
    // 添加到数组中
    [self.dataArr addObjectsFromArray:files];
    
    if (self.dataArr.count == 0) {
        self.showNoSoucreView.hidden = NO;
    }else{
       self.showNoSoucreView.hidden = YES;
    }
    // 刷新UI
    [self.recordTableView reloadData];
}

// 组装成完整的地址
-(NSString *) getSpliceCompleteFliePath:(NSIndexPath *)indexPath{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 获取Documents路径
    NSString *cwFolderPath = [NSString stringWithFormat:@"%@/audio",documentDir];
    
    NSString *nameStr = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    
    NSString *fliePath = [NSString stringWithFormat:@"%@/%@",cwFolderPath,nameStr];
    
    return fliePath;
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"音频列表";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //检查记录
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"确定" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    self.customNavBar.onClickRightButton = ^{
        if (weakSelf.dataArr.count == 0) {
            [weakSelf.view showErrorWithTitle:@"没有数据!" autoCloseTime:0.5];
            return ;
        }
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        NSString *filePath = [weakSelf getSpliceCompleteFliePath:weakSelf.selectIndexPath];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        param[@"type"] = @"audio";
        param[@"audio"] = filePath;
        param[@"filePath"] = fileData;
        param[@"name"] = weakSelf.dataArr[weakSelf.selectIndexPath.row];
        param[@"objectKey"] = [NSString stringWithFormat:@"audio/%@",weakSelf.dataArr[weakSelf.selectIndexPath.row]];
        param[@"typeName"]= weakSelf.dataArr[weakSelf.selectIndexPath.row];
        param[@"size"] = [NSNumber numberWithInteger:fileData.length];
        if ([weakSelf.delegate respondsToSelector:@selector(selectAudioListDict:)] ) {
            [weakSelf.delegate selectAudioListDict:param];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
}
#pragma mark --- get 方法 --------
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
