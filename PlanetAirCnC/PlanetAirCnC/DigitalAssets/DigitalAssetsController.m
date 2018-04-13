//
//  DigitalAssetsController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "DigitalAssetsController.h"
#import "DigitalAssetsCell.h"
#import "RecordController.h"
#import "ReceiptViewController.h"
#import "CoinTypeController.h"
#import "AssetsOffController.h"


@interface DigitalAssetsController ()<UITableViewDelegate,UITableViewDataSource,DigitalAssetsDelegate>

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation DigitalAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"digital01");// @"数字资产";
    
    [self.customNavBar wr_setRightButtonWithNormal:[UIImage imageNamed:@"添加"] highlighted:nil title:GetString(@"digital02") titleColor:[UIColor whiteColor]];
    
    __block typeof(self) weakSelf = self;
    self.customNavBar.onClickRightButton = ^{
        [weakSelf addTheCurrency];
    };

    [self.view addSubview:self.tableview];
    [_tableview registerClass:[DigitalAssetsCell class] forCellReuseIdentifier:NSStringFromClass([DigitalAssetsCell class])];
}

#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225*scale_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DigitalAssetsCell *assetsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DigitalAssetsCell class]) forIndexPath:indexPath];
    assetsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    assetsCell.delegate = self;
    return assetsCell;
    
}
////  ***********  添加币种 协议(procotol) 定义方法（函数） ***********  //
//- (void) addCoinTypeWithValue:(NSDictionary *)value{
//
//    DebugLog(@"添加币种 协议(procotol) ");
//
//}


#pragma mark - 添加币种
- (void)addTheCurrency{
    DebugLog(@"添加币种");
    CoinTypeController *coinType = [[CoinTypeController alloc] init];
    [self.navigationController pushViewController:coinType animated:YES];
}



//  ***********  协议(DigitalAssetsDelegate) 定义方法（函数） ***********  //

#pragma mark - 收发记录
- (void) clickRecodeButtonWith:(NSIndexPath *)indexPath{
    RecordController *recodeView = [[RecordController alloc] init];
    [self.navigationController pushViewController:recodeView animated:YES];
}

#pragma mark - 转出
- (void) clickRollOutButtonWith:(NSIndexPath *)indexPath{
    AssetsOffController *assetOff = [[AssetsOffController alloc] init];
    [self.navigationController pushViewController:assetOff animated:YES];
}

#pragma mark - 收款
- (void) clickCollectionScheduleButtonWith:(NSIndexPath *)indexPath{
    ReceiptViewController *recodeView = [[ReceiptViewController alloc] init];
    [self.navigationController pushViewController:recodeView animated:YES];
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTop-kTabBar)  style:UITableViewStylePlain];
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
