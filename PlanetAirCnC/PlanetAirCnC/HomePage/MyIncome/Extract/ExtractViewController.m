//
//  ExtractViewController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "ExtractViewController.h"

@interface ExtractViewController ()

@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) UILabel *number2;

@property (nonatomic, strong) UIView *backview;
@property (nonatomic, strong) UITextField *numberText;
@property (nonatomic, strong) UIButton *allBtn;


@property (nonatomic, strong) UILabel *extraDesc; //提取条件
@property (nonatomic, strong) UIButton *extractBtn;

@end

@implementation ExtractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account42"); // "提取";
    
    
//    "account43" = "提取数量";
//    "account44" = "可提取";
//    "account45" = "个";
//    "account46" = "请输入提取数量";
//    "account47" = "全部";
//    "account48" = "*提取数量：满10个可提取";
//
    
    _number = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+30*scale_h, kWidth-40, 30*scale_h)];
    _number.adjustsFontSizeToFitWidth = YES;
    _number.text = GetString(@"account43");
    [self.view addSubview:_number];
    
    
    _number2 = [[UILabel alloc] initWithFrame:CGRectMake(0, kTop+30*scale_h, kWidth-20, 30*scale_h)];
    _number2.numberOfLines = 0;
    _number2.adjustsFontSizeToFitWidth = YES;
    _number2.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_number2];
    
    
    _backview = [[UIView alloc] initWithFrame:CGRectMake(20, _number2.bottom+10, kWidth-40, 60*scale_h)];
    _backview.backgroundColor = [UIColor whiteColor];
    _backview.userInteractionEnabled = YES;
    [self.view addSubview:_backview];
    
    _numberText = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, kWidth-95, 60*scale_h)];
    _numberText.borderStyle = UITextBorderStyleNone;
    _numberText.placeholder = GetString(@"account46");//
    _numberText.font = [UIFont systemFontOfSize:15*scale_h];
    [_numberText setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    _numberText.keyboardType = UIKeyboardTypeNumberPad;
    [_backview addSubview:_numberText];
    
    
    _allBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-50-40, 0, 50, 60*scale_h)];
    [_allBtn setTitle:GetString(@"account47") forState:0];
    [_allBtn setTitleColor:kNavColor forState:0];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    _allBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_allBtn addTarget:self action:@selector(clickOnAllButtonMethods) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:_allBtn];
    
    
    _extraDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, _backview.bottom+10, kWidth-40, 20*scale_h)];
    _extraDesc.numberOfLines = 0;
    _extraDesc.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_extraDesc];
    
    _extractBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, kHeight-KBottom-100*scale_h, kWidth-40, 50*scale_h)];
    [_extractBtn setTitle:GetString(@"account42") forState:0];
    _extractBtn.backgroundColor = kNavColor;
    _extractBtn.layer.cornerRadius = 5;
    _extractBtn.titleLabel.font = [UIFont systemFontOfSize:16*scale_h];
    _extractBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_extractBtn addTarget:self action:@selector(extractMoneyMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_extractBtn];
    
    
    _extraDesc.attributedText = [self setAttributedDesc:GetString(@"account48")];
    
    _number2.attributedText = [self setAttributedNumber:@"12.9999"];
    
}

#pragma mark - 全部
- (void)clickOnAllButtonMethods{
    DebugLog(@"全部提取");
    
}


#pragma mark - 提取
- (void)extractMoneyMethods{
    DebugLog(@"提取");
   
}


- (NSMutableAttributedString *)setAttributedNumber:(NSString *)number{
    
    NSString *str1 = GetString(@"account44");
    NSString *str3 = GetString(@"account45");
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",str1,number,str3]];
    
    NSRange rangle1 = NSMakeRange(0, number.length);
    NSRange rangle2 = NSMakeRange(str1.length, number.length);
    NSRange rangle3 = NSMakeRange(strAtt.length-str3.length, str3.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle1];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle1];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:rangle2];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle3];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle3];
    
    return strAtt;
}



- (NSMutableAttributedString *)setAttributedDesc:(NSString *)desc{
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",desc]];
    
    NSRange rangle1 = NSMakeRange(0, 1);
    NSRange rangle3 = NSMakeRange(strAtt.length-desc.length+1, desc.length-1);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle1];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:rangle1];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15*scale_h] range:rangle3];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle3];
    
    return strAtt;
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
