//
//  SMSViewController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "SMSViewController.h"
#import "TDButton.h"
#import "SMSLoginController.h"
#import "AreasController.h"

@interface SMSViewController ()<AreasForMobileDalagate>

@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UILabel *addlabel;

@property (nonatomic, strong) UIButton *addressBtn;
@property (nonatomic, strong) UIView *line;
//@property (nonatomic, strong) UILabel *areaCode;
@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, copy) NSString *phoneArea;

@end

@implementation SMSViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"login08");// @"验证码登录";
    
    _phoneArea = @"+86";
    [self setView];

}


- (void)setView{
  
    [self.view addSubview:self.topTitle];
    [self.view addSubview:self.addlabel];
    
    [self.view addSubview:self.addressBtn];
    [self.view addSubview:self.line];
    [self.view addSubview:self.areaBtn];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.sendBtn];
    
}


#pragma mark - 选择归属地
- (void)areaAddress{
    AreasController *area = [[AreasController alloc] init];
    area.delegate = self;
    [self.navigationController pushViewController:area animated:YES];
    
}

#pragma mark - 选择地区 代理
- (void)returnAreasForMobileInfoDic:(NSDictionary *)infoDic{
    _phoneArea = [NSString stringWithFormat:@"+%@",infoDic[@"country_code"]];
    [_addressBtn setTitle:[NSString stringWithFormat:@"%@ ",infoDic[@"country_name"]] forState:0];
    
    [_areaBtn setTitle:[NSString stringWithFormat:@"%@ ",_phoneArea] forState:0];
}


#pragma mark - 发送短信验证码
- (void)clickSendButton{
    [self.view endEditing:YES];
    
    if (_phoneText.text.length == 0) {
        [HUDTools showText:GetString(@"login22") withView:self.view withDelay:2];//请输入手机号
        return;
    }

    SMSLoginController * smsLogin = [[SMSLoginController alloc] init];
    smsLogin.areaStr = _phoneArea;
    smsLogin.phoneStr = _phoneText.text;
    [self.navigationController pushViewController:smsLogin animated:YES];

}

#pragma mark - 懒加载
- (UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop, kWidth-40, 80*scale_h)];
        _topTitle.text =  GetString(@"login08");//@"验证码登录";
        _topTitle.font = [UIFont systemFontOfSize:30*scale_h];
        _topTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _topTitle;
}

- (UILabel *)addlabel{
    if (!_addlabel) {
        _addlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _topTitle.bottom, 250, 40*scale_h)];
        _addlabel.text = GetString(@"login09");
        _addlabel.textColor = kGrayColor;
        _addlabel.font = [UIFont systemFontOfSize:15*scale_h];
    }
    return _addlabel;
}

- (UIButton *)addressBtn{
    if (!_addressBtn) {
        _addressBtn = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleRight];
        _addressBtn.frame = CGRectMake(kWidth-220, _topTitle.bottom, 200, 40*scale_h);
        [_addressBtn setTitle:@"中国大陆  " forState:0];
        [_addressBtn setTitleColor:kBlackColor forState:0];
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _addressBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_addressBtn setImage:[UIImage imageNamed:@"返回拷贝"] forState:UIControlStateNormal];
        [_addressBtn addTarget:self action:@selector(areaAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressBtn;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(20, _addlabel.bottom, kWidth-40, 1)];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}


- (UIButton *)areaBtn{
    if (!_areaBtn) {
        _areaBtn = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleRight];
        _areaBtn.frame = CGRectMake(20, _line.bottom+30*scale_h, 50, 40*scale_h);
        [_areaBtn setTitle:@"+86  " forState:0];
        [_areaBtn setTitleColor:kBlackColor forState:0];
        _areaBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _areaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_areaBtn setImage:[UIImage imageNamed:@"竖线"] forState:UIControlStateNormal];
        //[_areaBtn addTarget:self action:@selector(selectPhoneAreas) forControlEvents:UIControlEventTouchUpInside];
    }
    return _areaBtn;
}

- (UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(80, _line.bottom+30*scale_h, kWidth-110, 40*scale_h)];
        _phoneText.borderStyle = UITextBorderStyleNone;
        _phoneText.placeholder = GetString(@"login02");// @"请输入密码";
        //    _phoneText.textColor = [UIColor whiteColor];
        _phoneText.font = [UIFont systemFontOfSize:15*scale_h];
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
        //[_pwdText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _phoneText;
}


- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(20, _phoneText.bottom, kWidth-40, 1)];
        _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line2;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _line2.bottom+60*scale_h, kWidth-40, 40*scale_h)];
        [_sendBtn setTitle:GetString(@"login10") forState:0];
        _sendBtn.backgroundColor = kNavColor;
        _sendBtn.layer.cornerRadius = 5;
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _sendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_sendBtn addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
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
