//
//  LoginController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "LoginController.h"
#import "UIButton+Countdown.h"

#define MSG(msg) [[[UIAlertView alloc]initWithTitle:@"提示" message:(msg) delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];


@interface LoginController ()

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *phone1;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIView *line2;


@property (nonatomic, strong) UIButton *proBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIView *nicknameback;
@property (nonatomic, strong) UITextField *inviteCodeText;
@property (nonatomic, strong) UIView *inviteCodeLine;

@property (nonatomic, strong) UITextField *nickNameText;
@property (nonatomic, strong) UIView *nickNameLine;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = kBlueColor;
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    imageview.image = [UIImage imageNamed:@"icon_login_background"];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    
    [self.view insertSubview:self.customNavBar aboveSubview:imageview];

    
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self setHeadView];
}

- (void)setHeadView{
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-80*scale_h)/2, kTop+10*scale_h, 80*scale_h, 80*scale_h)];
    _imageview.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageview];
    
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, kTop+90*scale_h, kWidth, 30*scale_h)];
    _titleL.text = @"未来之门正在为你开启";
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.textColor = [UIColor whiteColor];
    [self.view addSubview:_titleL];
    
    
    _phone = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+150*scale_h, 40, 40*scale_h)];
    _phone.text = @"+86";
    _phone.font = [UIFont systemFontOfSize:15*scale_h];
    _phone.textAlignment = NSTextAlignmentCenter;
    _phone.textColor = [UIColor whiteColor];
    [self.view addSubview:_phone];
    
    _phone1 = [[UILabel alloc] initWithFrame:CGRectMake(70, kTop+150*scale_h, 1, 25*scale_h)];
    _phone1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_phone1];
    _phone1.centerY = _phone.centerY;
    
    _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(80, kTop+150*scale_h, kWidth-100, 40*scale_h)];
    _phoneText.borderStyle = UITextBorderStyleNone;
    _phoneText.placeholder = @"输入手机号";
    _phoneText.textColor = [UIColor whiteColor];
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
     [self.view addSubview:_phoneText];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(20, kTop+200*scale_h, kWidth-40, 1)];
    _line.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:_line];
    
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(20, kTop+210*scale_h, kWidth-140, 40*scale_h)];
    _codeText.borderStyle = UITextBorderStyleNone;
    _codeText.placeholder = @"短信验证码";
    _codeText.textColor = [UIColor whiteColor];
    _codeText.keyboardType = UIKeyboardTypeNumberPad;
    [_codeText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_codeText];
    
    _codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-120, kTop+210*scale_h, 100, 40*scale_h)];
    [_codeBtn setTitle:@"获取验证码" forState:0];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:0];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_codeBtn addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeBtn];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(20, kTop+260*scale_h, kWidth-40, 1)];
    _line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_line];
    
    _inviteCodeText = [[UITextField alloc] initWithFrame:CGRectMake(20,  kTop+270*scale_h+1, kWidth-40, 40*scale_h)];
    _inviteCodeText.borderStyle = UITextBorderStyleNone;
    _inviteCodeText.placeholder = @"邀请码";
    _inviteCodeText.textColor = [UIColor whiteColor];
    _inviteCodeText.keyboardType = UIKeyboardTypeNumberPad;
    [_inviteCodeText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_inviteCodeText];
    
    _inviteCodeLine = [[UIView alloc] initWithFrame:CGRectMake(20, kTop+320*scale_h, kWidth-40, 1)];
    _inviteCodeLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_inviteCodeLine];
    
    _nickNameText = [[UITextField alloc] initWithFrame:CGRectMake(20, kTop+330*scale_h, kWidth-40, 40*scale_h)];
    _nickNameText.borderStyle = UITextBorderStyleNone;
    _nickNameText.placeholder = @"昵称";
    _nickNameText.textColor = [UIColor whiteColor];
    [_nickNameText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_nickNameText];
    
    _nickNameLine = [[UIView alloc] initWithFrame:CGRectMake(20, kTop+380*scale_h, kWidth-40, 1)];
    _nickNameLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_nickNameLine];
    
    
    [self setNickOrInviteCodeView];
    
    _inviteCodeText.hidden = YES;
     _inviteCodeLine.hidden = YES;
     _nickNameText.hidden = YES;
     _nickNameLine.hidden = YES;

}

- (void)setNickOrInviteCodeView{
//
    _nicknameback = [[UIView alloc] initWithFrame:CGRectMake(0, kTop+260*scale_h+1, kWidth, 120*scale_h)];
    _nicknameback.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_nicknameback];
    
    _proBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10*scale_h, kWidth-40, 30*scale_h)];
    [_proBtn setTitle:@"  我已阅读并同意《用户服务协议》" forState:0];
     [_proBtn setImage:[UIImage imageNamed:@"checkbox_off"] forState:0];
     [_proBtn setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
    [_proBtn setTitleColor:[UIColor whiteColor] forState:0];
    _proBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    _proBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_proBtn addTarget:self action:@selector(agreeUserProtocol:) forControlEvents:UIControlEventTouchUpInside];
    _proBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _proBtn.selected = NO;
    [_nicknameback addSubview:_proBtn];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 60*scale_h, kWidth-40, 50*scale_h)];
    [_loginBtn setTitle:@"开启纷享城之旅" forState:0];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"background_login_btn"] forState:0];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    _loginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_loginBtn addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
    [_nicknameback addSubview:_loginBtn];
}
#pragma mark - 用户服务协议
- (void)agreeUserProtocol:(UIButton *)button{
   _proBtn.selected = YES;
}

#pragma mark - 发送短信验证码
- (void)clickSendButton
{
    [self.view endEditing:YES];
    NSString *phoneNumber = _phoneText.text;
    
    if ([phoneNumber isEqualToString:@""]) {
        MSG(@"请输入手机号");
        return;
    }
    
    //倒计时(如果按钮倒计时出现闪烁，将xib或者storyboard中Type属性设置为custom即可)
    [_codeBtn startCountDownTime:60 withCountDownBlock:^{
        
        NSLog(@"开始倒计时");
        
        _inviteCodeText.hidden = NO;
        _inviteCodeLine.hidden = NO;
        _nickNameText.hidden = NO;
        _nickNameLine.hidden = NO;
        _nicknameback.frame = CGRectMake(0, kTop+380*scale_h+1, kWidth, 120*scale_h);
        //此处发送验证码等操作
        //................
        
    }];
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
