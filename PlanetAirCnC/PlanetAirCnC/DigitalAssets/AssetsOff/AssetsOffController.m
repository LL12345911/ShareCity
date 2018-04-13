//
//  AssetsOffController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//


//资产转出


#import "AssetsOffController.h"
#import "HyperlinksButton.h"
#import "UIButton+Countdown.h"
#import "AssetsAddController.h"
#import "MMScanViewController.h"

#import "MarsDefines.h"
#import "PayPopupView.h"

@interface AssetsOffController ()<UITableViewDelegate,UITableViewDataSource,AssetsAddressDeletage,PayPopupViewDelegate>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIView *headview;

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *asset;
@property (nonatomic,strong) UITextField *assetAdd;
//@property (nonatomic,strong) UITextView *assetAdd;


@property (nonatomic,strong) HyperlinksButton *textCopyBtn;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIButton *scanBtn;
//提取数量
@property (nonatomic,strong) UILabel *remain;
@property (nonatomic,strong) UILabel *remainCoin;
@property (nonatomic,strong) UIView *remainView;
@property (nonatomic,strong) UITextField *remainText;
@property (nonatomic,strong) UILabel *remainDesc;
//手机验证码
@property (nonatomic,strong) UILabel *code;
@property (nonatomic,strong) UIView *codeView;
@property (nonatomic,strong) UITextField *codeText;
@property (nonatomic,strong) UIButton *codeBtn;
//矿工费
@property (nonatomic,strong) UILabel *fee;
@property (nonatomic,strong) UIView *feeView;
@property (nonatomic,strong) UITextField *feeText;
//转出 按钮
@property (nonatomic,strong) UIButton *rollOutBtn;
//支付界面
@property (nonatomic, strong) PayPopupView *payPopupView;

@property (nonatomic, copy) NSString *paywdStr;

@end

@implementation AssetsOffController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"digital15");//@"资产转出";
    
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
  
    [self setAssetsOffHeaderView];
    
    [self.view addSubview:self.rollOutBtn];
    
    
}


#pragma mark - 从粘贴板获取内容
- (void)getContentFromUIPasteboard{
    UIPasteboard* pBoard=[UIPasteboard generalPasteboard];
    if(pBoard!=NULL){
        NSString* pNsStr=pBoard.string;
        if(pNsStr!=NULL){
            self.assetAdd.text = pNsStr;
        }else{
            NSLog(@"pBoard.string is null");
            [self showInfo:@"未复制"];
        }
    }else{
        NSLog(@"UIPasteboard pBoard is null");
        [self showInfo:@"未复制"];
    }
}


#pragma mark - 选择地址
- (void)getContentFromAssetsAddress{
    AssetsAddController *assetAdd = [[AssetsAddController alloc] init];
    assetAdd.delegate = self;
    [self.navigationController pushViewController:assetAdd animated:YES];
}

//  ***********  数字资产 常用地址 协议(procotol) 定义方法（函数） ***********  //

- (void) clickOnAssetsAddressWithValue:(NSDictionary *)value{
    _assetAdd.text = value[@"walletpath"];
}


#pragma mark - 扫一扫
- (void)getContentFromScanPhoto{
    
    __block typeof(self) weakSelf = self;
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            NSLog(@"扫描结果：%@",result);
            //[self showInfo:result];
            weakSelf.assetAdd.text = result;
        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
}


#pragma mark - Error handle
- (void)showInfo:(NSString*)str {
    [self showInfo:str andTitle:@"提示"];
}

- (void)showInfo:(NSString*)str andTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
        action;
    });
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - 提取
- (void)extractAssetsCoin{
    
    self.payPopupView = [[PayPopupView alloc] init];
    self.payPopupView.delegate = self;
    [self.payPopupView showPayPopView];
    
    
//   PayView *payView = [[PayView alloc] initWithFrame:(CGRect){0, 0, kWidth, kHeight}];
//    //payView.delegate = self;
//    [payView showInView:self.tabBarController.view];
    
    
    
}


#pragma mark - PayPopupViewDelegate

- (void)didClickFinishPasswordButton{
     NSLog(@"支付密码 ==  %@",_paywdStr);
//    [self.payPopupView didInputPayPasswordError];
    NSLog(@"点击了忘记密码");
}

- (void)didPasswordInputFinished:(NSString *)password{
    _paywdStr = password;
    
//    if ([password isEqualToString:@"147258"]){
//        NSLog(@"输入的密码正确");
//    }else{
//        NSLog(@"输入错误:%@",password);
//        [self.payPopupView didInputPayPasswordError];
//    }
}




#pragma mark - 短信验证码
- (void)getContentFromSMS{
    //倒计时(如果按钮倒计时出现闪烁，将xib或者storyboard中Type属性设置为custom即可)
    [_codeBtn startCountDownTime:60 textNormalColor:kOrangeRed textColor:kGrayColor withCountDownBlock:^{
        NSLog(@"开始倒计时");
        //此处发送验证码等操作
        //................
        
    }];
}



- (void)setAssetsOffHeaderView{
    _headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 620*scale_h)];
    _headview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headview;
    

    [_headview addSubview:self.topView];
    [_topView addSubview:self.asset];
    [_topView addSubview:self.assetAdd];
    [_topView addSubview:self.textCopyBtn];
    [_topView addSubview:self.selectBtn];
    [_topView addSubview:self.scanBtn];
    
    //提取数量
    [_headview addSubview:self.remain];
    [_headview addSubview:self.remainCoin];
    [_headview addSubview:self.remainView];
    [_headview addSubview:self.remainText];
    [_headview addSubview:self.remainDesc];
    
    //手机验证码
    [_headview addSubview:self.code];
    [_headview addSubview:self.codeView];
    [_headview addSubview:self.codeText];
    
    _codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-20-100, _code.bottom, 90, 50*scale_h)];
    [_codeBtn setTitle:GetString(@"digital27") forState:0];
    [_codeBtn setTitleColor:kOrangeRed forState:0];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:12*scale_h];
//    _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _codeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_codeBtn addTarget:self action:@selector(getContentFromSMS) forControlEvents:UIControlEventTouchUpInside];
    [_headview addSubview:self.codeBtn];
    
    
    //矿工费
    [_headview addSubview:self.fee];
    [_headview addSubview:self.feeView];
    [_headview addSubview:self.feeText];
    
    _remainCoin.attributedText = [self setAttributedNum:@"34.9877"];
    
}



- (NSMutableAttributedString *)setAttributedNum:(NSString *)number{
    
    //    "digital21" = "剩余";
    //    "digital22" = "币";
    
    NSString* str1 = GetString(@"digital21");
    NSString* str3 = GetString(@"digital22");
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",str1,number,str3]];
    
    NSRange rangle1 = NSMakeRange(0, str1.length);
    NSRange rangle2 = NSMakeRange(str1.length, number.length);
    NSRange rangle3 = NSMakeRange(strAtt.length-str3.length, str3.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle1];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle1];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:rangle2];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle3];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle3];
    
    return strAtt;
}


#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*scale_h;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *assetCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    assetCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return assetCell;
}

#pragma mark -懒加载

- (UIButton *)rollOutBtn{
    if (!_rollOutBtn) {
        _rollOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kHeight-KBottom-50*scale_h, kWidth, 50*scale_h)];
        [_rollOutBtn setTitle:GetString(@"account42") forState:0];
//        [_rollOutBtn setTitleColor:kGrayColor forState:0];
        _rollOutBtn.backgroundColor = kNavColor;
        _rollOutBtn.titleLabel.font = [UIFont systemFontOfSize:17*scale_h];
        _rollOutBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_rollOutBtn addTarget:self action:@selector(extractAssetsCoin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rollOutBtn;
}


- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 220*scale_h)];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.layer.cornerRadius = 5;
        _topView.layer.masksToBounds = YES;
    }
    return _topView;
}

- (UILabel *)asset{
    if (!_asset) {
        _asset = [[UILabel alloc] initWithFrame:CGRectMake(0, 10*scale_h, kWidth-40, 30*scale_h)];
        _asset.font = [UIFont systemFontOfSize:17*scale_h];
        _asset.textColor = kGrayColor;
        _asset.text = GetString(@"digital16");
        _asset.textAlignment = NSTextAlignmentCenter;
        _asset.adjustsFontSizeToFitWidth = YES;
    }
    return _asset;
}

//- (UITextView *)assetAdd{
//    if (!_assetAdd) {
//        _assetAdd = [[UITextView alloc] initWithFrame:CGRectMake(10, 40*scale_h, kWidth-60, 50*scale_h)];
////        _assetAdd.borderStyle = UITextBorderStyleRoundedRect;
////        _assetAdd.placeholder = GetString(@"digital34");//
//        _assetAdd.textColor = kOrangeColor;
//        _assetAdd.font = [UIFont systemFontOfSize:13*scale_h];
//        _assetAdd.layer.cornerRadius = 3;
//        _assetAdd.layer.masksToBounds = YES;
//
////        _assetAdd.adjustsFontSizeToFitWidth = YES;
////        _assetAdd.minimumFontSize = 1;
////        _assetAdd.adjustsFontSizeToFitWidth = YES;
//        //_assetAdd.keyboardType = UIKeyboardTypeNumberPad;
//        [_assetAdd setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
//    }
//    return _assetAdd;
//}
- (UITextField *)assetAdd{
    if (!_assetAdd) {
        _assetAdd = [[UITextField alloc] initWithFrame:CGRectMake(10, 40*scale_h, kWidth-60, 40*scale_h)];
        _assetAdd.borderStyle = UITextBorderStyleRoundedRect;
        _assetAdd.placeholder = GetString(@"digital34");//
        _assetAdd.textColor = kOrangeColor;
        _assetAdd.font = [UIFont systemFontOfSize:13*scale_h];
        _assetAdd.adjustsFontSizeToFitWidth = YES;
         _assetAdd.minimumFontSize = 1;
        _assetAdd.adjustsFontSizeToFitWidth = YES;
        //_assetAdd.keyboardType = UIKeyboardTypeNumberPad;
        [_assetAdd setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _assetAdd;
}

- (HyperlinksButton *)textCopyBtn{
    if (!_textCopyBtn) {
        _textCopyBtn = [[HyperlinksButton alloc] initWithFrame:CGRectMake(30, 100*scale_h, kWidth-100, 40*scale_h)];
        [_textCopyBtn setTitle:GetString(@"digital17") forState:0];
        [_textCopyBtn setTitleColor:kGrayColor forState:0];
        [_textCopyBtn setColor:kGrayColor];
        _textCopyBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        [_textCopyBtn addTarget:self action:@selector(getContentFromUIPasteboard) forControlEvents:UIControlEventTouchUpInside];
    }
    return _textCopyBtn;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        CGFloat w = (kWidth-40-60)/2.0;
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 160*scale_h, w, 30*scale_h)];
        [_selectBtn setTitle:GetString(@"digital18") forState:0];
        [_selectBtn setTitleColor:kGrayColor forState:0];
        _selectBtn.layer.cornerRadius = 15*scale_h;
        _selectBtn.layer.borderWidth =1;
        _selectBtn.layer.borderColor = kGrayColor.CGColor;
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _selectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_selectBtn addTarget:self action:@selector(getContentFromAssetsAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


- (UIButton *)scanBtn{
    if (!_scanBtn) {
        CGFloat w = (kWidth-40-60)/2.0;
        _scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(40+w, 160*scale_h, w, 30*scale_h)];
        [_scanBtn setTitle:GetString(@"digital19") forState:0];
        [_scanBtn setTitleColor:kGrayColor forState:0];
        _scanBtn.layer.cornerRadius = 15*scale_h;
        _scanBtn.layer.borderWidth =1;
        _scanBtn.layer.borderColor = kGrayColor.CGColor;
        _scanBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _scanBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_scanBtn addTarget:self action:@selector(getContentFromScanPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanBtn;
}

//提取数量

- (UILabel *)remain{
    if (!_remain) {
        _remain = [[UILabel alloc] initWithFrame:CGRectMake(20, _topView.bottom, kWidth-40, 50*scale_h)];
        _remain.font = [UIFont systemFontOfSize:17*scale_h];
        _remain.textColor = kBlackColor;
        _remain.text = GetString(@"digital20");
        _remain.textAlignment = NSTextAlignmentLeft;
        _remain.adjustsFontSizeToFitWidth = YES;
    }
    return _remain;
}

- (UILabel *)remainCoin{
    if (!_remainCoin) {
        _remainCoin = [[UILabel alloc] initWithFrame:CGRectMake(0, _topView.bottom, kWidth-20, 50*scale_h)];
        _remainCoin.textAlignment = NSTextAlignmentRight;
        _remainCoin.adjustsFontSizeToFitWidth = YES;
    }
    return _remainCoin;
}

- (UIView *)remainView{
    if (!_remainView) {
        _remainView = [[UIView alloc] initWithFrame:CGRectMake(20, _remainCoin.bottom, kWidth-40, 50*scale_h)];
        _remainView.layer.cornerRadius = 3;
        _remainView.layer.masksToBounds = YES;
        _remainView.backgroundColor = [UIColor whiteColor];
    }
    return _remainView;
}

- (UITextField *)remainText{
    if (!_remainText) {
        _remainText = [[UITextField alloc] initWithFrame:CGRectMake(30, _remainCoin.bottom, kWidth-60, 50*scale_h)];
        _remainText.placeholder = GetString(@"digital23");//
        _remainText.textColor = kOrangeColor;
        _remainText.font = [UIFont systemFontOfSize:17*scale_h];
        _remainText.adjustsFontSizeToFitWidth = YES;
        _remainText.keyboardType = UIKeyboardTypeDecimalPad;
        [_remainText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _remainText;
}

- (UILabel *)remainDesc{
    if (!_remainDesc) {
        _remainDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, _remainText.bottom, kWidth-40, 30*scale_h)];
        _remainDesc.font = [UIFont systemFontOfSize:13*scale_h];
        _remainDesc.textColor = kGrayColor;
        _remainDesc.text = GetString(@"digital24");
        _remainDesc.textAlignment = NSTextAlignmentLeft;
        _remainDesc.adjustsFontSizeToFitWidth = YES;
    }
    return _remainDesc;
}

//手机验证码
- (UILabel *)code{
    if (!_code) {
        _code = [[UILabel alloc] initWithFrame:CGRectMake(20, _remainDesc.bottom, kWidth-40, 50*scale_h)];
        _code.font = [UIFont systemFontOfSize:17*scale_h];
        _code.textColor = kBlackColor;
        _code.text = GetString(@"digital25");
        _code.textAlignment = NSTextAlignmentLeft;
        _code.adjustsFontSizeToFitWidth = YES;
    }
    return _code;
}

- (UIView *)codeView{
    if (!_codeView) {
        _codeView = [[UIView alloc] initWithFrame:CGRectMake(20, _code.bottom, kWidth-40, 50*scale_h)];
        _codeView.layer.cornerRadius = 3;
        _codeView.layer.masksToBounds = YES;
        _codeView.userInteractionEnabled = YES;
        _codeView.backgroundColor = [UIColor whiteColor];
    }
    return _codeView;
}

- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc] initWithFrame:CGRectMake(30, _code.bottom, kWidth-60-90, 50*scale_h)];
        _codeText.placeholder = GetString(@"digital26");//
        _codeText.textColor = kOrangeColor;
        _codeText.font = [UIFont systemFontOfSize:17*scale_h];
        _codeText.adjustsFontSizeToFitWidth = YES;
        _codeText.keyboardType = UIKeyboardTypeDecimalPad;
        [_codeText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    return _codeText;
}


//
//_codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-20-100, _code.bottom, 90, 50*scale_h)];
//[_codeBtn setTitle:GetString(@"digital27") forState:0];
//[_codeBtn setTitleColor:kOrangeRed forState:0];
//_codeBtn.titleLabel.font = [UIFont systemFontOfSize:12*scale_h];
////    _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//_codeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//[_codeBtn addTarget:self action:@selector(getContentFromSMS) forControlEvents:UIControlEventTouchUpInside];
//[_headview addSubview:self.codeBtn];


//100+130



//矿工费
- (UILabel *)fee{
    if (!_fee) {
        _fee = [[UILabel alloc] initWithFrame:CGRectMake(20, _codeView.bottom, kWidth-40, 50*scale_h)];
        _fee.font = [UIFont systemFontOfSize:17*scale_h];
        _fee.textColor = kBlackColor;
        _fee.text = GetString(@"digital28");
        _fee.textAlignment = NSTextAlignmentLeft;
        _fee.adjustsFontSizeToFitWidth = YES;
    }
    return _fee;
}

- (UIView *)feeView{
    if (!_feeView) {
        _feeView = [[UIView alloc] initWithFrame:CGRectMake(20, _fee.bottom, kWidth-40, 50*scale_h)];
        _feeView.layer.cornerRadius = 3;
        _feeView.layer.masksToBounds = YES;
        _feeView.userInteractionEnabled = YES;
        _feeView.backgroundColor = [UIColor whiteColor];
    }
    return _feeView;
}

- (UITextField *)feeText{
    if (!_feeText) {
        _feeText = [[UITextField alloc] initWithFrame:CGRectMake(30, _fee.bottom, kWidth-60, 50*scale_h)];
        _feeText.placeholder = GetString(@"digital26");//
        _feeText.textColor = kGrayColor;
        _feeText.font = [UIFont systemFontOfSize:17*scale_h];
        _feeText.adjustsFontSizeToFitWidth = YES;
        _feeText.keyboardType = UIKeyboardTypeDecimalPad;
        [_feeText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        _feeText.enabled = NO;
        
    }
    return _feeText;
}




#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTop-KBottom-50*scale_h)  style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        // _tableview.sectionIndexColor = kBlueColor;
        //_tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
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
