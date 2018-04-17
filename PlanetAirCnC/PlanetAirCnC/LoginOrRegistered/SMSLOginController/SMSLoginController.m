//
//  SMSLoginController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "SMSLoginController.h"
#import "MainTabBarController.h"
#import "UIButton+Countdown.h"

#import "PayController.h"


@interface SMSLoginController ()

@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UILabel *addlabel;

@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *okBtn;


@end

@implementation SMSLoginController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"login08");// @"验证码登录";
    [self setView];
}

- (void)setView{
    [self.view addSubview:self.topTitle];
    [self.view addSubview:self.addlabel];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.okBtn];
}

#pragma mark - 发送短信验证码
- (void)clickSendSMS{
    [self startLoading];
    //   type有：1注册短信验证码  2 修改密码短信验证码  3 登录验证码  4交易密码验证码
    NSString* phone = [NSString stringWithFormat:@"%@%@",_areaStr,_phoneStr];
    NSDictionary *paramter = @{@"mobileno" : phone,  //电话号码
                               @"type" : @"3", //4交易密码验证码
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
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
}

#pragma mark - 验证码 登录方法
- (void)getApi_smslogin{
    [self.view endEditing:YES];
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login12") withView:self.view withDelay:2];//请输入手机号
        return;
    }
    [self startLoading];
    NSString *mobileNo = [NSString stringWithFormat:@"%@%@",_areaStr,_phoneStr];
    NSDictionary *paramter = @{@"mobileno" : mobileNo,
                               @"code" : _phoneText.text, //验证码
                               @"uniqueid" : DeviceID,
                               @"type" : @"3", //来源）
                               };
    
    [MHHttpTool POST:Api_smslogin parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        [self stopLoading];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        
        if ([code isEqualToString:@"0"]) {
            NSDictionary *dic2 = [NSDictionary dictionaryWithDictionary:responseDic[@"result"]];
            NSString *token = [NSString stringWithFormat:@"%@",dic2[@"token"]];
            
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

#pragma mark - 设置 交易密码
- (void)setPayPassWord{
    PayController *pay = [[PayController alloc] init];
    pay.typeStr = @"3";
    [self.navigationController pushViewController:pay animated:YES];
}


/**
 进入主界面
 */
#pragma mark - 进入主界面 切换跟视图
- (void)goToMainViewController{
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

#pragma mark - 懒加载

- (UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+40, kWidth-40, 50*scale_h)];
        _topTitle.text =  GetString(@"login08");//@"验证码登录";
        _topTitle.font = [UIFont systemFontOfSize:30*scale_h];
        _topTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _topTitle;
}

- (UILabel *)addlabel{
    if (!_addlabel) {
        NSString *str = [_phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
        _addlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _topTitle.bottom, kWidth-40, 40*scale_h)];
        _addlabel.text = [NSString stringWithFormat:@"%@%@)%@",GetString(@"login11"),_areaStr,str];
        _addlabel.textColor = kGrayColor;
        _addlabel.font = [UIFont systemFontOfSize:15*scale_h];
        _addlabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _addlabel;
}

- (UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(20, _addlabel.bottom+30*scale_h, kWidth-140, 50*scale_h)];
        _phoneText.borderStyle = UITextBorderStyleNone;
        _phoneText.placeholder = GetString(@"login12");//
        _phoneText.font = [UIFont systemFontOfSize:15*scale_h];
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
        //[_pwdText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    return _phoneText;
}

- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(20, _phoneText.bottom+0*scale_h, kWidth-40, 1)];
        _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line2;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-120, _addlabel.bottom+30*scale_h, 100, 40*scale_h)];
        [_sendBtn setTitle:GetString(@"login13") forState:0];
        [_sendBtn setTitleColor:kNavColor forState:0];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:13*scale_h];
        _sendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _sendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sendBtn addTarget:self action:@selector(clickSendSMS) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _line2.bottom+60*scale_h, kWidth-40, 40*scale_h)];
        [_okBtn setTitle:GetString(@"login15") forState:0];
        _okBtn.backgroundColor = kNavColor;
        _okBtn.layer.cornerRadius = 5;
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _okBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_okBtn addTarget:self action:@selector(getApi_smslogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
