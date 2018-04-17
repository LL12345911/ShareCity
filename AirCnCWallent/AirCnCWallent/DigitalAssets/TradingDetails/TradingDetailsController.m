//
//  TradingDetailsController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

//交易详情

#import "TradingDetailsController.h"
#import "TradingDetailsCell.h"

@interface TradingDetailsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) UIView *headview;
@property (nonatomic,strong) UILabel *numberL;


@property (nonatomic,strong) NSArray *typeArr;


@end

@implementation TradingDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"digital07");//@"交易详情";
    
    
    
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[TradingDetailsCell class] forCellReuseIdentifier:NSStringFromClass([TradingDetailsCell class])];
    
    _typeArr = @[GetString(@"digital08"),GetString(@"digital09"),GetString(@"digital10"),GetString(@"digital11"),GetString(@"digital12"),GetString(@"digital13"),GetString(@"digital14")];
    

    _headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 80*scale_h)];
    _headview.backgroundColor = [UIColor whiteColor];
    _tableview.tableHeaderView = _headview;
    
    _numberL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 80*scale_h)];
    _numberL.font = [UIFont boldSystemFontOfSize:30*scale_h];
    _numberL.textColor = kOrangeRed;
    _numberL.textAlignment = NSTextAlignmentCenter;
    _numberL.adjustsFontSizeToFitWidth = YES;
    [_headview addSubview:_numberL];
    
    _numberL.text = [NSString stringWithFormat:@"+%@",@"3.0977633333"];
  
    
    
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TradingDetailsCell *tradingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TradingDetailsCell class]) forIndexPath:indexPath];
    tradingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tradingCell setTypeName:_typeArr[indexPath.row] value:@"2222222" row:indexPath.row];
    return tradingCell;
    
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
       // _tableview.sectionIndexColor = kBlueColor;
        //_tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
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
