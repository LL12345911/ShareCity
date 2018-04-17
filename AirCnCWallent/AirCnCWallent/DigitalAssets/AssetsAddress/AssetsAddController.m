//
//  AssetsAddController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

//常用账户

#import "AssetsAddController.h"
#import "AssetsAddCell.h"
#import "TDButton.h"
#import "PopView.h"


@interface AssetsAddController ()<UITableViewDelegate,UITableViewDataSource,PopViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) PopView *popView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSString *currency_id;//

@end

@implementation AssetsAddController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    [self getDataFromNetWorkForSelectCoinType];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account27");//@"常用账户";
    [self.view addSubview:self.tableview];
    _dataArr = [NSMutableArray arrayWithCapacity:10];
    _currency_id = @"0";
    [_tableview registerClass:[AssetsAddCell class] forCellReuseIdentifier:NSStringFromClass([AssetsAddCell class])];
    [self setAssetsAddHeaderView];
}

#pragma mark - 常用 钱包地址
- (void)getDataFromNetWorkForSelectCoinType{
    [self startLoading];
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               @"currency_id" : _currency_id,
                               };
    DebugLog(@"%@\n%@",paramter,Api_getpurseassetslist);
    [MHHttpTool POST:Api_getpurseassetslist parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0];
        if ([code isEqualToString:@"0"]) {
            
            [_dataArr addObjectsFromArray:responseDic[@"result"]];
            [_tableview reloadData];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}


#pragma mark - 下拉视图
- (void)dropDownView{
    [self getDataFromNetWorkForCoinType];
}



#pragma mark - 币种
- (void)getDataFromNetWorkForCoinType{
    [self startLoading];
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               };
    DebugLog(@"%@\n%@",paramter,Api_getcurrencylist);
    [MHHttpTool POST:Api_getcurrencylist parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0];
        if ([code isEqualToString:@"0"]) {
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
            [arr addObjectsFromArray:responseDic[@"result"]];
            
            self.popView = [[PopView alloc] init];
            self.popView.delegate = self;
            [self.popView showPayPopView:arr];
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}

//  ***********  协议(procotol) 定义方法（函数） ***********  //
- (void) selectCoinTypeWithValue:(NSDictionary *)dic{
    [self.popView hidePayPopView];
    _currency_id = dic[@"currencyid"];
    [_selectBtn setTitle:dic[@"currencyname"] forState:0];

    
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    
    [self getDataFromNetWorkForSelectCoinType];
    
    DebugLog(@"222222");
}

- (void)setAssetsAddHeaderView{
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 100*scale_h)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _headView.userInteractionEnabled = YES;
    _tableview.tableHeaderView = _headView;
    
    _selectBtn = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleCenter];
    _selectBtn.frame = CGRectMake(0, 25*scale_h, kWidth, 50*scale_h);
    [_selectBtn setTitle:GetString(@"digital35") forState:0];
    [_selectBtn setTitleColor:kNavColor forState:0];
    _selectBtn.titleLabel.font = [UIFont systemFontOfSize:17*scale_h];
    _selectBtn.backgroundColor = [UIColor whiteColor];
    [_selectBtn setTitleColor:kNavColor forState:0];
    [_selectBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(dropDownView) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_selectBtn];
    
}

#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AssetsAddCell *accountCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AssetsAddCell class]) forIndexPath:indexPath];
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    accountCell.delegate = self;
    if (_dataArr.count > 0) {
        UsedAccountModel *model = [UsedAccountModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        [accountCell setValueByUsedAccountModel:model];
    }

    
    return accountCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(clickOnAssetsAddressWithValue:)]) {
        [self.delegate clickOnAssetsAddressWithValue:_dataArr[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
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
