//
//  EmailAddController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "EmailAddController.h"
#import "EmailCodeController.h"
#import "AccountSetController.h"

@interface EmailAddController ()

@property (nonatomic, strong) UITextField *emailAdd;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *nextBtn;


@end

@implementation EmailAddController

- (void)viewDidLoad {
    [super viewDidLoad];

//    "account18" = "请输入您的邮箱地址";
//    "account19" = "下一步";
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account14");//@"邮箱地址";
    
    
    _emailAdd = [[UITextField alloc] initWithFrame:CGRectMake(20, kTop+10, kWidth-40, 60*scale_h)];
    _emailAdd.borderStyle = UITextBorderStyleNone;
    _emailAdd.placeholder = GetString(@"account18");//
    _emailAdd.font = [UIFont systemFontOfSize:15*scale_h];
    [_emailAdd setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_emailAdd];
    
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _emailAdd.bottom, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_line];
    
    _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 60*scale_h+_line.bottom, kWidth-60, 50*scale_h)];
    _nextBtn.backgroundColor = kNavColor;
    _nextBtn.layer.cornerRadius = 5;
    [_nextBtn setTitle:GetString(@"login15") forState:0];
    [_nextBtn addTarget:self action:@selector(addEmailNextMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
}

#pragma mark -
- (void)addEmailNextMethod{
    [self.view endEditing:YES];
    if (_emailAdd.text.length == 0) {
        [HUDTools showText:GetString(@"account18") withView:self.view withDelay:2.0];
        return;
    }
    
    [self startLoading];
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               @"usermail" : _emailAdd.text,
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_updatemail);
    [MHHttpTool POST:Api_updatemail parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {
           // [self.navigationController popViewControllerAnimated:YES];
            NSArray *temArray = self.navigationController.viewControllers;
            for(UIViewController *temVC in temArray){
                
                if ([temVC isKindOfClass:[AccountSetController class]]){
                    [self.navigationController popToViewController:temVC animated:YES];
                }
            }
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
    }];
    
    
    
//    EmailCodeController *emailView = [[EmailCodeController alloc] init];
//    emailView.emailStr = @"12333344@163.com";
//    [self.navigationController pushViewController:emailView animated:YES];
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
