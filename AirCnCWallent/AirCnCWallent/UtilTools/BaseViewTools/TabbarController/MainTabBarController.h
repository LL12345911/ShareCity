//
//  MainTabBarController.h
//  AirCnCWallet
//
//  Created by Mars on 2018/1/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 底部 TabBar 控制器
 */
@interface MainTabBarController : UITabBarController

/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;


@end
