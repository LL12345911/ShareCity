//
//  SelectCoinTypeController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/12.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "SelectCoinTypeController.h"
#import "SelectCoinTypeCell.h"
#import "SelectCoinTypeModel.h"

@interface SelectCoinTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArr;



@end

@implementation SelectCoinTypeController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    [self getDataFromNetWorkForSelectCoinType];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account36");
    _dataArr = [NSMutableArray arrayWithCapacity:10];
    
    [self.view addSubview:self.tableview];
    //    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[SelectCoinTypeCell class] forCellReuseIdentifier:NSStringFromClass([SelectCoinTypeCell class])];
}

#pragma mark - 常用 钱包地址
- (void)getDataFromNetWorkForSelectCoinType{
    [self startLoading];
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_getcurrencylist);
    [MHHttpTool POST:Api_getcurrencylist parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
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
    
    SelectCoinTypeCell *coinTypeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SelectCoinTypeCell class]) forIndexPath:indexPath];
    coinTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count > 0) {
        SelectCoinTypeModel *model = [SelectCoinTypeModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        [coinTypeCell setValueByCoinTypeModel:model];
    }
    return coinTypeCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count > 0) {
        if ([self.delegate respondsToSelector:@selector(selectCoinTypeWithValue:)]) {
            [self.delegate selectCoinTypeWithValue:_dataArr[indexPath.row]];
            [self.navigationController popViewControllerAnimated:YES];
        }
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
