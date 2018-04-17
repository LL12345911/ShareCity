//
//  EnjoyDrilDisputeController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "EnjoyDrilDisputeController.h"
#import "ExtractViewController.h"

@interface EnjoyDrilDisputeController ()

@property (nonatomic, strong) UILabel *textL;
@property (nonatomic, strong) UIButton *extractBtn;


@end

@implementation EnjoyDrilDisputeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"account41"); //纷享钻
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, 200*scale_h)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    _textL = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop, kWidth-40, 200*scale_h)];
    _textL.numberOfLines = 0;
    _textL.adjustsFontSizeToFitWidth = YES;
    _textL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textL];
    
    
    _extractBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, _textL.bottom+50*scale_h, kWidth-40, 50*scale_h)];
    [_extractBtn setTitle:GetString(@"account42") forState:0];
    _extractBtn.backgroundColor = kNavColor;
    _extractBtn.layer.cornerRadius = 5;
    _extractBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    _extractBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_extractBtn addTarget:self action:@selector(extractMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_extractBtn];
    
    
    _textL.attributedText = [self setAttributed:@"12.0099888777" desc:@"简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"];
    
}


#pragma mark - 提取
- (void)extractMethods{
  
    ExtractViewController *extract = [[ExtractViewController alloc] init];
    [self.navigationController pushViewController:extract animated:YES];
}





- (NSMutableAttributedString *)setAttributed:(NSString *)number desc:(NSString *)desc{
    
    desc = [NSString stringWithFormat:@"\n\n%@",desc];
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",number,desc]];
    
    NSRange rangle1 = NSMakeRange(0, number.length);
    NSRange rangle3 = NSMakeRange(strAtt.length-desc.length, desc.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25*scale_h] range:rangle1];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kBlackColor  range:rangle1];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangle3];
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
