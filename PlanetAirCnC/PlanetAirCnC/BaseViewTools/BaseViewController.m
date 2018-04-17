//
//  BaseViewController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomLoader.h"


@interface BaseViewController ()

@property (nonatomic, strong) UIImageView *activeImage;
@property (nonatomic, strong) UIButton *activeBtn;
@property (nonatomic, strong) CustomLoader *loader;
//@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *indicatorBack;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.customNavBar wr_setBottomLineHidden:YES];

    //设置导航栏背景图片
    [self setupNavBarBackgroundImage:nil];
    
    //设置导航栏的左边 返回按钮的图片
    [self setLeftButtonWithImage];
    //设置空白视图
    [self setBlankView];
    
//    [self setStatusBarBackgroundColor:kNavColor];
//    [self setStatusBarBackgroundImage:[UIImage imageNamed:@"navImage"]];
    
    //设置状态栏 字体颜色为 白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)startLoading{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.windowLevel = UIWindowLevelAlert;
    
    if (_indicatorBack) {
        [_indicatorBack removeAllSubviews];
        _indicatorBack.frame = CGRectMake(0, kHeight, kWidth, kHeight);
    }
    
    
   _indicatorBack = [[UIView alloc] init];
    _indicatorBack.frame = CGRectMake(0, 0, kWidth, kHeight);
    _indicatorBack.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [window addSubview:_indicatorBack];
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //设置显示位置
    _indicator.center = CGPointMake(kWidth/2.0, kHeight/2.0);
    _indicator.hidesWhenStopped = NO;
//    _indicator.color = [UIColor whiteColor];
    [_indicatorBack addSubview:_indicator];
    [_indicator startAnimating];
}

- (void)stopLoading{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_indicatorBack removeAllSubviews];
        _indicatorBack.frame = CGRectMake(0, kHeight, kWidth, kHeight);
        [_indicator removeAllSubviews];
        
    });
}


- (void)stopLoading:(float)time{
    //    [_indicator stopAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_indicatorBack removeAllSubviews];
        _indicatorBack.frame = CGRectMake(0, kHeight, kWidth, kHeight);
        [_indicator removeAllSubviews];
        
    });
    
    
}

//设置状态栏 背景色 为 透明
- (void)setStatusBarColor:(UIColor *)color{
    [self setStatusBarBackgroundColor:color];
}
//设置状态栏 背景为 图片
- (void)setStatusBarBackgroundImage:(UIImage *)image{
     [self setStatusBarBackgroundImage2:image];
}


- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
   // if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
   // }
    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:statusBar.frame];
//    imageview.backgroundColor = color;
//    [statusBar addSubview:imageview];
    
}

- (void)setStatusBarBackgroundImage2:(UIImage *)image {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor clearColor];

    UIImageView *imageview = [[UIImageView alloc] initWithFrame:statusBar.frame];
    imageview.image = image;
    [statusBar addSubview:imageview];
    
    [self.view insertSubview:imageview aboveSubview:statusBar];
    
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setShowIndicatorView:(BOOL)showIndicatorView{
    if (showIndicatorView) {
        if (_loader) {
            [_loader removeFromSuperview];
        }
        _loader = [[CustomLoader alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        //[self.view addSubview:_loader];
        UIView *showView = [UIApplication sharedApplication].keyWindow;
        [showView addSubview:_loader];
    }else{
         [_loader removeFromSuperview];
        _loader = nil;
    }
}

- (void)setIsShow:(BOOL)isShow{
    _activeImage.hidden = !isShow;
    _activeBtn.hidden = !isShow;
}

//设置空白视图
- (void)setBlankView{
    _activeImage = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-100)/2, (kHeight-100)/2, 100, 100)];
    _activeImage.image = [UIImage imageNamed:@"placeholder_remote"];
    _activeImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_activeImage];
    
    _activeBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-100)/2, (kHeight-100)/2+100, 100, 25)];
    [_activeBtn setTitle:@"重新加载" forState:0];
    _activeBtn.backgroundColor = [UIColor lightGrayColor];
    [_activeBtn setTitleColor:kOrangeColor forState:0];
    _activeBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [_activeBtn addTarget:self action:@selector(overloadingReloadData1) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:_activeBtn];
    
    _activeImage.hidden = YES;
    _activeBtn.hidden = YES;
}

- (void)overloadingReloadData1{
    _activeImage.hidden = YES;
    _activeBtn.hidden = YES;
    [self overloadingReloadData];
    DebugLog(@"刷新数据");
}
//刷新数据
- (void)overloadingReloadData{
   
}

//设置设置导航栏的左边 返回按钮的图片
- (void)setLeftButtonWithImage{
    NSArray *arr = self.navigationController.childViewControllers;
    if (arr.count == 1) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage new]];
    }else{
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"commenBackBtn"]];
    }
}

// 设置初始导航栏透明度
- (void)setBackgroundAlpha:(float)alpha{
    [self.customNavBar wr_setBackgroundAlpha:0];
    if (alpha != 0) {
        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
}

//设置导航栏背景图片
- (void)setupNavBarBackgroundImage:(NSString *)imageName{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"navImage"];
    
    if (imageName.length > 0) {
        self.customNavBar.barBackgroundImage = [UIImage imageNamed:imageName];
    }
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar wr_setLeftButtonWithTitle:@"" titleColor:[UIColor whiteColor]];
    }
}

- (WRCustomNavigationBar *)customNavBar{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
