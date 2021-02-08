//
//  TaskCenterListHeaderView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterListHeaderView.h"

#import "YWTBaseHeaderSearchView.h"

@interface YWTTaskCenterListHeaderView ()
// 搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView *searchView;
// 头像图片
@property (nonatomic,strong) UIImageView *headImageV;
// 我的学分
@property (nonatomic,strong) UILabel *myStudiesScroeLab;
// 进行中任务数量
@property (nonatomic,strong) UILabel *taskingNumberLab;
// 显示进行中任务数量
@property (nonatomic,strong) UILabel *showTaskingNumberLab;
// 全部任务数量
@property (nonatomic,strong) UILabel *allTaskNumberLab;
// 显示全部数量
@property (nonatomic,strong) UILabel *showAllTaskNumberLab;

@end


@implementation YWTTaskCenterListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [bgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [bgView addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"taskCenter_header_bg"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.bottom.equalTo(bgView).offset(-KSIphonScreenH(24));
    }];
    
    // 搜索view
    self.searchView = [[YWTBaseHeaderSearchView alloc]init];
    [bgView addSubview:self.searchView];
    self.searchView.backgroundColor = [UIColor clearColor];
    self.searchView.isExamCenterRcord = YES;
    self.searchView.searchTextField.placeholder = @"请输入任务/说明名称搜索";
    self.searchView.bgView.layer.borderWidth = 0;
    self.searchView.bgView.layer.borderColor = [UIColor colorTextWhiteColor].CGColor;
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(36)));
        make.centerY.equalTo(bgImageV.mas_bottom);
    }];
    //重新更新搜索view内部UI约束
    [self.searchView.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.searchView);
        make.left.equalTo(weakSelf.searchView).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf.searchView).offset(-KSIphonScreenH(12));
    }];
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        [weakSelf.searchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.searchView.bgView).offset((KScreenW-24)/5);
        }];
    }];
    //点击搜索按钮
    self.searchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.selectSearch(search);
    };
    
    // 头像view
    UIView *headView = [[UIView alloc]init];
    [bgView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(15)));
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.height.equalTo(@(KSIphonScreenW(62)));
    }];
    headView.layer.cornerRadius = KSIphonScreenW(62)/2;
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth = 1;
    headView.layer.borderColor  = [UIColor colorTextWhiteColor].CGColor;
    
    
    // 头部图片
    self.headImageV = [[UIImageView alloc]init];
    [headView addSubview:self.headImageV];
    self.headImageV.image = [UIImage imageNamed:@"taskCenter_header_nomal"];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(KSIphonScreenW(56)));
        make.centerX.equalTo(headView.mas_centerX);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    self.headImageV.layer.cornerRadius = KSIphonScreenW(56)/2;
    self.headImageV.layer.masksToBounds = YES;
   
    UIButton *myStudiesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:myStudiesBtn];
    [myStudiesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.left.equalTo(bgView).offset(KSIphonScreenW(30));
        make.width.height.equalTo(@70);
    }];
    [myStudiesBtn addTarget:self action:@selector(selectMyStudiesBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *myStudiesView = [[UIView alloc]init];
    [bgView addSubview:myStudiesView];
    myStudiesView.userInteractionEnabled = NO;
    
    // 我的学分
    self.myStudiesScroeLab = [[UILabel alloc]init];
    [myStudiesView addSubview:self.myStudiesScroeLab];
    self.myStudiesScroeLab.text = @"0";
    self.myStudiesScroeLab.textColor = [UIColor colorTextWhiteColor];
    self.myStudiesScroeLab.font = BFont(18);
    [self.myStudiesScroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myStudiesView.mas_top);
        make.centerX.equalTo(myStudiesView.mas_centerX);
    }];
    
    UILabel *showMyStudiesScroeLab = [[UILabel alloc]init];
    [myStudiesView addSubview:showMyStudiesScroeLab];
    showMyStudiesScroeLab.text = @"我的学分";
    showMyStudiesScroeLab.textColor  = [UIColor colorTextWhiteColor];
    showMyStudiesScroeLab.font = BFont(12);
    [showMyStudiesScroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myStudiesScroeLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.myStudiesScroeLab.mas_centerX);
    }];
    
    [myStudiesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myStudiesScroeLab.mas_top);
        make.left.equalTo(showMyStudiesScroeLab.mas_left);
        make.right.equalTo(showMyStudiesScroeLab.mas_right);
        make.bottom.equalTo(showMyStudiesScroeLab.mas_bottom);
        make.centerX.equalTo(myStudiesBtn.mas_centerX);
        make.centerY.equalTo(myStudiesBtn.mas_centerY);
    }];
    
    // 进行中任务按钮
    UIButton *taskingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:taskingBtn];
    [taskingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(myStudiesBtn.mas_centerY);
        make.centerX.equalTo(headView.mas_centerX);
        make.width.height.equalTo(myStudiesBtn);
    }];
    [taskingBtn addTarget:self action:@selector(selectTaskingBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *taskingView = [[UIView alloc]init];
    [bgView addSubview:taskingView];
    taskingView.userInteractionEnabled = NO;
    
    // 进行中任务数量
    self.taskingNumberLab = [[UILabel alloc]init];
    [taskingView addSubview:self.taskingNumberLab];
    self.taskingNumberLab.text = @"0";
    self.taskingNumberLab.textColor = [UIColor colorTextWhiteColor];
    self.taskingNumberLab.font = BFont(23);
    [self.taskingNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskingView.mas_top);
        make.centerX.equalTo(taskingView.mas_centerX);
    }];
    
    // 显示进行中任务数量
    self.showTaskingNumberLab = [[UILabel alloc]init];
    [taskingView addSubview:self.showTaskingNumberLab];
    self.showTaskingNumberLab.text = @"进行中任务";
    self.showTaskingNumberLab.textColor  = [UIColor colorTextWhiteColor];
    self.showTaskingNumberLab.font = BFont(14);
    [self.showTaskingNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskingNumberLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.taskingNumberLab.mas_centerX);
    }];
    
    [taskingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskingNumberLab.mas_top);
        make.left.equalTo(weakSelf.showTaskingNumberLab.mas_left);
        make.right.equalTo(weakSelf.showTaskingNumberLab.mas_right);
        make.bottom.equalTo(weakSelf.showTaskingNumberLab.mas_bottom);
        make.centerX.equalTo(taskingBtn.mas_centerX);
        make.centerY.equalTo(taskingBtn.mas_centerY);
    }];
    
    
    // 全部任务按钮
    UIButton *allTaskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:allTaskBtn];
    [allTaskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(myStudiesBtn.mas_centerY);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(30));
        make.width.height.equalTo(myStudiesBtn);
    }];
    [allTaskBtn addTarget:self action:@selector(selectAllTaskBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *allTaskView = [[UIView alloc]init];
    [bgView addSubview:allTaskView];
    allTaskView.userInteractionEnabled = NO;
    
    // 全部任务数量
    self.allTaskNumberLab = [[UILabel alloc]init];
    [allTaskView addSubview:self.allTaskNumberLab];
    self.allTaskNumberLab.text = @"0";
    self.allTaskNumberLab.textColor = [UIColor colorTextWhiteColor];
    self.allTaskNumberLab.font = BFont(18);
    [self.allTaskNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allTaskView.mas_top);
        make.centerX.equalTo(allTaskView.mas_centerX);
    }];
    
    // 显示全部数量
    self.showAllTaskNumberLab = [[UILabel alloc]init];
    [allTaskView addSubview:self.showAllTaskNumberLab];
    self.showAllTaskNumberLab.text = @"全部任务";
    self.showAllTaskNumberLab.textColor = [UIColor colorTextWhiteColor];
    self.showAllTaskNumberLab.font = BFont(12);
    [self.showAllTaskNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.allTaskNumberLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.allTaskNumberLab.mas_centerX);
    }];
    
    [allTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.allTaskNumberLab.mas_top);
        make.left.equalTo(weakSelf.showAllTaskNumberLab.mas_left);
        make.right.equalTo(weakSelf.showAllTaskNumberLab.mas_right);
        make.bottom.equalTo(weakSelf.showAllTaskNumberLab.mas_bottom);
        make.centerX.equalTo(allTaskBtn.mas_centerX);
        make.centerY.equalTo(allTaskBtn.mas_centerY);
    }];
}
// 我的学分
-(void) selectMyStudiesBtn:(UIButton *) sender{
    self.selectMyStudies();
}
// 进行中任务
-(void) selectTaskingBtn:(UIButton *) sender{
    // 当前
    self.showTaskingNumberLab.font = BFont(14);
    self.taskingNumberLab.font = BFont(23);
    
    //
    self.showAllTaskNumberLab.font = BFont(12);
    self.allTaskNumberLab.font = BFont(18);
    
    // 回调
    self.selectTasking();
}
// 全部任务
-(void) selectAllTaskBtn:(UIButton *) sender{
    // 当前
    self.showAllTaskNumberLab.font = BFont(14);
    self.allTaskNumberLab.font = BFont(23);
    
    //
    self.showTaskingNumberLab.font = BFont(12);
    self.taskingNumberLab.font = BFont(18);
    
    // 回调
    self.selectAllTask();
}
// 更新用户信息
-(void) updateUserDataInfo:(NSDictionary*)dict{
    // 头像
    NSString *photoUrl = [NSString stringWithFormat:@"%@",dict[@"photo"]];
    // 字符串和UTF8编码转换
    NSString *urlUTF8Str = [photoUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YWTTools sd_setImageView:self.headImageV WithURL:urlUTF8Str andPlaceholder:@"taskCenter_header_nomal"];
    
    // 学分
    NSString *creditStr = [NSString stringWithFormat:@"%.2f",[dict[@"credit"]doubleValue]];
    self.myStudiesScroeLab.text = creditStr;
    
    // 进行中任务数
    NSString *tasksGetOnStr = [NSString stringWithFormat:@"%@",dict[@"tasksGetOn"]];
    self.taskingNumberLab.text = tasksGetOnStr;
    
    // 全部任务数量
    NSString *tasksNumStr = [NSString stringWithFormat:@"%@",dict[@"tasksNum"]];
    self.allTaskNumberLab.text = tasksNumStr;
}

// 更新搜索条件UI
-(void) updateSearchTextStr:(NSString *)searchStr{
    [self.searchView.searchTextField becomeFirstResponder];
    self.searchView.searchTextField.text = searchStr;
    [self.searchView.searchTextField resignFirstResponder];
}



@end
