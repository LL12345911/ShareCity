//
//  BillingRecordsController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BillingRecordsController.h"
#import "BillingRecordsCell.h"

@interface BillingRecordsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;


@end

@implementation BillingRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account40");
    

    
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[BillingRecordsCell class] forCellReuseIdentifier:NSStringFromClass([BillingRecordsCell class])];
    
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BillingRecordsCell *recodeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingRecordsCell class]) forIndexPath:indexPath];
    //    [rankCell setValueModel:@"" indexPathRow:indexPath.row];
    recodeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    assetsCell.delegate = self;
    //    rankCell.textLabel.text = [NSString stringWithFormat:@"index %ld",indexPath.row];
    return recodeCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
