//
//  MyIncomeController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "MyIncomeController.h"
#import "MyIncomeCell.h"
#import "BillingRecordsController.h"
#import "EnjoyDrilDisputeController.h"


@interface MyIncomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation MyIncomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account38");

    [self.customNavBar wr_setRightButtonWithNormal:[UIImage imageNamed:@"兑换记录2"] highlighted:nil title:GetString(@"account39") titleColor:[UIColor whiteColor]];
    
    __block typeof(self) weakSelf = self;
    self.customNavBar.onClickRightButton = ^{
        [weakSelf billingRecords];
    };
    
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[MyIncomeCell class] forCellReuseIdentifier:NSStringFromClass([MyIncomeCell class])];
    
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyIncomeCell *incomeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyIncomeCell class]) forIndexPath:indexPath];
    //    [rankCell setValueModel:@"" indexPathRow:indexPath.row];
    incomeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    assetsCell.delegate = self;
    //    rankCell.textLabel.text = [NSString stringWithFormat:@"index %ld",indexPath.row];
    return incomeCell;
    
}

#pragma mark - 收发记录
- (void) clickRecodeButtonWith:(NSIndexPath *)indexPath{
//    RecordController *recodeView = [[RecordController alloc] init];
//    [self.navigationController pushViewController:recodeView animated:YES];
}







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EnjoyDrilDisputeController *recode = [[EnjoyDrilDisputeController alloc] init];
    [self.navigationController pushViewController:recode animated:YES];
    
    
}


#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTop-KBottom)  style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}



#pragma mark - 账单记录
- (void)billingRecords{
    DebugLog(@"账单记录");
    BillingRecordsController *recode = [[BillingRecordsController alloc] init];
    [self.navigationController pushViewController:recode animated:YES];
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
