//
//  BaseViewController.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (nonatomic, assign) BOOL isShow;//默认不显示  yes 显示  重新加载按钮
@property (nonatomic, assign) BOOL showIndicatorView;// yes 显示 no 不显示

//设置导航栏背景图片
- (void)setupNavBarBackgroundImage:(NSString *)imageName;
// 设置初始导航栏透明度
- (void)setBackgroundAlpha:(float)alpha;
//刷新数据   点击重新加载按钮 的方法
- (void)overloadingReloadData;
//设置状态栏 背景色 为 透明
- (void)setStatusBarColor:(UIColor *)color;
//设置状态栏 背景为 图片
- (void)setStatusBarBackgroundImage:(UIImage *)image;


@end
