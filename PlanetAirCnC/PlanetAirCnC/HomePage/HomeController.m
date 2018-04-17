//
//  HomeController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
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
#import "HyperlinksButton.h"
#import "HomePageCell.h"
#import "AccountSetController.h"
#import "MyIncomeController.h"
#import "IntroduceController.h"

#import "AssetsAddController.h"



#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64


@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,TXScrollLabelViewDelegate,EnergyViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) AutoButton *starsBtn;
@property (nonatomic, strong) UIView *autoBack;//跑马灯背景视图
@property (nonatomic, strong) UIButton *autoLeft;//跑马灯
@property (nonatomic, strong) AutoScrollLabel *autoLabel;//跑马灯效果
@property (strong, nonatomic) TXScrollLabelView *scrollLabelView;
@property (nonatomic,strong) HyperlinksButton *moreBtn;

@property (assign, nonatomic) IBInspectable BOOL isArray;

@property (nonatomic, strong) UIImageView *introduce;//
@property (nonatomic, strong) UILabel *introduceL;//
@property (nonatomic, strong) UIButton *introduceBtn;//

@property (nonatomic, strong) UIButton *calculateBtn;//当前算力
@property (nonatomic, strong) UIButton *myIncome;//我的收入
@property (nonatomic, strong) UIButton *inviteFriends;//邀请好友
@property (nonatomic, strong) EnergyView *energyView;
//需要指向AVPlay的强引用
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;


@end

@implementation HomeController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    [self setupNavBarBackgroundImage:nil];
    self.isShow = YES;
    
    // 设置初始导航栏透明度
//    [self setBackgroundAlpha:0];
//    [self setStatusBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self setStatusBarColor:[UIColor purpleColor]];
    
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"设置"]];
    
    __block typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        AccountSetController *account = [[AccountSetController alloc] init];
        [weakSelf.navigationController pushViewController:account animated:YES];
    };
    
    [self.view addSubview:self.tableview];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[HomePageCell class] forCellReuseIdentifier:NSStringFromClass([HomePageCell class])];
    
    [self setTableviewHeadView];
    
    //__weak typeof(self) weakSelf = self;
    [self.tableview bindRefreshStyle:KafkaRefreshStyleReplicatorWoody fillColor:kOrangeColor atPosition:0 refreshHanler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.energyView setViewFrameByRandom:30];
            [weakSelf.tableview.headRefreshControl endRefreshing];
        });
    }];
    //    [self.tableview.headRefreshControl beginRefreshing];
    
    self.showIndicatorView = NO;
    
    
    for (int i=0; i<100; i++) {
        printf("\"digital%02d\" = \"\";\n",i);
    }
}




#pragma mark - 我的收入
- (void)billingRecordsMethod{
    DebugLog(@"我的收入 +++++++++ ");
    MyIncomeController *incomeView = [[MyIncomeController alloc] init];
    [self.navigationController pushViewController:incomeView animated:YES];
}


#pragma mark - 纷享城介绍
- (void)introduceMethod{
    DebugLog(@"纷享城介绍 +++++++++ ");
    IntroduceController *view = [[IntroduceController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 邀请好友
- (void)pushInviteFriendsController{
    DebugLog(@"邀请好友 +++++++++ ");
//    InviteCodeController *view = [[InviteCodeController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
    
    
    LoginController *view = [[LoginController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    
//    AssetsAddController *view = [[AssetsAddController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
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

    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth,260*scale_h+kWidth*0.8+(kWidth-40)*200/690.0)];
    _headView.backgroundColor = [UIColor whiteColor];
    _tableview.tableHeaderView = _headView;
    
    _autoBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40*scale_h)];
    _autoBack.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_headView addSubview:_autoBack];
    
    _autoLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 30, 40*scale_h)];
    [_autoLeft setTitle:@"" forState:0];
    [_autoLeft setImage:[UIImage imageNamed:@"喇叭"] forState:0];
    _autoLeft.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
//    [_autoLeft sizeToFit];
    _autoLeft.height = 40*scale_h;
    [_headView addSubview:_autoLeft];
 
    
    NSArray *scrollTexts = @[@"全场卖两块，买啥都两块，两块钱，你买不了吃亏，两块钱，你买不了上当，真正的物有所值。拿啥啥便宜 买啥啥不贵，都两块，买啥都两块，全场卖两块，随便挑，随便选，都两块～～",
                             ];
    _scrollLabelView = [TXScrollLabelView scrollWithTextArray:scrollTexts type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    _scrollLabelView.scrollLabelViewDelegate = self;
    _scrollLabelView.frame = CGRectMake(_autoLeft.right, 0, kWidth-_autoLeft.right-10-50, 40*scale_h);
    _scrollLabelView.font = [UIFont systemFontOfSize:15*scale_h];
    _scrollLabelView.backgroundColor = [UIColor clearColor];
    _scrollLabelView.scrollTitleColor = kGrayColor;
    [_autoBack addSubview:_scrollLabelView];
    [_scrollLabelView beginScrolling];
    
    [_headView addSubview:self.moreBtn];
    [_headView addSubview:self.introduce];
    //[_introduce addSubview:self.introduceL];
    
    [_introduce addSubview:self.introduceBtn];
    
    //_introduceL.attributedText = [self setAttributedStr:@"纷享城介绍" withStr2:@"纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍"];
    
    [_introduceBtn setAttributedTitle:[self setAttributedStr:@"纷享城介绍" withStr2:@"纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍纷享城介绍"] forState:0];
    
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80*scale_h+(kWidth-40)*200/690.0, kWidth, 120*scale_h+kWidth*0.8+60*scale_h)];
    backImage.image = [UIImage imageNamed:@"背景2"];
    backImage.userInteractionEnabled = YES;
    [_headView addSubview:backImage];
    
    [backImage addSubview:self.calculateBtn];
    
    
    _energyView = [[EnergyView alloc] initWithFrame:CGRectMake(0, 80*scale_h, kWidth, kWidth*0.8)];
    _energyView.delegate = self;
    [backImage addSubview:_energyView];
    //我的收入
     [backImage addSubview:self.myIncome];
    //邀请好友
    [backImage addSubview:self.inviteFriends];
    
    
    [_energyView setViewFrameByRandom:30];
    [_calculateBtn setAttributedTitle:[self setAttributedTotal:@"78" withbasePow:@"57" plusPow:@"45"] forState:0];
}

#pragma mark - 收取 代理
- (void)energyViewClickButton:(NSInteger)tag{
    
    UIButton *button = _energyView.viewArr[tag];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[button convertRect:button.bounds toView:window];
    CGPoint startPoint = CGPointMake(rect.origin.x+rect.size.width/2.0, rect.origin.y+rect.size.height/2.0);
    
    CGRect rect2 =[self.calculateBtn convertRect:self.calculateBtn.bounds toView:window];
    CGPoint endPoint = CGPointMake(rect2.origin.x+rect2.size.width/2.0, rect2.origin.y+rect2.size.height/2.0);
    
    [button removeFromSuperview];
    //    [_energyView.viewArr removeObjectAtIndex:tag];
    
    
    [self gameMusic];
    
    [self chargingAnimationShareCoinStartPoint:startPoint endPoint:endPoint];

    
}
#pragma mark - 收取动画
- (void) chargingAnimationShareCoinStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    [EnergChargeTool addToEnergChargeWithGoodsImage:[UIImage imageNamed:@"组28"] startPoint:startPoint endPoint:endPoint completion:^(BOOL finished) {
        NSLog(@"动画结束了");
        //------- 颤抖吧 -------//
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
        scaleAnimation.duration = 0.1;
        scaleAnimation.repeatCount = 2; // 颤抖两次
        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.calculateBtn.layer addAnimation:scaleAnimation forKey:nil];
        
        [self.audioPlayer stop];
        
    }];
}

#pragma mark - 产生音乐
-(void)gameMusic{
    if (self.audioPlayer.isPlaying) {
        [self.audioPlayer stop];
    }
    
    if (!_audioPlayer) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shake_match.wav" ofType:@""];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:nil];
        self.audioPlayer.volume = 1;
        [self.audioPlayer setNumberOfLoops:1000000];
    }
    
    [self.audioPlayer play];
}

#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*scale_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePageCell *rankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomePageCell class]) forIndexPath:indexPath];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rankCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60*scale_h;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 60*scale_h)];
    label.text = @"排行榜";
    label.font = [UIFont boldSystemFontOfSize:18*scale_h];
    [label sizeToFit];
    [view addSubview:label];
    label.height = 60*scale_h;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label.right+10*scale_h, 5*scale_h, kWidth-40, 55*scale_h)];
    label2.text = @"昨日纷享钻排行榜";
    label2.font = [UIFont systemFontOfSize:13*scale_h];
    label2.textColor = kGrayColor;
    [view addSubview:label2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 60*scale_h-1, kWidth, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:line];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 导航栏 隐藏显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > NAVBAR_COLORCHANGE_POINT)
//    {
//        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
//        [self setBackgroundAlpha:alpha];//:alpha];
//        self.customNavBar.title = @"纷享基地";
//    }
//    else
//    {
//        [self setBackgroundAlpha:0];
//        self.customNavBar.title = @"";
//    }

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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTabBar-kTop)];
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


- (HyperlinksButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[HyperlinksButton alloc] initWithFrame:CGRectMake(kWidth-50, 0, 50, 40*scale_h)];
        [_moreBtn setTitle:@"更多" forState:0];
        [_moreBtn setTitleColor:kGrayColor forState:0];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_moreBtn setColor:kGrayColor];
        //[_moreBtn addTarget:self action:@selector(copyMethodForButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}


- (UIImageView *)introduce{
    if (!_introduce) {
        _introduce = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60*scale_h, (kWidth-40), (kWidth-40)*200/690.0)];
//        _introduce.backgroundColor = [UIColor redColor];
        _introduce.userInteractionEnabled = YES;
        _introduce.image = [UIImage imageNamed:@"背景1"];
    }
    return _introduce;
}

- (UIButton *)introduceBtn{
    if (!_introduceBtn) {
        _introduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, kWidth-60, (kWidth-40)*200/690.0)];
        [_introduceBtn addTarget:self action:@selector(introduceMethod) forControlEvents:UIControlEventTouchUpInside];
        _introduceBtn.titleLabel.numberOfLines = 0;
        [_introduceBtn setTitleColor:[UIColor whiteColor] forState:0];
        _introduceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //_introduceBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _introduceBtn;
}

- (UIButton *)calculateBtn{
    if (!_calculateBtn) {
        _calculateBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-170, 0, 170, 50*scale_h)];
        [_calculateBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形10"] forState:0];
        _calculateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        //[_calculateBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        [_calculateBtn setTitleColor:[UIColor purpleColor] forState:0];
        _calculateBtn.titleLabel.numberOfLines = 0;
        _calculateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _calculateBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _calculateBtn;
}

- (UIButton *)myIncome{
    if (!_myIncome) {
        _myIncome = [[UIButton alloc] initWithFrame:CGRectMake(20, 120*scale_h+kWidth*0.8, 120*scale_h, 40*scale_h)];
        [_myIncome setBackgroundImage:[UIImage imageNamed:@"圆角矩形9"] forState:0];
        [_myIncome setImage:[UIImage imageNamed:@"收入"] forState:0];
        [_myIncome setTitle:@"我的收入" forState:0];
        _myIncome.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _myIncome.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_myIncome addTarget:self action:@selector(billingRecordsMethod) forControlEvents:UIControlEventTouchUpInside];
//        _myIncome.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _myIncome;
}

- (UIButton *)inviteFriends{
    if (!_inviteFriends) {
        _inviteFriends = [[UIButton alloc] initWithFrame:CGRectMake(40+120*scale_h, 120*scale_h+kWidth*0.8, 120*scale_h, 40*scale_h)];
        [_inviteFriends setBackgroundImage:[UIImage imageNamed:@"圆角矩形122"] forState:0];
        [_inviteFriends setImage:[UIImage imageNamed:@"邀请好友_H"] forState:0];
        [_inviteFriends setTitle:@"邀请好友" forState:0];
        _inviteFriends.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        _inviteFriends.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_inviteFriends addTarget:self action:@selector(pushInviteFriendsController) forControlEvents:UIControlEventTouchUpInside];
//        _inviteFriends.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _inviteFriends;
}

//- (UIButton *)myIncome{
//    if (!_myIncome) {
//        _myIncome = [[UIButton alloc] initWithFrame:CGRectMake(20, 120*scale_h+kWidth*0.8, 50*210/80.0*scale_h, 50*scale_h)];
//        [_myIncome setBackgroundImage:[UIImage imageNamed:@"组262"] forState:0];
//        [_myIncome addTarget:self action:@selector(billingRecordsMethod) forControlEvents:UIControlEventTouchUpInside];
//        [_myIncome setTitleColor:[UIColor purpleColor] forState:0];
//        _myIncome.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    }
//    return _myIncome;
//}
//
//- (UIButton *)inviteFriends{
//    if (!_inviteFriends) {
//        _inviteFriends = [[UIButton alloc] initWithFrame:CGRectMake(40+50*210/80.0*scale_h, 120*scale_h+kWidth*0.8, 50*210/80.0*scale_h, 50*scale_h)];
//        [_inviteFriends setBackgroundImage:[UIImage imageNamed:@"组26"] forState:0];
//        [_inviteFriends addTarget:self action:@selector(pushInviteFriendsController) forControlEvents:UIControlEventTouchUpInside];
//        [_inviteFriends setTitleColor:[UIColor purpleColor] forState:0];
//        _inviteFriends.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    }
//    return _inviteFriends;
//}

- (NSMutableAttributedString *)setAttributedStr:(NSString *)str1 withStr2:(NSString *)str2{
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    NSRange rangleft = NSMakeRange(0, str1.length+1);
    NSRange range2 = NSMakeRange(strAtt.length-str2.length, str2.length);
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:range2];
    return strAtt;
}


- (NSMutableAttributedString *)setAttributedTotal:(NSString *)total withbasePow:(NSString *)basePow plusPow:(NSString *)plusPow{
    
    NSString *powStr = [NSString stringWithFormat:@"当前算力:%@  ",total];
    NSString *plusStr = [NSString stringWithFormat:@"基础算力:%@  加成系数:%@%% ",basePow,plusPow];
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",powStr,plusStr]];
    
    NSRange rangleft = NSMakeRange(0, powStr.length);
    NSRange range2 = NSMakeRange(strAtt.length-plusStr.length, plusStr.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:range2];
    
    NSMutableParagraphStyle *warnParagraph = [[NSMutableParagraphStyle alloc] init];
    warnParagraph.lineSpacing = 2;//行间距
    warnParagraph.alignment = NSTextAlignmentCenter;
    [strAtt addAttribute:NSParagraphStyleAttributeName value:warnParagraph range:NSMakeRange(0, strAtt.length)];
    
    
    return strAtt;
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


@end
