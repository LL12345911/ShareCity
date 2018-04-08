//
//  MineController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "MineController.h"
#import "LoginController.h"
#import "SettingController.h"
#import "TaskViewController.h"
#import "DiamondsRecordController.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64

@interface MineController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton* loginBtn;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.customNavBar.title = @"纷享城市";
    [self setupNavBarBackgroundImage:nil];
    
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:0];
    
//    [self setStatusBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    
    [self.view addSubview:self.tableview];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"icon_settings"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickRightButton = ^{
        DebugLog(@"++++++++++++");
        SettingController *setView = [[SettingController alloc] init];
        [weakSelf.navigationController pushViewController:setView animated:YES];
    };

    [self setTableviewHeadView];
}


- (void)setTableviewHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 700*scale_h)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headView;
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200*scale_h)];
    back.backgroundColor = kBlueColor;
    [_headView addSubview:back];
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100*scale_h, kWidth-40, 240*scale_h)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 5;
    topView.layer.masksToBounds = YES;
    topView.userInteractionEnabled = YES;
    [_headView addSubview:topView];
    
   UIButton* photoBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-40-80*scale_h)/2, 20*scale_h, 80*scale_h, 80*scale_h)];
    [photoBtn setBackgroundImage:[UIImage imageNamed:@"头像"] forState:0];
    photoBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [photoBtn addTarget:self action:@selector(logintOutMethodForButton) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:photoBtn];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-40-80*scale_h)/2, 120*scale_h, 80, 30*scale_h)];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"background_login_btn"] forState:0];
    _loginBtn.imageView.contentMode = UIViewContentModeCenter;
    [_loginBtn setTitle:@"立即登录" forState:0];
    _loginBtn.titleLabel.numberOfLines = 0;
//    loginBtn.layer.cornerRadius = 5;
//    loginBtn.layer.masksToBounds = YES;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [_loginBtn addTarget:self action:@selector(logintOutMethodInMine) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_loginBtn];
    
    UIButton* moneyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 180*scale_h, (kWidth-40)/2-1, 40*scale_h)];
    [moneyBtn setImage:[UIImage imageNamed:@"资产"] forState:0];
    moneyBtn.imageView.contentMode = UIViewContentModeCenter;
    [moneyBtn setTitle:@"我的资产" forState:0];
    moneyBtn.layer.cornerRadius = 5;
    moneyBtn.layer.masksToBounds = YES;
    moneyBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [moneyBtn setTitleColor:kBlackColor forState:0];
    [moneyBtn addTarget:self action:@selector(pushDiamondsRecordController) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:moneyBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake((kWidth-40)/2+0.5, 190*scale_h, 1, 20*scale_h)];
    line.backgroundColor = kGrayColor;
      [topView addSubview:line];
    
    UIButton* speedBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-40)/2+1, 180*scale_h, (kWidth-40)/2, 40*scale_h)];
    [speedBtn setImage:[UIImage imageNamed:@"加速"] forState:0];
    speedBtn.imageView.contentMode = UIViewContentModeCenter;
    [speedBtn setTitle:@"加速黑钻" forState:0];
    speedBtn.layer.cornerRadius = 5;
    speedBtn.layer.masksToBounds = YES;
    speedBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [speedBtn setTitleColor:kBlackColor forState:0];
    [speedBtn addTarget:self action:@selector(speedMethod) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:speedBtn];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(20, 350*scale_h, kWidth-40, 200*scale_h)];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 5;
    centerView.layer.masksToBounds = YES;
    [_headView addSubview:centerView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200*scale_h, 50*scale_h+1)];
    title.text = @"星球基地";
    title.font = [UIFont systemFontOfSize:17*scale_h];
    [centerView addSubview:title];
    
    UIButton* arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake( kWidth-40-70, 0, 50*scale_h, 50*scale_h)];
    [arrowBtn setImage:[UIImage imageNamed:@"右箭头"] forState:0];
    arrowBtn.imageView.contentMode = UIViewContentModeCenter;
    arrowBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    arrowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [centerView addSubview:arrowBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*scale_h, kWidth-40, 1)];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [centerView addSubview:line2];
    
    UIButton* planetBtn = [[UIButton alloc] initWithFrame:CGRectMake( 20, 50*scale_h+1, kWidth-80, 150*scale_h)];
    [planetBtn setBackgroundImage:[UIImage imageNamed:@"星球基地"] forState:0];
    planetBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [centerView addSubview:planetBtn];
    
    
}
#pragma mark - 登录
- (void)logintOutMethodInMine{
    [self changeLoginButton:1];
    
//    LoginController *login = [[LoginController alloc] init];
//    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark - 已登录 或 未登录 登录按钮的变化
- (void) changeLoginButton:(NSInteger)flag{
    if (flag == 0) {
        _loginBtn.frame = CGRectMake((kWidth-40-80*scale_h)/2, 120*scale_h, 80, 30);
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"background_login_btn"] forState:0];
        [_loginBtn setAttributedTitle:[self setAttributedFont:@"立即登录" andStr2:@""] forState:0];
        _loginBtn.userInteractionEnabled = NO;
    }else{
        _loginBtn.frame = CGRectMake(0, 110*scale_h, kWidth-40, 60);
        [_loginBtn setBackgroundImage:[UIImage new] forState:0];
        [_loginBtn setAttributedTitle:[self setAttributedFont:@"啸狼" andStr2:@"你是纷享城市的第12345位居民"] forState:0];
        _loginBtn.userInteractionEnabled = NO;
    }
}

- (NSMutableAttributedString *)setAttributedFont:(NSString *)str1  andStr2:(NSString *)str2{
    
    str2 = str2.length > 0 ? [NSString stringWithFormat:@"\n%@",str2] : str2;
    UIColor *color = str2.length > 0 ? kBlackColor : [UIColor whiteColor];
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    NSRange rangleft = NSMakeRange(0, str1.length);
    NSRange rangright = NSMakeRange(str1.length, str2.length);
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:color  range:rangleft];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangright];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangright];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5*scale_h];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [strAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strAtt length])];
    return strAtt;
}

#pragma mark - 获取任务
- (void)speedMethod{
    TaskViewController *taskView = [[TaskViewController alloc] init];
    [self.navigationController pushViewController:taskView animated:YES];
}

#pragma mark - 黑钻记录
- (void)pushDiamondsRecordController{
    DiamondsRecordController *view = [[DiamondsRecordController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)overloadingReloadData{
    DebugLog(@"++++++++++++++");
}
- (void)actionForButton{
    LoginController *login = [[LoginController alloc] init];
    //    [self presentViewController:login animated:YES completion:nil];
    [self.navigationController pushViewController:login animated:YES];
}
#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *rankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
//    [rankCell setValueModel:@"" indexPathRow:indexPath.row];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rankCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
    else
    {
        [self.customNavBar wr_setBackgroundAlpha:0];
    }
}



#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kTabBar) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.sectionIndexColor = kBlueColor;
        _tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
