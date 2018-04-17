//
//  CoinTypeController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

//    "account35" = "添加币种";
//    "account36" = "选择币种";

#import "CoinTypeController.h"
#import "CoinTypeViewCell.h"
#import "CoinTypeModel.h"


@interface CoinTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation CoinTypeController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    [self getDataFromNetWorkForCoinType:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account35");
    
    _dataArr = [NSMutableArray arrayWithCapacity:10];
    [self.view addSubview:self.tableview];
    //    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[CoinTypeViewCell class] forCellReuseIdentifier:NSStringFromClass([CoinTypeViewCell class])];
}

#pragma mark - 获取 所有币种 信息接口
- (void)getDataFromNetWorkForCoinType:(NSInteger)type{
    if (type == 1) {
        [self startLoading];
        
    }
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               };
    DebugLog(@"%@\n%@",paramter,Api_getallcurrencylist);
    [MHHttpTool POST:Api_getallcurrencylist parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {

            [_dataArr addObjectsFromArray:responseDic[@"result"]];
            [_tableview reloadData];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}



#pragma mark - 增加货币接口
- (void)addOrDeleteForCoinType:(NSDictionary *)dic{
    [self startLoading];
    //1：用户选中  0：用户未选  ischecked
    NSString *ischecked = [NSString stringWithFormat:@"%@",dic[@"ischecked"]];
    NSString *type = @"1";
    if ([ischecked isEqualToString:@"1"]) {
        type = @"2";
    }
    
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               @"currencyid" : dic[@"currencyid"],
                               @"type" : type,  //ype=1代表增加 type=2代表删除
                               };
    DebugLog(@"%@\n%@",paramter,Api_setcurrency);
    [MHHttpTool POST:Api_setcurrency parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
            [_dataArr removeAllObjects];
            [_tableview reloadData];
            [self getDataFromNetWorkForCoinType:0];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0.5];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*scale_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CoinTypeViewCell *coinTypeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CoinTypeViewCell class]) forIndexPath:indexPath];
    coinTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    if (_dataArr.count > 0) {
        CoinTypeModel *model = [CoinTypeModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        [coinTypeCell setValueByCoinTypeModel:model];
    }
    return coinTypeCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count > 0) {
        [self addOrDeleteForCoinType:_dataArr[indexPath.row]];
    }
}

#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-KBottom-kTop)  style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableview.sectionIndexColor = kBlueColor;
        //        _tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
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
