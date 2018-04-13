//
//  RegisteredController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "RegisteredController.h"
#import "UIButton+Countdown.h"
#import "MainTabBarController.h"
#import "TDButton.h"
#import "AreasController.h"
#import "PayController.h"

#define MSG(msg) [[[UIAlertView alloc]initWithTitle:@"提示" message:(msg) delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];

@interface RegisteredController ()<AreasForMobileDalagate>

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *topTitle;

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;
@property (nonatomic, strong) UIImageView *image5;
@property (nonatomic, strong) UIImageView *image6;
@property (nonatomic, strong) UIImageView *image7;
@property (nonatomic, strong) UIImageView *image9;

@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIButton *phoneSelect;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UITextField *inviteText;
@property (nonatomic, strong) UIView *inviteL;

@property (nonatomic, strong) UITextField *pwdText;
@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) UITextField *pwd2Text;
@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, copy) NSString *phoneStr;


@end

@implementation RegisteredController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"login31");
//    [self.view insertSubview:self.customNavBar aboveSubview:imageview];
    _phoneStr = @"+86";
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self setHeadView];
}

- (void)setHeadView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kTop+160*scale_h)];
    _topView.backgroundColor = kNavColor;
    [self.view addSubview:_topView];
    
    [self.view insertSubview:self.customNavBar aboveSubview:_topView];
    
    [self.view addSubview:self.imageview];
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.phoneSelect];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.line];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.inviteText];
    [self.view addSubview:self.inviteL];
    [self.view addSubview:self.pwdText];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.pwd2Text];
    [self.view addSubview:self.line4];
    
    [self.view addSubview:self.image1];
    [self.view addSubview:self.image2];
    [self.view addSubview:self.image3];
    [self.view addSubview:self.image4];
    [self.view addSubview:self.image5];
    
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.okBtn];
}

#pragma mark - 注册
- (void)loginUPMethod{
    [self.view endEditing:YES];
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login22") withView:self.view withDelay:2];//请输入手机号
        return;
    }
    if (_codeText.text.length == 0) {
        [HUDTools showText:GetString(@"login12") withView:self.view withDelay:2];//请输入短信验证码
        return;
    }
    if (_inviteText.text.length == 0) {
        [HUDTools showText:GetString(@"login28") withView:self.view withDelay:2]; //请输入邀请码
        return;
    }

    if (_pwdText.text.length == 0) {
        [HUDTools showText:GetString(@"login29") withView:self.view withDelay:2]; //请新人密码
        return;
    }
    if (_pwd2Text.text.length == 0) {
        [HUDTools showText:GetString(@"login30") withView:self.view withDelay:2]; //请再次输入密码
        return;
    }

    if (![_pwdText.text isEqualToString:_pwd2Text.text]) {
        [HUDTools showText:@"密码不一致,请检查两次密码是否一致" withView:self.view withDelay:2];
        return;
    }
    [self startLoading];
    NSString* phone = [NSString stringWithFormat:@"%@%@",_phoneStr,_phoneText.text];

    NSDictionary *paramter = @{@"mobileno" : phone,  //电话号码
                               @"password" : _pwdText.text, //密码
                               @"invitecode" : _inviteText.text, //邀请码
                               @"identifyingcode" : _codeText.text,//短信验证码
                               @"sourcetype" : @"3", //来源
//                               @"nickname" : @"",
                               };
DebugLog(@"%@\n%@",paramter,Api_signup);
    [MHHttpTool POST:Api_signup parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        [self stopLoading];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([code isEqualToString:@"0"]) {
            [HUDTools showText:@"注册成功，请设置交易密码" withView:self.view withDelay:2.0];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PayController *payView = [[PayController alloc] init];
                [self.navigationController pushViewController:payView animated:YES];
            });

        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2.0];
        }


    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
    
    
//    PayController *payView = [[PayController alloc] init];
//    [self.navigationController pushViewController:payView animated:YES];
}


#pragma mark - 发送短信验证码
- (void)clickSendSMS{
     [self.view endEditing:YES];
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login22") withView:self.view withDelay:2];//请输入手机号
        return;
    }
     //[_sendBtn setTitleColor:kGrayColor forState:0];
    [_sendBtn startCountDownTime:60 textNormalColor:[UIColor whiteColor] textColor:[UIColor whiteColor] withCountDownBlock:^{
        NSLog(@"开始倒计时");
        //此处发送验证码等操作
        //................
    }];
    
    [self startLoading];
    NSString* phone = [NSString stringWithFormat:@"%@%@",_phoneStr,_phoneText.text];
    NSDictionary *paramter = @{@"mobileno" : phone,  //电话号码
                               @"type" : @"1", //1注册短信验证码
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_mobilecode);
    [MHHttpTool POST:Api_mobilecode parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        [self stopLoading:0];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
//        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2.0];
            
        });
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];

    //参数：mobileno  type。手机号码格式为+86136....    type有：1注册短信验证码  2 修改密码短信验证码  3 登录验证码  4交易密码验证码

}

#pragma mark - 选择地区
- (void)selectPhoneAreas{
    AreasController *areas = [[AreasController alloc] init];
    areas.delegate = self;
    [self.navigationController pushViewController:areas animated:YES];
    
}

#pragma mark - 选择地区 代理
- (void)returnAreasForMobileInfoDic:(NSDictionary *)infoDic{
    _phoneStr = [NSString stringWithFormat:@"+%@",infoDic[@"country_code"]];
    [_phoneSelect setTitle:[NSString stringWithFormat:@"%@ ",_phoneStr] forState:0];
    //    _phoneSelect.titleLabel.adjustsFontSizeToFitWidth = YES;
}


#pragma mark - 懒加载

- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-80*scale_h)/2, kTop+10*scale_h, 80*scale_h, 80*scale_h)];
        //    _imageview.backgroundColor = [UIColor redColor];
        _imageview.image = [UIImage imageNamed:@"top"];
        _imageview.layer.cornerRadius = 40*scale_h;
        _imageview.layer.masksToBounds = YES;
        
    }
    return _imageview;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, kTop+100*scale_h, kWidth, 40*scale_h)];
        _titleL.text = GetString(@"login01");// @"比特币钱包";
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.textColor = [UIColor whiteColor];
        
    }
    return _titleL;
}

- (UIButton *)phoneSelect{
    if (!_phoneSelect) {
        _phoneSelect = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleRight];
        _phoneSelect.frame = CGRectMake(50, _topView.bottom, 60*scale_h, 50*scale_h);
        //_phoneSelect.frame = CGRectMake(kWidth-120, _topView.bottom, 100, 50*scale_h);
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
        _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(50+65*scale_h, _topView.bottom, kWidth-70-65*scale_h, 50*scale_h)];
        _phoneText.borderStyle = UITextBorderStyleNone;
        _phoneText.placeholder = GetString(@"login22");//
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
        _codeText = [[UITextField alloc] initWithFrame:CGRectMake(50+10*scale_h, _line.bottom, kWidth-170-10*scale_h, 50*scale_h)];
        _codeText.borderStyle = UITextBorderStyleNone;
        _codeText.placeholder = GetString(@"login12");
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

- (UITextField *)inviteText{
    if (!_inviteText) {
        _inviteText = [[UITextField alloc] initWithFrame:CGRectMake(50+10*scale_h, _line2.bottom, kWidth-70-10*scale_h, 50*scale_h)];
        _inviteText.borderStyle = UITextBorderStyleNone;
        _inviteText.placeholder = GetString(@"login28");
        _inviteText.font = [UIFont systemFontOfSize:15*scale_h];
        _inviteText.keyboardType = UIKeyboardTypeDefault;
    }
    return _inviteText;
}

- (UIView *)inviteL{
    if (!_inviteL) {
        _inviteL = [[UIView alloc] initWithFrame:CGRectMake(20, _inviteText.bottom, kWidth-40, 1)];
        _inviteL.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _inviteL;
}

- (UITextField *)pwdText{
    if (!_pwdText) {
        _pwdText = [[UITextField alloc] initWithFrame:CGRectMake(50+10*scale_h, _inviteL.bottom, kWidth-70-10*scale_h, 50*scale_h)];
        _pwdText.borderStyle = UITextBorderStyleNone;
        _pwdText.placeholder = GetString(@"login29");// @"请输入密码";
        _pwdText.font = [UIFont systemFontOfSize:15*scale_h];
         _pwdText.secureTextEntry = YES;
    }
    return _pwdText;
}

- (UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] initWithFrame:CGRectMake(20, _pwdText.bottom, kWidth-40, 1)];
        _line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line3;
}

- (UITextField *)pwd2Text{
    if (!_pwd2Text) {
        _pwd2Text = [[UITextField alloc] initWithFrame:CGRectMake(50+10*scale_h, _line3.bottom, kWidth-70-10*scale_h, 50*scale_h)];
        _pwd2Text.borderStyle = UITextBorderStyleNone;
        _pwd2Text.placeholder = GetString(@"login30");// @"请输入密码";
        _pwd2Text.font = [UIFont systemFontOfSize:15*scale_h];
         _pwd2Text.secureTextEntry = YES;
    }
    return _pwd2Text;
}

- (UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc] initWithFrame:CGRectMake(20, _pwd2Text.bottom, kWidth-40, 1)];
        _line4.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _line4;
}

- (UIImageView *)image1{
    if (!_image1) {
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _topView.bottom, 30, 50*scale_h)];
        _image1.image = [UIImage imageNamed:@"账户"];
        _image1.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image1;
}


- (UIImageView *)image2{
    if (!_image2) {
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _line.bottom, 30, 50*scale_h)];
        _image2.image = [UIImage imageNamed:@"验证码"];
        _image2.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image2;
}

- (UIImageView *)image3{
    if (!_image3) {
        _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _line2.bottom, 30, 50*scale_h)];
        _image3.image = [UIImage imageNamed:@"邀请码"];
        _image3.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image3;
}

- (UIImageView *)image4{
    if (!_image4) {
        _image4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _inviteL.bottom, 30, 50*scale_h)];
        _image4.image = [UIImage imageNamed:@"密码"];
        _image4.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image4;
}

- (UIImageView *)image5{
    if (!_image5) {
        _image5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _line3.bottom, 30, 50*scale_h)];
        _image5.image = [UIImage imageNamed:@"密码"];
        _image5.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image5;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-120, _line.bottom+15*scale_h, 100, 20*scale_h)];
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
        [_okBtn addTarget:self action:@selector(loginUPMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}


//- (IBAction)btnClick:(UIButton *)sender {
//    __block int timeout=30; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [_btn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                _btn.backgroundColor = [UIColor orangeColor];
//                _btn.userInteractionEnabled = YES;
//            });
//        }else{
//            //            int minutes = timeout / 60;
//            int seconds = timeout % 59;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
//                [_btn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
//                _btn.backgroundColor = [UIColor grayColor];
//                _btn.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
//}
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
