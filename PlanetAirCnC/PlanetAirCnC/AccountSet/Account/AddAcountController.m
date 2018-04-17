//
//  AddAcountController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "AddAcountController.h"
//#import "TDButton.h"
//#import "CoinTypeController.h"
#import "SelectCoinTypeController.h"


@interface AddAcountController ()<SelectCoinTypeDelegate>

@property (nonatomic, strong) UILabel *coinType;
@property (nonatomic, strong) UIButton *selectCoin;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UITextField *assetName;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UITextField *assetAdd;
@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UsedAccountModel *model;
@property (nonatomic, copy) NSString *currency_id;

@end

@implementation AddAcountController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _currency_id = @"0";
    self.view.backgroundColor = [UIColor whiteColor];
    if ([_accountType isEqualToString:@"2"]) {//
        self.customNavBar.title = GetString(@"account37");//@"修改账户";
    }else{
        self.customNavBar.title = GetString(@"account30");//@"添加账户";
    }
    
    [self.view addSubview:self.coinType];
    [self.view addSubview:self.selectCoin];
    [self.view addSubview:self.line];
    [self.view addSubview:self.assetName];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.assetAdd];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.addBtn];
    
    if ([_accountType isEqualToString:@"2"]) {
        _coinType.text = _model.currency_name_cn;
        _assetName.text = _model.walletname;
        _assetAdd.text = _model.walletpath;
    }
    
}

- (void)setValueUsedAccountModel:(UsedAccountModel *)model{
    _model = model;
}


#pragma mark - 创建修改 钱包地址
- (void)addAcountMethod{
    [self.view endEditing:YES];
    
    if (![_accountType isEqualToString:@"2"]) {
        if ([_currency_id isEqualToString:@"0"]) {
            [HUDTools showText:GetString(@"account31") withView:self.view withDelay:2];//
            return;
        }
    }
    if (_assetName.text.length == 0) {
        [HUDTools showText:GetString(@"account32") withView:self.view withDelay:2];//
        return;
    }
    if (_assetAdd.text.length == 0) {
        [HUDTools showText:GetString(@"account33") withView:self.view withDelay:2]; //
        return;
    }
    
    [self startLoading];
    
    NSString *walletid = @"";
    if ([_accountType isEqualToString:@"2"]) {
        walletid = _model.walletId;
    }else{
        walletid = @"0";
    }
    
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               @"walletid" : walletid,
                               @"walletname" : _assetName.text,
                               @"walletpath" : _assetAdd.text,
                               @"currency_id" : _currency_id,
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_editpurseassetsinfo);
    [MHHttpTool POST:Api_editpurseassetsinfo parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}
    

#pragma mark - 选择币种
- (void)addCoinType{
     if ([_accountType isEqualToString:@"2"]) {
         [HUDTools showText:@"修改时，不允许更改币种" withView:self.view withDelay:2.0];
         return;
     }
    SelectCoinTypeController *coinView = [[SelectCoinTypeController alloc] init];
//    coinView.coinType = @"2";
    coinView.delegate = self;
    [self.navigationController pushViewController:coinView animated:YES];
    
}

- (void)selectCoinTypeWithValue:(NSDictionary *)value{
    DebugLog(@"选择币种 %@",value);
    _coinType.text = [NSString stringWithFormat:@"%@",value[@"currencyname"]];
    _currency_id = [NSString stringWithFormat:@"%@",value[@"currencyid"]];

}

#pragma mark -懒加载

- (UILabel *)coinType{
    if (!_coinType) {
        _coinType = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop, kWidth-100, 60*scale_h)];
        _coinType.text = GetString(@"account31");
        _coinType.textColor = kGrayColor;
        _coinType.font = [UIFont systemFontOfSize:15*scale_h];
    }
    return _coinType;
}


- (UIButton *)selectCoin{
    if (!_selectCoin) {
        _selectCoin = [[UIButton alloc] initWithFrame:CGRectMake(0, kTop, kWidth-20, 60*scale_h)];
        [_selectCoin setImage:[UIImage imageNamed:@"返回拷贝"] forState:0];
        _selectCoin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_selectCoin addTarget:self action:@selector(addCoinType) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectCoin;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _coinType.bottom, kWidth, 1)];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}

- (UITextField *)assetName{
    if (!_assetName) {
        _assetName = [[UITextField alloc] initWithFrame:CGRectMake(20, _line.bottom, kWidth-40, 60*scale_h)];
        _assetName.borderStyle = UITextBorderStyleNone;
        _assetName.placeholder = GetString(@"account32");
        _assetName.font = [UIFont systemFontOfSize:15*scale_h];
        [_assetName setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _assetName;
}

- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _assetName.bottom, kWidth, 1)];
        _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line2;
}

- (UITextField *)assetAdd{
    if (!_assetAdd) {
        _assetAdd = [[UITextField alloc] initWithFrame:CGRectMake(20, _line2.bottom, kWidth-40, 60*scale_h)];
        _assetAdd.borderStyle = UITextBorderStyleNone;
        _assetAdd.placeholder = GetString(@"account33");
        _assetAdd.font = [UIFont systemFontOfSize:15*scale_h];
        [_assetAdd setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        _assetAdd.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _assetAdd;
}

- (UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] initWithFrame:CGRectMake(0, _assetAdd.bottom, kWidth, 1)];
        _line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line3;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 50*scale_h+_line3.bottom, kWidth-60, 50*scale_h)];
        _addBtn.backgroundColor = kNavColor;
        _addBtn.layer.cornerRadius = 5;
        if ([_accountType isEqualToString:@"2"]) {
            [_addBtn setTitle:GetString(@"account29") forState:0];
        }else{
            [_addBtn setTitle:GetString(@"account34") forState:0];
        }
        [_addBtn addTarget:self action:@selector(addAcountMethod) forControlEvents:UIControlEventTouchUpInside];
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
