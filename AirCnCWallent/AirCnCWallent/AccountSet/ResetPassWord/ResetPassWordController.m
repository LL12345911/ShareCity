//
//  ResetPassWordController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "ResetPassWordController.h"

#import "UIButton+Countdown.h"
#import "MainTabBarController.h"
#import "TDButton.h"
#import "AreasController.h"
#import "UIButton+Countdown.h"

@interface ResetPassWordController ()<AreasForMobileDalagate>

@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UIButton *phoneSelect;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UITextField *payText;
@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) UITextField *pay2Text;
@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, copy) NSString *mobileArea;


@end

@implementation ResetPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"login34");
    
    _mobileArea = @"+86";
    [self setView];
    
}

#pragma mark - 选择地区
- (void)selectPhoneAreas{
    AreasController *areas = [[AreasController alloc] init];
    areas.delegate = self;
    [self.navigationController pushViewController:areas animated:YES];
    
}
#pragma mark - 选择地区 代理
- (void)returnAreasForMobileInfoDic:(NSDictionary *)infoDic{
    _mobileArea = [NSString stringWithFormat:@"+%@",infoDic[@"country_code"]];
    [_phoneSelect setTitle:[NSString stringWithFormat:@"%@ ",_mobileArea] forState:0];
//    _phoneSelect.titleLabel.adjustsFontSizeToFitWidth = YES;
}


- (void)setView{
    
    [self.view addSubview:self.topTitle];
    [self.view addSubview:self.phoneSelect];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.line];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.payText];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.pay2Text];
    [self.view addSubview:self.line4];
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.okBtn];
    
}

- (void)resetPassword{
    [self.view endEditing:YES];
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login22") withView:self.view withDelay:2];//请输入手机号
        return;
    }
    if (_codeText.text.length == 0) {
        [HUDTools showText:GetString(@"login23") withView:self.view withDelay:2];//请输入短信验证码
        return;
    }
    
    if (_payText.text.length == 0) {
        [HUDTools showText:GetString(@"login36") withView:self.view withDelay:2]; //请新人密码
        return;
    }
    if (_pay2Text.text.length == 0) {
        [HUDTools showText:GetString(@"login37") withView:self.view withDelay:2]; //请新人密码
        return;
    }
    
    if (![_payText.text isEqualToString:_pay2Text.text]) {
        [HUDTools showText:@"密码不一致,请检查两次密码是否一致" withView:self.view withDelay:2];
        return;
    }
    
    [self startLoading];
    
    //
    NSString *token = [Helper getValueForKey:USER_Token];
    
    
    NSString* phone = [NSString stringWithFormat:@"%@%@",_mobileArea,_phoneText.text];
    NSDictionary *paramter = @{@"mobileno" : phone,  //电话号码
                               @"verificationcode" : _codeText.text, //4交易密码验证码
                               @"password" : _payText.text, //交易密码
                               @"confirmpassword" : _pay2Text.text, //确认密码
                               @"type" : @"1",//1代表 登陆密码  2代表修改交易密码 3设置交易密码
                               @"token" : token,
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_resetpwd);
    [MHHttpTool POST:Api_resetpwd parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2.0];
        }
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}

#pragma mark - 发送短信验证码
- (void)clickSendSMS{
    [self.view endEditing:YES];
    
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login22") withView:self.view withDelay:2];//请输入手机号
        return;
    }
    [self startLoading];
//    [_sendBtn startCountDownTime:60 textNormalColor:[UIColor whiteColor] textColor:[UIColor whiteColor] withCountDownBlock:^{
//        NSLog(@"开始倒计时");
//        //此处发送验证码等操作
//        //................
//    }];
    //   type有：1注册短信验证码  2 修改密码短信验证码  3 登录验证码  4交易密码验证码
    NSString* phone = [NSString stringWithFormat:@"%@%@",_mobileArea,_phoneText.text];
    NSDictionary *paramter = @{@"mobileno" : phone,  //电话号码
                               @"type" : @"2", //4交易密码验证码
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_mobilecode);
    [MHHttpTool POST:Api_mobilecode parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0];
        if ([code isEqualToString:@"0"]) {
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2.0];
            [_sendBtn startCountDownTime:60 textNormalColor:[UIColor whiteColor] textColor:[UIColor whiteColor] withCountDownBlock:^{
                NSLog(@"开始倒计时");
                //此处发送验证码等操作
                //................
            }];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2.0];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0.5];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];

    
}


#pragma mark - 懒加载

- (UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+10, kWidth-40, 70*scale_h)];
        _topTitle.text =  GetString(@"login35");
        _topTitle.font = [UIFont systemFontOfSize:30*scale_h];
        _topTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _topTitle;
}


- (UIButton *)phoneSelect{
    if (!_phoneSelect) {
        _phoneSelect = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleRight];
        _phoneSelect.frame = CGRectMake(10, _topTitle.bottom, 50*scale_h+10, 50*scale_h);
        //_phoneSelect.frame = CGRectMake(_phoneText.right, _topView.bottom, kWidth-20-_phoneText.right, 50*scale_h);
        [_phoneSelect setTitle:@"+86  " forState:0];
        [_phoneSelect setTitleColor:kBlackColor forState:0];
        _phoneSelect.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _phoneSelect.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_phoneSelect setImage:[UIImage imageNamed:@"竖线"] forState:UIControlStateNormal];
        [_phoneSelect addTarget:self action:@selector(selectPhoneAreas) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneSelect;
}


- (UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(20+60*scale_h, _topTitle.bottom, kWidth-140-60*scale_h, 50*scale_h)];
        _phoneText.borderStyle = UITextBorderStyleNone;
        _phoneText.placeholder = GetString(@"login22");
        _phoneText.font = [UIFont systemFontOfSize:15*scale_h];
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneText;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(20, _phoneText.bottom, kWidth-40, 1)];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}

- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc] initWithFrame:CGRectMake(20, _line.bottom, kWidth-40, 50*scale_h)];
        _codeText.borderStyle = UITextBorderStyleNone;
        _codeText.placeholder = GetString(@"login23");
        _codeText.font = [UIFont systemFontOfSize:15*scale_h];
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeText;
}

- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(20, _codeText.bottom, kWidth-40, 1)];
        _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line2;
}

- (UITextField *)payText{
    if (!_payText) {
        _payText = [[UITextField alloc] initWithFrame:CGRectMake(20, _line2.bottom, kWidth-40, 50*scale_h)];
        _payText.borderStyle = UITextBorderStyleNone;
        _payText.placeholder = GetString(@"login36");
        _payText.font = [UIFont systemFontOfSize:15*scale_h];
        _payText.keyboardType = UIKeyboardTypeASCIICapable;
        _payText.secureTextEntry = YES;
    }
    return _payText;
}

- (UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] initWithFrame:CGRectMake(20, _payText.bottom, kWidth-40, 1)];
        _line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line3;
}

- (UITextField *)pay2Text{
    if (!_pay2Text) {
        _pay2Text = [[UITextField alloc] initWithFrame:CGRectMake(20, _line3.bottom, kWidth-40, 50*scale_h)];
        _pay2Text.borderStyle = UITextBorderStyleNone;
        _pay2Text.placeholder = GetString(@"login37");
        _pay2Text.font = [UIFont systemFontOfSize:15*scale_h];
        _pay2Text.secureTextEntry = YES;
        _pay2Text.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _pay2Text;
}

- (UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc] initWithFrame:CGRectMake(20, _pay2Text.bottom, kWidth-40, 1)];
        _line4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line4;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-120, _topTitle.bottom+15*scale_h, 100, 20*scale_h)];
        [_sendBtn setTitle:GetString(@"login21") forState:0];
        _sendBtn.backgroundColor = kOrangeRed;
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:12*scale_h];
        _sendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_sendBtn addTarget:self action:@selector(clickSendSMS) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}


- (UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _line4.bottom+30*scale_h, kWidth-40, 40*scale_h)];
        [_okBtn setTitle:GetString(@"login15") forState:0];
        _okBtn.backgroundColor = kNavColor;
        _okBtn.layer.cornerRadius = 5;
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _okBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_okBtn addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
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
