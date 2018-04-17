//
//  LoginController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "LoginController.h"
#import "UIButton+Countdown.h"
#import "DisplayImageView.h"
#import "MainTabBarController.h"
#import "TDButton.h"
#import "RegisteredController.h"
#import "SMSViewController.h"
#import "RetrievePwdController.h"

#import "PayController.h"
#import "AreasController.h"


#define MSG(msg) [[[UIAlertView alloc]initWithTitle:@"提示" message:(msg) delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];


@interface LoginController ()<DisplayImageViewDeletage,AreasForMobileDalagate>

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *phoneImage;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) UIButton *phoneSelect;

@property (nonatomic, strong) UIImageView *pwdImage;
@property (nonatomic, strong) UITextField *pwdText;
@property (nonatomic, strong) UIView *pwdLine;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *otherLogin;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, copy) NSString *phoneArea;


@end

@implementation LoginController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.customNavBar wr_setBackgroundAlpha:0];
    _phoneArea = @"+86";
    //是否是第一次打开应用
    if ([Helper isFirstOpenApp]) {
        DisplayImageView *view = [[DisplayImageView alloc] initWithFrame:self.view.bounds];
        view.deletage = self;
        [self.view addSubview:view];
    }else{
        [self setHeadView];
    }
}


#pragma mark -  移除版本新特性  加载进入画面
- (void)removeDisplayImageViewFromSuperview{
    [self setHeadView];
}


- (void)setHeadView{

    [self.view addSubview:self.topView];
    [self.view addSubview:self.imageview];
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.phoneImage];
    [self.view addSubview:self.phoneSelect];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.phoneLine];
    [self.view addSubview:self.pwdImage];
    [self.view addSubview:self.pwdText];
    [self.view addSubview:self.pwdLine];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.otherLogin];
    [self.view addSubview:self.registerBtn];

}
#pragma mark - 设置 交易密码
- (void)setPayPassWord{
    PayController *pay = [[PayController alloc] init];
    pay.typeStr = @"3";
    [self.navigationController pushViewController:pay animated:YES];
}

#pragma mark - 登录
- (void)loginMethod{
    [self.view endEditing:YES];
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login02") withView:self.view withDelay:2];//请输入手机号
        return;
    }
    if (_pwdText.text.length == 0) {
        [HUDTools showText:GetString(@"login03") withView:self.view withDelay:2]; //请新人密码
        return;
    }
    
    [self startLoading];

    NSString* phone = [NSString stringWithFormat:@"%@%@",_phoneArea,_phoneText.text];
    NSDictionary *paramter = @{@"mobileno" : phone,
                               @"password" : _pwdText.text,
                               @"uniqueid" : DeviceID,
                               @"clienttype" : @"3",
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_login);
    [MHHttpTool POST:Api_login parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading];
        
        if ([code isEqualToString:@"0"]) {
            NSDictionary *dic2 = [NSDictionary dictionaryWithDictionary:responseDic[@"result"]];
            NSString *token = [NSString stringWithFormat:@"%@",dic2[@"token"]];
//            [Helper setValue:token forKey:USER_Token];
            
            [Helper setValue:token forkey:USER_Token];
            
            NSString *haspaypwd = [NSString stringWithFormat:@"%@",dic2[@"haspaypwd"]];
            if ([haspaypwd isEqualToString:@"0"]) {
                [self setPayPassWord];
            }else{
                [self goToMainViewController];
            }

        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}



#pragma mark - 选择地区
- (void)selectPhoneAreas{
    AreasController *areas = [[AreasController alloc] init];
    areas.delegate = self;
    [self.navigationController pushViewController:areas animated:YES];
}

#pragma mark - 选择地区 代理
- (void)returnAreasForMobileInfoDic:(NSDictionary *)infoDic{
    _phoneArea = [NSString stringWithFormat:@"+%@",infoDic[@"country_code"]];
    [_phoneSelect setTitle:[NSString stringWithFormat:@"%@ ",_phoneArea] forState:0];
}


/**
 进入主界面
 */
#pragma mark - 进入主界面 切换跟视图
- (void)goToMainViewController{
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

#pragma mark - 找回密码
- (void)retrievePwdMethods{
    RetrievePwdController *retrieve = [[RetrievePwdController alloc] init];
    [self.navigationController pushViewController:retrieve animated:YES];
}

#pragma mark - 短信验证码登录
- (void)SMSMethods{
    SMSViewController *sms = [[SMSViewController alloc] init];
    [self.navigationController pushViewController:sms animated:YES];
}
#pragma mark - 注册
- (void)registeredMethods{
    RegisteredController *registerV = [[RegisteredController alloc] init];
    [self.navigationController pushViewController:registerV animated:YES];
}


# pragma mark - 懒加载

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 250*scale_h)];
        _topView.backgroundColor = kNavColor;
    }
    return _topView;
}

- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-100*scale_h)/2, kTop+10*scale_h, 100*scale_h, 100*scale_h)];
        //    _imageview.backgroundColor = [UIColor redColor];
        _imageview.image = [UIImage imageNamed:@"top"];
        _imageview.layer.cornerRadius = 50*scale_h;
        _imageview.layer.masksToBounds = YES;
    }
    return _imageview;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, kTop+110*scale_h, kWidth, 40*scale_h)];
        _titleL.text =  GetString(@"login01");// @"比特币钱包";
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.textColor = [UIColor whiteColor];
    }
    return _titleL;
}
- (UIImageView *)phoneImage{
    if (!_phoneImage) {
        _phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, _topView.height, 30, 50*scale_h)];
        _phoneImage.image = [UIImage imageNamed:@"账户"];
        _phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _phoneImage;
}

- (UIButton *)phoneSelect{
    if (!_phoneSelect) {
        _phoneSelect = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleRight];
        _phoneSelect.frame = CGRectMake(50, _topView.bottom, 50*scale_h+10, 50*scale_h);
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
        _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(50+60*scale_h+10, _topView.height, kWidth-70-60*scale_h-10, 50*scale_h)];
        //_phoneText = [[UITextField alloc] initWithFrame:CGRectMake(60, _topView.height, kWidth-180, 50*scale_h)];
        _phoneText.borderStyle = UITextBorderStyleNone;
        _phoneText.placeholder = GetString(@"login02");// @"请输入手机号";
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
        //[_phoneText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _phoneText;
}

- (UIView *)phoneLine{
    if (!_phoneLine) {
        _phoneLine = [[UIView alloc] initWithFrame:CGRectMake(20, _phoneText.bottom, kWidth-40, 1)];
        _phoneLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _phoneLine;
}

- (UIImageView *)pwdImage{
    if (!_pwdImage) {
        _pwdImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, _phoneLine.bottom, 30, 50*scale_h)];
        _pwdImage.image = [UIImage imageNamed:@"密码"];
        _pwdImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _pwdImage;
}

- (UITextField *)pwdText{
    if (!_pwdText) {
        _pwdText = [[UITextField alloc] initWithFrame:CGRectMake(60, _phoneLine.bottom, kWidth-100, 50*scale_h)];
        _pwdText.borderStyle = UITextBorderStyleNone;
        _pwdText.placeholder = GetString(@"login03");// @"请输入密码";
         _pwdText.secureTextEntry = YES;
            _pwdText.keyboardType = UIKeyboardTypeASCIICapable;
        //[_pwdText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _pwdText;
}

- (UIView *)pwdLine{
    if (!_pwdLine) {
        _pwdLine = [[UIView alloc] initWithFrame:CGRectMake(20, _pwdText.bottom, kWidth-40, 1)];
        _pwdLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _pwdLine;
}


- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _pwdLine.bottom+20*scale_h, kWidth-40, 40*scale_h)];
        [_loginBtn setTitle:GetString(@"login04") forState:0];
        _loginBtn.backgroundColor = kNavColor;
        _loginBtn.layer.cornerRadius = 5;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _loginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_loginBtn addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _loginBtn.bottom+30*scale_h, 150, 30*scale_h)];
        [_forgetBtn setTitle:GetString(@"login05")  forState:0];
        _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_forgetBtn setTitleColor:kGrayColor forState:0];
        //    _forgetBtn.backgroundColor = kNavColor;
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
        _forgetBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_forgetBtn addTarget:self action:@selector(retrievePwdMethods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

- (UIButton *)otherLogin{
    if (!_otherLogin) {
        _otherLogin = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-170, _loginBtn.bottom+30*scale_h, 150, 30*scale_h)];
        [_otherLogin setTitle:GetString(@"login06") forState:0];
        _otherLogin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_otherLogin setTitleColor:kGrayColor forState:0];
        //    _otherLogin.backgroundColor = kNavColor;
        _otherLogin.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
        _otherLogin.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_otherLogin addTarget:self action:@selector(SMSMethods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherLogin;
}
- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, kHeight-50*scale_h-KBottom, kWidth-40, 30*scale_h)];
        [_registerBtn setTitle:GetString(@"login07") forState:0];
        [_registerBtn setTitleColor:kBlackColor forState:0];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        [_registerBtn addTarget:self action:@selector(registeredMethods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
