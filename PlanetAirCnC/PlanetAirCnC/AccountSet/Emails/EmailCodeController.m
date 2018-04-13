//
//  EmailCodeController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "EmailCodeController.h"
#import "EmailsController.h"
@interface EmailCodeController ()

@property (nonatomic, strong) UILabel *emailT;
@property (nonatomic, strong) UILabel *emailDesc;

@property (nonatomic, strong) UITextField *emailCode;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *okBtn;

@end

@implementation EmailCodeController

- (void)viewDidLoad {
    [super viewDidLoad];

//    "account21" = "邮箱验证码";
//    "account22" = "已向邮箱：";
//    "account23" = "发送了验证码请注意查看";
//    "account24" = "请输入邮箱验证码";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account20");
    
    _emailT = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+30, kWidth-40, 60*scale_h)];
    _emailT.text = GetString(@"account21");
    _emailT.textColor = kBlackColor;
    _emailT.font = [UIFont boldSystemFontOfSize:25*scale_h];
    _emailT.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_emailT];
    
    _emailDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, _emailT.bottom+10*scale_h, kWidth-40, 60*scale_h)];
    _emailDesc.text = [NSString stringWithFormat:@"%@%@%@",GetString(@"account22"),_emailStr,GetString(@"account23")];
    _emailDesc.textColor = kGrayColor;
    _emailDesc.font = [UIFont systemFontOfSize:15*scale_h];
    _emailDesc.numberOfLines = 0;
    _emailDesc.adjustsFontSizeToFitWidth = YES;
    [_emailDesc sizeToFit];
    [self.view addSubview:_emailDesc];
    
    
    _emailCode = [[UITextField alloc] initWithFrame:CGRectMake(20, _emailDesc.bottom+10, kWidth-40, 60*scale_h)];
    _emailCode.borderStyle = UITextBorderStyleNone;
    _emailCode.placeholder = GetString(@"account24");//
    _emailCode.font = [UIFont systemFontOfSize:15*scale_h];
    [_emailCode setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    _emailCode.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_emailCode];
    
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _emailCode.bottom, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_line];
    
    _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 60*scale_h+_line.bottom, kWidth-60, 50*scale_h)];
    _okBtn.backgroundColor = kNavColor;
    _okBtn.layer.cornerRadius = 5;
    [_okBtn setTitle:GetString(@"login15") forState:0];
    [_okBtn addTarget:self action:@selector(authenticationIsSuccessful) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_okBtn];
    
    
    
    

}

//验证成功
- (void)authenticationIsSuccessful{
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray){
        
        if ([temVC isKindOfClass:[EmailsController class]]){
            
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
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
