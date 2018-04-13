//
//  EmailsController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "EmailsController.h"
#import "EmailAddController.h"

@interface EmailsController ()

@property (nonatomic, strong) UILabel *emailsType;
@property (nonatomic, strong) UILabel *email;
@property (nonatomic, strong) UIView *line;


@property (nonatomic, strong) UILabel *emailAdd;
@property (nonatomic, strong) UILabel *email2;
@property (nonatomic, strong) UIView *line2;



@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation EmailsController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account14");//@"邮箱地址";
  
    
//    _emailsType = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop, kWidth-100, 60*scale_h)];
//    _emailsType.text = GetString(@"account15");
//    _emailsType.textColor = kGrayColor;
//    _emailsType.font = [UIFont systemFontOfSize:15*scale_h];
//    [self.view addSubview:_emailsType];
//
//    _email = [[UILabel alloc] initWithFrame:CGRectMake(0, kTop, kWidth-20, 60*scale_h)];
//    _email.text = @"网易邮箱";
//    _email.textColor = kGrayColor;
//    _email.font = [UIFont systemFontOfSize:15*scale_h];
//    _email.textAlignment = NSTextAlignmentRight;
//    [self.view addSubview:_email];

    
//    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _email.bottom, kWidth, 1)];
//    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.view addSubview:_line];
    
    
    
    _emailAdd = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop, kWidth-100, 60*scale_h)];
    _emailAdd.text = GetString(@"account16");
    _emailAdd.textColor = kGrayColor;
    _emailAdd.font = [UIFont systemFontOfSize:15*scale_h];
    [self.view addSubview:_emailAdd];
    
    _email2 = [[UILabel alloc] initWithFrame:CGRectMake(0, kTop, kWidth-20, 60*scale_h)];
    _email2.text = _emailStr;
    _email2.textColor = kGrayColor;
    _email2.font = [UIFont systemFontOfSize:15*scale_h];
    _email2.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_email2];
    
    
    _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _email2.bottom, kWidth, 1)];
    _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_line2];
    
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 50*scale_h+_line2.bottom, kWidth-60, 50*scale_h)];
    _addBtn.backgroundColor = kNavColor;
    _addBtn.layer.cornerRadius = 5;
    [_addBtn setTitle:GetString(@"account17") forState:0];
    [_addBtn addTarget:self action:@selector(changeEmailMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    if (_emailStr.length == 0) {
        [_addBtn setTitle:GetString(@"account171") forState:0];
    }
    
    
}

#pragma mark - 更换邮箱地址
- (void)changeEmailMethod{
    EmailAddController *email = [[EmailAddController alloc] init];
    [self.navigationController pushViewController:email animated:YES];
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
