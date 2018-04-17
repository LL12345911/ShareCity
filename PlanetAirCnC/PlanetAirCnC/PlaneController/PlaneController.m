//
//  PlaneController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "PlaneController.h"
#import "LoginController.h"
#import "PlaneRankCell.h"
#import "AutoScrollLabel.h"
#import "TXScrollLabelView.h"
#import "DiamondsRecordController.h"
#import "RecordForceController.h"
#import "TaskViewController.h"
#import "InviteCodeController.h"

#import "EnergyView.h"
#import "EnergChargeTool.h"
#import "AirCnCUpdateApp.h"
#import <AVFoundation/AVFoundation.h>

#import "Addition.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64

@interface PlaneController ()<UITableViewDelegate,UITableViewDataSource,TXScrollLabelViewDelegate,EnergyViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) AutoButton *starsBtn;
@property (nonatomic, strong) UIView *autoBack;//跑马灯背景视图
@property (nonatomic, strong) UIButton *autoLeft;//跑马灯
@property (nonatomic, strong) AutoScrollLabel *autoLabel;//跑马灯效果
@property (strong, nonatomic) TXScrollLabelView *scrollLabelView;
@property (assign, nonatomic) IBInspectable BOOL isArray;

@property (nonatomic, strong) UIButton *rubybtn;//
@property (nonatomic, strong) UIButton *forceBtn;//
@property (nonatomic, strong) UIButton *secretBtn;//

@property (nonatomic, strong) UIButton *speedBtn;//
@property (nonatomic, strong) UIButton *inviteBtn;//

@property (nonatomic, strong) EnergyView *energyView;

//需要指向AVPlay的强引用
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@end

@implementation PlaneController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self AirCnCUpdateAppMethod];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
   // self.customNavBar.title = @"纷享基地";
    [self setupNavBarBackgroundImage:nil];
    self.isShow = YES;
    
    // 设置初始导航栏透明度
    [self setBackgroundAlpha:0];
    [self setStatusBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self setStatusBarColor:[UIColor purpleColor]];
    
    [self.view addSubview:self.tableview];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[PlaneRankCell class] forCellReuseIdentifier:NSStringFromClass([PlaneRankCell class])];
    
    [self setTableviewHeadView];
    
//    _starsBtn  =  [AutoButton buttonWithType:SJButtonTypeVerticalImageTitle];
//    [_starsBtn setTitle:@"这个是按钮上的标题" forState:SJControlStateNormal];
//    [_starsBtn setImage:[UIImage imageNamed:@"1024"] forState:SJControlStateNormal];
//    [_starsBtn setTitleColor:[UIColor whiteColor] forState:SJControlStateHighlighted];
//    _starsBtn.layer.borderColor = [UIColor blackColor].CGColor;
//    _starsBtn.layer.borderWidth = 1;
//    _starsBtn.font = [UIFont systemFontOfSize:12];
//    [_starsBtn addTarget:self action:@selector(logintOutMethodForButton)];//  actionForButton
//    [_headView addSubview:_starsBtn];
//    _starsBtn.frame = CGRectMake(100, 0, 100, 100);
//    _starsBtn.center = _headView.center;
//
    
    __weak typeof(self) weakSelf = self;
    [self.tableview bindRefreshStyle:KafkaRefreshStyleReplicatorWoody fillColor:kOrangeColor atPosition:0 refreshHanler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            
            
//            if (weakSelf.energyView.viewArr.count == 0) {
                [weakSelf.energyView setViewFrameByRandom:30];
//            }
            
            [weakSelf.tableview.headRefreshControl endRefreshing];
        });
    }];


//    [self.tableview.headRefreshControl beginRefreshing];
    
    self.showIndicatorView = NO;
    
    
//    scale: 小数点后保留的位数
//    RoundingMode: 小数保留的类型
//    根据官方文档说明, 枚举值分析:
//    NSRoundPlain, 四舍五入
//    NSRoundDown, 只舍不入
//    NSRoundUp, 只入不舍
//    NSRoundBankers 四舍六入,
    

    
//    NSDecimalNumberHandler *hander = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:15 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
//    
//    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:@"3.1415926000000000000"];
//    NSDecimalNumber *number2= [NSDecimalNumber decimalNumberWithString:@"3.00000000011001111111"];
//
//    number = [number decimalNumberByAdding:number2 withBehavior:hander];
//    
//    NSDecimalNumber *resultDN = [number decimalNumberByRoundingAccordingToBehavior:hander];
//    NSLog(@"%@",number);
//    
//    
//    NSString *str = [Addition additionOfString:@"999999.000000000000000000001" AndString:@"2.000000000000000000001"];
////    NSString *str = [Addition addTwoNumberWithOneNumStr:@"0.000000000000000000001" anotherNumStr:@"0.000000000000000000001"];
//    NSLog(@"%@",str);
}






#pragma mark - 加速黑钻
- (void)pushSpeedRubyController{
    DebugLog(@"加速黑钻 +++++++++ ");
    TaskViewController *view = [[TaskViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 邀请好友
- (void)pushInviteFriendsController{
    DebugLog(@"邀请好友 +++++++++ ");
    InviteCodeController *view = [[InviteCodeController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 秘籍
- (void)pushSecretController{
    DebugLog(@"秘籍 +++++++++ ");
//    RecordForceController *view = [[RecordForceController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 原力值
- (void)pushRecordForceController{
//    RecordForceController *view = [[RecordForceController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
    
    [self logintOutMethodForButton];
}

#pragma mark - 黑钻记录
- (void)pushDiamondsRecordController{
//    DiamondsRecordController *view = [[DiamondsRecordController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
    
     [self logintOutMethodForButton];
}
#pragma mark - 重新刷新
- (void)overloadingReloadData{
    DebugLog(@"++++++++++++++");
}
#pragma mark - 登录
- (void)logintOutMethodForButton{
    LoginController *login = [[LoginController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark - 跑马灯代理
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
}



- (void)setTableviewHeadView{
//    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 500+40*scale_h)];
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 500+(kWidth-20)/10.0*8)];

    _headView.backgroundColor = kBlueColor;
    _tableview.tableHeaderView = _headView;
    
    _autoBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40*scale_h)];
    _autoBack.backgroundColor = [UIColor purpleColor];
     [_headView addSubview:_autoBack];
    
    _autoLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 30, 40*scale_h)];
    [_autoLeft setTitle:@"公告：" forState:0];
    [_autoLeft setImage:[UIImage imageNamed:@"喇叭"] forState:0];
    _autoLeft.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [_autoLeft sizeToFit];
    _autoLeft.height = 40*scale_h;
     [_headView addSubview:_autoLeft];
//
//    _autoLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(_autoLeft.right, 0, kWidth-_autoLeft.right-10, 30*scale_h)];
//    _autoLabel.text = @"全场卖两块，买啥都两块，两块钱，你买不了吃亏，两块钱，你买不了上当，真正的物有所值。拿啥啥便宜 买啥啥不贵，都两块，买啥都两块，全场卖两块，随便挑，随便选，都两块～～";
//    _autoLabel.textColor = [UIColor whiteColor];
//    _autoLabel.scrollEnabled = NO;
//    [_autoBack addSubview:_autoLabel];
//    _autoLabel.tapGestureBlock = ^{
//        DebugLog(@"实现Block");
//    };
//    //
//    ////根据实际情况，添加速度及之间间距
//    ////    autoLabel.speed = 70;
//    ////    autoLabel.labelBetweenGap = 10;
    
    
    NSArray *scrollTexts = @[@"全场卖两块，买啥都两块，两块钱，你买不了吃亏，两块钱，你买不了上当，真正的物有所值。拿啥啥便宜 买啥啥不贵，都两块，买啥都两块，全场卖两块，随便挑，随便选，都两块～～",
                            ];
    _scrollLabelView = [TXScrollLabelView scrollWithTextArray:scrollTexts type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
   _scrollLabelView.scrollLabelViewDelegate = self;
    _scrollLabelView.frame = CGRectMake(_autoLeft.right, 0, kWidth-_autoLeft.right-10, 40*scale_h);
    _scrollLabelView.font = [UIFont systemFontOfSize:15*scale_h];
    _scrollLabelView.backgroundColor = [UIColor clearColor];
    [_autoBack addSubview:_scrollLabelView];
    [_scrollLabelView beginScrolling];
    
    
    [_headView addSubview:self.rubybtn];
    [_headView addSubview:self.forceBtn];
    [_headView addSubview:self.secretBtn];
    
    
     [_headView addSubview:self.speedBtn];
     [_headView addSubview:self.inviteBtn];
    
    
    _energyView = [[EnergyView alloc] initWithFrame:CGRectMake(0, 150*scale_h, kWidth, kWidth*0.8)];
    _energyView.delegate = self;
    [_headView addSubview:_energyView];
    
    [_energyView setViewFrameByRandom:30];
    

  
}

- (void)energyViewClickButton:(NSInteger)tag{
    
    UIButton *button = _energyView.viewArr[tag];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[button convertRect:button.bounds toView:window];
    CGPoint startPoint = CGPointMake(rect.origin.x+rect.size.width/2.0, rect.origin.y+rect.size.height/2.0);
    
    CGRect rect2 =[self.rubybtn convertRect:self.rubybtn.bounds toView:window];
    CGPoint endPoint = CGPointMake(rect2.origin.x+rect2.size.width/2.0, rect2.origin.y+rect2.size.height/2.0);
    
    [button removeFromSuperview];
//    [_energyView.viewArr removeObjectAtIndex:tag];
    
    
    [self gameMusic];
    
    [EnergChargeTool addToEnergChargeWithGoodsImage:[UIImage imageNamed:@"钻石"] startPoint:startPoint endPoint:endPoint completion:^(BOOL finished) {
        NSLog(@"动画结束了");
        //------- 颤抖吧 -------//
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
        scaleAnimation.duration = 0.1;
        scaleAnimation.repeatCount = 2; // 颤抖两次
        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.rubybtn.layer addAnimation:scaleAnimation forKey:nil];
        
        [self.audioPlayer stop];
        
    }];
    
}

//产生音乐
-(void)gameMusic{
 
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake_match.wav" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:nil];
    self.audioPlayer.volume = 1;
    [self.audioPlayer play];
    [self.audioPlayer setNumberOfLoops:1000000];
    
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlaneRankCell *rankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PlaneRankCell class]) forIndexPath:indexPath];
    [rankCell setValueModel:@"" indexPathRow:indexPath.row];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rankCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80*scale_h;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    
    UIView *rankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40*scale_h)];
    rankView.backgroundColor = [UIColor whiteColor];
    [view addSubview:rankView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40*scale_h)];
    label.text = @"排行榜";
    label.font = [UIFont systemFontOfSize:16*scale_h];
    [rankView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWidth-40, 40*scale_h)];
    label2.text = @"排行榜1小时更新一次";
    label2.font = [UIFont systemFontOfSize:13*scale_h];
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = kGrayColor;
    [rankView addSubview:label2];
    
    UIView *rankView2 = [[UIView alloc] initWithFrame:CGRectMake(-1, 40*scale_h, kWidth+2, 40*scale_h)];
    rankView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    rankView2.layer.borderColor = kGrayColor.CGColor;
    rankView2.layer.borderWidth = 0.5;
    [view addSubview:rankView2];
    
    UILabel *label21 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, (kWidth-80*3-50), 40*scale_h)];
    label21.text = @"名次";
    label21.font = [UIFont systemFontOfSize:16*scale_h];
    [rankView2 addSubview:label21];
    
    UILabel *label22 = [[UILabel alloc] initWithFrame:CGRectMake(20+(kWidth-80*3-50)+10, 0, 80, 40*scale_h)];
    label22.text = @"普通黑钻";
    label22.font = [UIFont systemFontOfSize:16*scale_h];
    label22.textAlignment = NSTextAlignmentRight;
    [rankView2 addSubview:label22];
    
    UILabel *label23 = [[UILabel alloc] initWithFrame:CGRectMake(20+(kWidth-80*3-50)+10+90, 0, 70, 40*scale_h)];
    label23.text = @"幸运钻";
    label23.font = [UIFont systemFontOfSize:16*scale_h];
    label23.textColor = [UIColor purpleColor];
    label23.textAlignment = NSTextAlignmentRight;
    [rankView2 addSubview:label23];
    
    UILabel *label24 = [[UILabel alloc] initWithFrame:CGRectMake(20+(kWidth-80*3-50)+10+90+80, 0, 70, 40*scale_h)];
    label24.text = @"原力";
    label24.font = [UIFont systemFontOfSize:16*scale_h];
    label24.textAlignment = NSTextAlignmentRight;
    [rankView2 addSubview:label24];
    return view;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
}

#pragma mark - 导航栏 隐藏显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
         [self setBackgroundAlpha:alpha];//:alpha];
        self.customNavBar.title = @"纷享基地";
    }
    else
    {
        [self setBackgroundAlpha:0];
        self.customNavBar.title = @"";
    }
    
    //让uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}




#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kWidth, kHeight-kTabBar-kStatusBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.sectionIndexColor = kBlueColor;
        _tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}

- (UIButton *)rubybtn{
    if (!_rubybtn) {
        _rubybtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50*scale_h, 150, 30*scale_h)];
        [_rubybtn setImage:[UIImage imageNamed:@"钻石"] forState:0];
        [_rubybtn setTitle:@"黑钻 0.1" forState:0];
        _rubybtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        [_rubybtn addTarget:self action:@selector(pushDiamondsRecordController) forControlEvents:UIControlEventTouchUpInside];
        [_rubybtn setTitleColor:[UIColor purpleColor] forState:0];
        _rubybtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _rubybtn;
}

- (UIButton *)forceBtn{
    if (!_forceBtn) {
        _forceBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 90*scale_h, 150, 30*scale_h)];
        [_forceBtn setImage:[UIImage imageNamed:@"能量"] forState:0];
        [_forceBtn setTitle:@"原力 78" forState:0];
        _forceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        [_forceBtn addTarget:self action:@selector(pushRecordForceController) forControlEvents:UIControlEventTouchUpInside];
        [_forceBtn setTitleColor:[UIColor purpleColor] forState:0];
        _forceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    return _forceBtn;
}


- (UIButton *)secretBtn{
    if (!_secretBtn) {
        _secretBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-100, 50*scale_h, 100, 30*scale_h)];
//        [_secretBtn setBackgroundImage:[UIImage imageNamed:@"能量"] forState:0];
        [_secretBtn setTitle:@"纷享秘籍" forState:0];
        _secretBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        [_secretBtn addTarget:self action:@selector(pushSecretController) forControlEvents:UIControlEventTouchUpInside];
        [_secretBtn setTitleColor:[UIColor purpleColor] forState:0];
        _secretBtn.backgroundColor = [UIColor whiteColor];
        
    }
    return _secretBtn;
}


- (UIButton *)speedBtn{
    if (!_speedBtn) {
        
        //_speedBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 500-40*scale_h-60*scale_h, (kWidth-80)/2, 40*scale_h)];
        _speedBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 180*scale_h+kWidth*0.8, (kWidth-80)/2, 40*scale_h)];
        [_speedBtn setBackgroundImage:[UIImage imageNamed:@"ruby_Image"] forState:0];
        [_speedBtn setTitle:@"加速黑钻" forState:0];
        _speedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        [_speedBtn addTarget:self action:@selector(pushSpeedRubyController) forControlEvents:UIControlEventTouchUpInside];
        [_speedBtn setTitleColor:[UIColor purpleColor] forState:0];
//        _speedBtn.backgroundColor = [UIColor whiteColor];
        
    }
    return _speedBtn;
}

- (UIButton *)inviteBtn{
    if (!_inviteBtn) {
        //_inviteBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-80)/2+60, 500-40*scale_h-60*scale_h, (kWidth-80)/2, 40*scale_h)];
         _inviteBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-80)/2+60, 180*scale_h+kWidth*0.8, (kWidth-80)/2, 40*scale_h)];
        [_inviteBtn setBackgroundImage:[UIImage imageNamed:@"invite_Image"] forState:0];
        [_inviteBtn setTitle:@"邀请好友得原力" forState:0];
        _inviteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        [_inviteBtn addTarget:self action:@selector(pushInviteFriendsController) forControlEvents:UIControlEventTouchUpInside];
        [_inviteBtn setTitleColor:[UIColor purpleColor] forState:0];
//        _inviteBtn.backgroundColor = [UIColor whiteColor];
    }
    return _inviteBtn;
}









#pragma mark - APP检查更新
- (void)AirCnCUpdateAppMethod{
    //=================根据appid检测====================
    [AirCnCUpdateApp hs_updateWithAPPID:@"1238010598" withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, NSString *releaseNotes, BOOL isUpdate) {
        if (isUpdate) {
            
            [self showAlertViewTitle:@"有新版了!" subTitle:[NSString stringWithFormat:@"\n您的纷享城不是最新版本，请立即更新?\n"] openUrl:openUrl];
            //  DebugLog(@"当前版本%@,商店版本，需要更新=============",openUrl);
        }
    }];
    
    //    unsigned int count=0;
    //    Ivar *ivars = class_copyIvarList([UIAlertController class], &count);
    //    for (int i = 0; i<count; i++) {
    //        Ivar ivar = ivars[i];
    //        NSLog(@"%s------%s", ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    //    }
}

-(void)showAlertViewTitle:(NSString *)title subTitle:(NSString *)subTitle openUrl:(NSString *)openUrl{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
    // UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"忽略此版本" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"立即升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        float version =  [[[UIDevice currentDevice] systemVersion] floatValue];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:^(BOOL success) {
            }];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
        }
    }];
    
    //修改title
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    //设置颜色
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:kOrangeColor range:NSMakeRange(0, alertControllerStr.length)];
    //设置大小
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, alertControllerStr.length)];
    //替换title
    [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
    
    //修改message
    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:subTitle];
    //设置文字大小，并没有设置文字颜色
    [messageStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, messageStr.length)];
    //进行替换
    [alertVC setValue:messageStr forKey:@"attributedMessage"];
    
    //    [cancel setValue:kGrayColor forKey:@"titleTextColor"];
    //    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
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
