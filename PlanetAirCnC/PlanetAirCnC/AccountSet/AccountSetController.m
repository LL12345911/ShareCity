//
//  AccountSetController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "AccountSetController.h"
#import "MarsButton.h"
#import "AccountCell.h"

#import "CommonAccountController.h"
#import "ResetPassWordController.h"
#import "PayController.h"
#import "EmailsController.h"
#import "NickNameController.h"
#import "LoginController.h"
#import "AccountModel.h"


#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64

@interface AccountSetController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UIView *backview;

@property (nonatomic, strong) MarsButton *addressBtn;
@property (nonatomic, strong) MarsButton *pwdBtn;
@property (nonatomic, strong) MarsButton *payBtn;
@property (nonatomic, strong) MarsButton *emailBtn;
@property (nonatomic, strong) UIButton *loginOut;

@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) AccountModel *model;
@property (nonatomic, strong) UIAlertController* alertVc;
@property (nonatomic, strong) UIAlertController* alertLoginOut;

@end

@implementation AccountSetController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataByAccount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account01");// @"账户设置";
    
    _nameArr = @[GetString(@"account02"),GetString(@"account03"),GetString(@"account04"),GetString(@"account05"),GetString(@"account06")];
    _imageArr = @[@"绑定手机",@"姓名",@"电话",@"组8",@"版本_免费版"];
    
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.view addSubview:self.tableview];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[AccountCell class] forCellReuseIdentifier:NSStringFromClass([AccountCell class])];
    
    [self setHeadView];
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150*scale_h)];
    footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableFooterView = footView;
    
    _loginOut = [[UIButton alloc] initWithFrame:CGRectMake(30, 50*scale_h, kWidth-60, 40*scale_h)];
    _loginOut.backgroundColor = kGrayColor;
    _loginOut.layer.cornerRadius = 5;
    [_loginOut setTitle:GetString(@"account07") forState:0];
    [_loginOut addTarget:self action:@selector(loginOutMetgod) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_loginOut];
}


- (void)getDataByAccount{
    
    [self startLoading];
    
    NSString *token =  [Helper getValueForKey:USER_Token];
    NSDictionary *paramter = @{@"token" : token,
                               };
    
    DebugLog(@"%@\n%@",paramter,Api_getuserinfo);
    [MHHttpTool POST:Api_getuserinfo parameters:paramter success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {
            NSArray *arr = [NSArray arrayWithArray:dic[@"result"]];
            _model = [AccountModel yy_modelWithDictionary:arr[0]];
            _nameL.attributedText = [self setAttributedName:@"  " withnumber:_model.user_num];
            [_tableview reloadData];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }];
}

#pragma mark - 退出登录
- (void)loginOutMetgod{
    if (!_alertLoginOut) {
        _alertLoginOut = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [Helper setValue:@"" forkey:USER_Token];
                LoginController *login = [[LoginController alloc] init];
                [self.navigationController pushViewController:login animated:YES];
            });
        }];
        
//TODO  修改字体颜色,属于私有Api 慎用
        [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
        [_alertLoginOut addAction:cancelAction];
        [_alertLoginOut addAction:sureAction];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:_alertLoginOut animated:YES completion:^{}];
    });
    
}

#pragma mark - 地址簿
- (void)addressMethod{
    CommonAccountController *account = [[CommonAccountController alloc] init];
    [self.navigationController pushViewController:account animated:YES];
}

#pragma mark - 登录密码
- (void)loginPasswordMethod{
    ResetPassWordController *password = [[ResetPassWordController alloc] init];
    [self.navigationController pushViewController:password animated:YES];
}

#pragma mark - 交易密码
- (void)payPasswordMethod{
    PayController *pay = [[PayController alloc] init];
    pay.typeStr = @"2";
    [self.navigationController pushViewController:pay animated:YES];
}

#pragma mark - 邮箱地址
- (void)emailAddressMethod{
    EmailsController *password = [[EmailsController alloc] init];
    if ([_model.user_email isEqualToString:@"None"]) {
        password.emailStr = @"";
    }else{
        password.emailStr = _model.user_email;
    }
    [self.navigationController pushViewController:password animated:YES];
}
#pragma mark - 拨打客服电话
- (void)callMobilePhone{
    if (!_alertVc) {
        _alertVc = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"服务时间：00:00-24:00" preferredStyle:UIAlertControllerStyleActionSheet];//UIAlertControllerStyleActionSheet
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"400-088-1188" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [NSString callPhoneStr:@"4009197000"];
        }];
        
//TODO warning  修改字体颜色,属于私有Api 慎用
        [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
        [_alertVc addAction:cancelAction];
        [_alertVc addAction:sureAction];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:_alertVc animated:YES completion:^{}];
    });
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountCell *accountCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AccountCell class]) forIndexPath:indexPath];
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [accountCell setImage:_imageArr[indexPath.row] Name:_nameArr[indexPath.row] detail:_model isShow:indexPath.row];

    return accountCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        NickNameController * nickView = [[NickNameController alloc] init];
        if ([_model.nickname isEqualToString:@"None"]) {
            nickView.nickNameStr = @"";
        }else{
            nickView.nickNameStr = _model.nickname;
        }
        [self.navigationController pushViewController:nickView animated:YES];
    }else if (indexPath.row == 3){
        [self callMobilePhone];
    }
}


- (void)setHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, 240*scale_h+kTop)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headView;
    
   UIImageView* topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 170*scale_h+kTop)];
    topView.image = [UIImage imageNamed:@"矩形11拷贝"];
    [_headView addSubview:topView];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(20, 30*scale_h+kTop, kWidth-20, 60*scale_h)];
    _nameL.textColor = [UIColor whiteColor];
    _nameL.numberOfLines = 0;
    _nameL.textAlignment = NSTextAlignmentCenter;
    _nameL.adjustsFontSizeToFitWidth = YES;
    [_headView addSubview:self.nameL];
    
    
    _backview = [[UIView alloc] initWithFrame:CGRectMake(20, 120*scale_h+kTop, kWidth-40, 100*scale_h)];
    _backview.backgroundColor = [UIColor whiteColor];
    _backview.layer.cornerRadius = 5;
    _backview.layer.masksToBounds = YES;
    [_headView addSubview:self.backview];
    
    
    CGFloat width = (kWidth-40)/4;
    
    _addressBtn = [[MarsButton alloc] initWithFrame:CGRectMake(0, 20*scale_h, width, 60*scale_h)];
    [_addressBtn setTitle:GetString(@"account08") forState:0];
    _addressBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_addressBtn setTitleColor:[UIColor blackColor] forState:0];
    [_addressBtn setImage:[UIImage imageNamed:@"组4"] forState:0];
    _addressBtn.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
    [_addressBtn addTarget:self action:@selector(addressMethod) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:_addressBtn];

    _pwdBtn = [[MarsButton alloc] initWithFrame:CGRectMake(width, 20*scale_h, width, 60*scale_h)];
    [_pwdBtn setTitle:GetString(@"account09") forState:0];
    _pwdBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_pwdBtn setTitleColor:[UIColor blackColor] forState:0];
    [_pwdBtn setImage:[UIImage imageNamed:@"组5"] forState:0];
    _pwdBtn.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
    [_pwdBtn addTarget:self action:@selector(loginPasswordMethod) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:_pwdBtn];

    _payBtn = [[MarsButton alloc] initWithFrame:CGRectMake(width*2, 20*scale_h, width, 60*scale_h)];
    [_payBtn setTitle:GetString(@"account10") forState:0];
    _payBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_payBtn setTitleColor:[UIColor blackColor] forState:0];
    [_payBtn setImage:[UIImage imageNamed:@"组6"] forState:0];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
    [_payBtn addTarget:self action:@selector(payPasswordMethod) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:_payBtn];
    
    _emailBtn = [[MarsButton alloc] initWithFrame:CGRectMake(width*3, 20*scale_h, width, 60*scale_h)];
    [_emailBtn setTitle:GetString(@"account11") forState:0];
    _emailBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_emailBtn setTitleColor:[UIColor blackColor] forState:0];
    [_emailBtn setImage:[UIImage imageNamed:@"组7"] forState:0];
    _emailBtn.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
    [_emailBtn addTarget:self action:@selector(emailAddressMethod) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:_emailBtn];
    
    _nameL.attributedText = [self setAttributedName:@"" withnumber:@"-----"];
    
}



- (NSMutableAttributedString *)setAttributedName:(NSString *)name withnumber:(NSString *)number{
    
    
    NSString *powStr = [NSString stringWithFormat:@"%@",name];
    NSString *plusStr = [NSString stringWithFormat:@"%@%@%@",GetString(@"account12"),number,GetString(@"account13")];
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",powStr,plusStr]];
    
    NSRange rangleft = NSMakeRange(0, powStr.length);
    NSRange range2 = NSMakeRange(strAtt.length-plusStr.length, plusStr.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:range2];
    
    return strAtt;
}





#pragma mark - 导航栏 隐藏显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self setBackgroundAlpha:alpha];//:alpha];
        //self.customNavBar.title = @"纷享基地";
    }
    else
    {
        [self setBackgroundAlpha:0];
        //self.customNavBar.title = @"";
    }
    
    //让uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
//    CGFloat sectionHeaderHeight = 50;
//    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
    
}


#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-KBottom)  style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableview.sectionIndexColor = kBlueColor;
//        _tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
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
