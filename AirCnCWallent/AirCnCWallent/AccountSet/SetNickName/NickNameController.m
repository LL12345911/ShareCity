//
//  NickNameController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "NickNameController.h"

@interface NickNameController ()

@property (nonatomic, strong) UITextField *nickName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *oKBtn;

@end

@implementation NickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
//    "account25" = "姓名";
//    "account26" = "请输入您的姓名";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account25");
    
    _nickName = [[UITextField alloc] initWithFrame:CGRectMake(20, kTop+10, kWidth-40, 60*scale_h)];
    _nickName.borderStyle = UITextBorderStyleNone;
    _nickName.placeholder = GetString(@"account26");//
    _nickName.font = [UIFont systemFontOfSize:15*scale_h];
    [_nickName setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_nickName];
    
    _nickName.text = _nickNameStr;
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _nickName.bottom, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_line];
    
    _oKBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 60*scale_h+_line.bottom, kWidth-40, 50*scale_h)];
    _oKBtn.backgroundColor = kNavColor;
    _oKBtn.layer.cornerRadius = 5;
    [_oKBtn setTitle:GetString(@"login15") forState:0];
    [_oKBtn addTarget:self action:@selector(modifyNameMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oKBtn];
}

#pragma mark - 添加账户
- (void)modifyNameMethod{
    [self.view endEditing:YES];
    if (_nickName.text.length == 0) {
        [HUDTools showText:GetString(@"account26") withView:self.view withDelay:2.0];
        return;
    }
    [self startLoading];
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               @"username" : _nickName.text,
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_updatenameinfo);
    [MHHttpTool POST:Api_updatenameinfo parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0];
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
