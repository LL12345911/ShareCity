//
//  AddressController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

//常用地址  账户设置 ----》地址簿

#import "CommonAccountController.h"
#import "CommonAccountCell.h"
#import "AddAcountController.h"
#import "UsedAccountModel.h"
#import "TDButton.h"
#import "PopView.h"


@interface CommonAccountController ()<UITableViewDelegate,UITableViewDataSource,AccountUsedDelegate,PopViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UsedAccountModel *model;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSString *currency_id;
@property (nonatomic, strong) PopView *popView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation CommonAccountController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    [self getAcountAddressMethod];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account27");//@"常用账户";
    [self.view addSubview:self.tableview];
//    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[CommonAccountCell class] forCellReuseIdentifier:NSStringFromClass([CommonAccountCell class])];
    
    _currency_id = @"0";
    _dataArr = [NSMutableArray arrayWithCapacity:10];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight-KBottom-60*scale_h, kWidth, 60*scale_h)];
    footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:footView];
    //_tableview.tableFooterView = footView;
    [footView addSubview:self.addBtn];
    
    [self setAssetsAddHeaderView];
}


#pragma mark - 获取常用账户地址
- (void)getAcountAddressMethod{
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


#pragma mark - 选择 币种
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
    
    [self getAcountAddressMethod];
    
    DebugLog(@"222222");
}


- (void)setAssetsAddHeaderView{
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 100*scale_h)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _headView.userInteractionEnabled = YES;
    _tableview.tableHeaderView = _headView;
    
    [_headView addSubview:self.selectBtn];
    
}


#pragma mark - 添加账户
- (void)addAcountMetgod{
    AddAcountController *account = [[AddAcountController alloc] init];
    [self.navigationController pushViewController:account animated:YES];
}


- (void)clickOnModifyBuutonAccountUsedWithIndexPath:(NSIndexPath *)indexPath{
    
    UsedAccountModel *model = [UsedAccountModel yy_modelWithDictionary:_dataArr[indexPath.row]];
    AddAcountController *account = [[AddAcountController alloc] init];
    account.accountType = @"2";
    [account setValueUsedAccountModel:model];
    [self.navigationController pushViewController:account animated:YES];
}


#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonAccountCell *accountCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommonAccountCell class]) forIndexPath:indexPath];
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    accountCell.delegate = self;
    accountCell.indexPath = indexPath;
    if (_dataArr.count > 0) {
        UsedAccountModel *model = [UsedAccountModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        [accountCell setValueByUsedAccountModel:model];
    }
    
    return accountCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_dataArr.count > 0) {
//        if ([self.delegate respondsToSelector:@selector(returnValueCommonUsedAccountInfoDic:)]) {
//            [self.delegate returnValueCommonUsedAccountInfoDic:_dataArr[indexPath.row]];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//
//    }
    
}


#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-KBottom-kTop-60*scale_h)  style:UITableViewStylePlain];
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


- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleCenter];
        _selectBtn.frame = CGRectMake(0, 25*scale_h, kWidth, 50*scale_h);
        [_selectBtn setTitle:GetString(@"digital35") forState:0];
        [_selectBtn setTitleColor:kNavColor forState:0];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:17*scale_h];
        _selectBtn.backgroundColor = [UIColor whiteColor];
        [_selectBtn setTitleColor:kNavColor forState:0];
        [_selectBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(getDataFromNetWorkForCoinType) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectBtn;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
         _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 10*scale_h, kWidth-60, 40*scale_h)];
//        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 50*scale_h, kWidth-60, 40*scale_h)];
        _addBtn.backgroundColor = kNavColor;
        _addBtn.layer.cornerRadius = 5;
        [_addBtn setTitle:GetString(@"account28") forState:0];
        [_addBtn addTarget:self action:@selector(addAcountMetgod) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addBtn;
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
