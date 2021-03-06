//
//  MainTabBarController.m
//  AirCnCWallet
//
//  Created by Mars on 2018/1/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "MainTabBarController.h"

#import "UITabBar+CustomBadge.h"
#import "MarsTabBar.h"
#import "BaseNavigationController.h"
//#import "PlaneController.h"
//#import "MineController.h"

#import "DigitalAssetsController.h"
#import "HomeController.h"
#import "CountTaskController.h"


@interface MainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC


@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
    self.selectedIndex = 1;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[MarsTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
  

    
//    PlaneController *homeVC = [[PlaneController alloc]init];
//    [self setupChildViewController:homeVC title:@"纷享城市" imageName:@"11" seleceImageName:@"111"];

    CountTaskController *task = [[CountTaskController alloc]init];
    [self setupChildViewController:task title:@"算力任务" imageName:@"算力任务1" seleceImageName:@"算力任务"];
    
    HomeController *home = [[HomeController alloc]init];
    [self setupChildViewController:home title:@"" imageName:@"home1" seleceImageName:@"home"];

    
  
    DigitalAssetsController *assets = [[DigitalAssetsController alloc]init];
    [self setupChildViewController:assets title:@"数字资产" imageName:@"数字资产1" seleceImageName:@"数字资产"];

    
    
    
    

    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kGrayColor,NSFontAttributeName:[UIFont systemFontOfSize:12*scale_h]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavColor,NSFontAttributeName:[UIFont systemFontOfSize:12*scale_h]} forState:UIControlStateSelected];
    //包装导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
    
    
//    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    
    if ([controller isKindOfClass:[HomeController class]]) {
        controller.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    
    //    [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
    
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
    
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
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
