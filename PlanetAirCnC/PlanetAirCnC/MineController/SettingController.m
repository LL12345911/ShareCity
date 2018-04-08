//
//  SettingController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/27.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "SettingController.h"
#import "SettingCell.h"
#import "LoginController.h"

@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIAlertController* alertVc;
@property (nonatomic, strong) UIAlertController* alertLoginOut;


@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     [self setStatusBarBackgroundImage:[UIImage imageNamed:@"icon_settings"]];

    _titleArr = @[@"当前账号",@"姓名",@"身份证",@"芝麻分",@"版本号",@"联系我们"];
    self.customNavBar.title = @"账户设置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    [self.view addSubview:self.tableview];
    [_tableview registerClass:[SettingCell class] forCellReuseIdentifier:NSStringFromClass([SettingCell class])];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setTableviewFooterVirew];
}


- (void)setTableviewFooterVirew{
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 100*scale_h)];
    footerview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableFooterView = footerview;
    
    UIButton* loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 50*scale_h)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"background_login_btn"] forState:0];
    loginBtn.imageView.contentMode = UIViewContentModeCenter;
    [loginBtn setTitle:@"退出登录" forState:0];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [loginBtn addTarget:self action:@selector(logintOutMethod) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:loginBtn];
}
#pragma mark - 退出登录
- (void)logintOutMethod{
    if (!_alertLoginOut) {
        _alertLoginOut = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self logintOutMethodForButton];
            });
            
        }];
        
#warning  修改字体颜色,属于私有Api 慎用
        [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
        [_alertLoginOut addAction:cancelAction];
        [_alertLoginOut addAction:sureAction];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:_alertLoginOut animated:YES completion:^{}];
    });
}

#pragma mark - 登录
- (void)logintOutMethodForButton{
    LoginController *login = [[LoginController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell *rankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingCell class]) forIndexPath:indexPath];
        [rankCell setValueModel:_titleArr[indexPath.row] rightClickValue:@"" indexPathRow:indexPath.row];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rankCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"===============");
    if (indexPath.row == 5) {
        if (!_alertVc) {
            _alertVc = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"服务时间：00:00-24:00" preferredStyle:UIAlertControllerStyleActionSheet];//UIAlertControllerStyleActionSheet
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"400-088-1188" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                 [NSString callPhoneStr:@"4009197000"];
            }];
            
#warning  修改字体颜色,属于私有Api 慎用
            [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
            [_alertVc addAction:cancelAction];
            [_alertVc addAction:sureAction];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self presentViewController:_alertVc animated:YES completion:^{}];
        });
        
    }
}

#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTabBar-kTop) style:UITableViewStylePlain];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
