//
//  InviteCodeController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/3/1.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "InviteCodeController.h"
#import "UIImage+QRcode.h"
#import <objc/message.h>

@interface InviteCodeController ()

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UILabel *inviteCode;
@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIImageView *qrCodeView;//二维码
@property (nonatomic , strong) NSArray  *methers;

@end

@implementation InviteCodeController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.customNavBar.title = @"邀请码";
//    // 设置初始导航栏透明度
//    [self.customNavBar wr_setBackgroundAlpha:1];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
     _methers = @[@"qrCodeMethod"];
    
    [self setBackView];
    [self setTopViewFrame];
    [self setBottomViewFrame];
    
    //生成二维码
    [self startWithTag:0];
}


/** 动态添加方法 */
- (void)startWithTag:(NSInteger)tag
{
    NSString *metherName = _methers[tag];
    SEL normalSelector = NSSelectorFromString(metherName);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
}

#pragma mark - 生成二维码
-(void)qrCodeMethod{
//    [UIImage CreateQrcodeWithTitle:@"https://www.jianshu.com/p/ef738baf8e33" size:100*scale_h completion:^(UIImage *image) {
//        _qrCodeView.image = image;
//    }];
    
    [UIImage CreateQrcodeWithTitle:@"https://www.jianshu.com/p/ef738baf8e33" size:100*scale_h withColor:[CIColor colorWithRed:61/255.0 green:21/255.0 blue:92/255.0 alpha:1] completion:^(UIImage *image) {
        _qrCodeView.image = image;
    }];
    
}

#pragma mark - 复制邀请码到 剪切板
- (void)copyMethodForButton{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:_inviteCode.text];
    
    [HUDTools showDetailText:@"已复制" withView:self.view withDelay:2];
    
}

-(void)setBackView{
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTop)];
    _scrollview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scrollview.contentSize = CGSizeMake(kWidth, kHeight);
    [self.view addSubview:_scrollview];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    imageView.backgroundColor = kBlueColor;
    imageView.userInteractionEnabled = YES;
    [_scrollview addSubview:imageView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-80*scale_h)/2, 40*scale_h, 80*scale_h, 80*scale_h)];
    logoView.backgroundColor = [UIColor redColor];
    [imageView addSubview:logoView];
    
    UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 120*scale_h, kWidth, 30*scale_h)];
    titleL.text = @"未来之门正在为你开启";
    titleL.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:titleL];
    
}

- (void)setTopViewFrame{
    _topView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 170*scale_h, kWidth-60, 240*scale_h)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 10;
    _topView.layer.masksToBounds = YES;
    _topView.userInteractionEnabled = YES;
    [_scrollview addSubview:_topView];
    
    UILabel* code = [[UILabel alloc] initWithFrame:CGRectMake(0,20*scale_h, kWidth-60, 30*scale_h)];
    code.text = @"您的邀请码";
    code.textAlignment = NSTextAlignmentCenter;
    code.font = [UIFont systemFontOfSize:16*scale_h];
    code.textColor = RGBCOLOR(0x7961e9);
    [_topView addSubview:code];
    
    _inviteCode = [[UILabel alloc] initWithFrame:CGRectMake(0,50*scale_h, kWidth-60, 70*scale_h)];
    _inviteCode.text = @"DU06";
    _inviteCode.textAlignment = NSTextAlignmentCenter;
    _inviteCode.font = [UIFont systemFontOfSize:50*scale_h];
    _inviteCode.adjustsFontSizeToFitWidth = YES;
    _inviteCode.textColor = RGBCOLOR(0x7961e9);
    [_topView addSubview:_inviteCode];
    
    UIButton *copyBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-60-100)/2, 120*scale_h, 100, 30*scale_h)];
    [copyBtn setTitle:@"复制" forState:0];
    [copyBtn setBackgroundImage:[UIImage imageNamed:@"background_login_btn"] forState:0];
    copyBtn.imageView.contentMode = UIViewContentModeCenter;
    copyBtn.layer.cornerRadius = 5;
    copyBtn.layer.masksToBounds = YES;
    copyBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [copyBtn addTarget:self action:@selector(copyMethodForButton) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:copyBtn];
    
    _number = [[UILabel alloc] initWithFrame:CGRectMake(0,160*scale_h, kWidth-60, 30*scale_h)];
    _number.text = @"剩余邀请次数5次";
    _number.textAlignment = NSTextAlignmentCenter;
    _number.font = [UIFont systemFontOfSize:16*scale_h];
    _number.textColor = RGBCOLOR(0x7961e9);
    [_topView addSubview:_number];
    
    
    UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(20,190*scale_h, kWidth-60-40, 40*scale_h)];
    desc.text = @"可邀请5位好友加入纷享城市，每邀请一位好友并实名后，您将获得10个原力的额外奖励";
    desc.textAlignment = NSTextAlignmentCenter;
    desc.font = [UIFont systemFontOfSize:15*scale_h];
    desc.textColor = kGrayColor;
    desc.numberOfLines = 0;
    desc.adjustsFontSizeToFitWidth = YES;
    [_topView addSubview:desc];
}

- (void)setBottomViewFrame{
    _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 410*scale_h, kWidth-60, 180*scale_h)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.layer.cornerRadius = 10;
    _bottomView.layer.masksToBounds = YES;
    [_scrollview addSubview:_bottomView];
    
    _qrCodeView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-100*scale_h-60)/2, 20*scale_h, 100*scale_h, 100*scale_h)];
    //_qrCodeView.backgroundColor = [UIColor whiteColor];
    _qrCodeView.layer.cornerRadius = 10;
    _qrCodeView.layer.masksToBounds = YES;
    [_bottomView addSubview:_qrCodeView];
    
    UILabel* desc2 = [[UILabel alloc] initWithFrame:CGRectMake(0,130*scale_h, kWidth-60, 20*scale_h)];
    desc2.text = @"请在浏览器中扫码下载纷享城市App";
    desc2.textAlignment = NSTextAlignmentCenter;
    desc2.font = [UIFont systemFontOfSize:14*scale_h];
    desc2.textColor = kGrayColor;
    [_bottomView addSubview:desc2];
    
    UILabel* desc3 = [[UILabel alloc] initWithFrame:CGRectMake(0,150*scale_h, kWidth-60, 20*scale_h)];
    desc3.text = @"基于区块链生态价值共享平台";
    desc3.textAlignment = NSTextAlignmentCenter;
    desc3.font = [UIFont systemFontOfSize:14*scale_h];
    desc3.textColor = RGBCOLOR(0x7961e9);
    [_bottomView addSubview:desc3];
    
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
