//
//  UIButton+Countdown.h
//  AirCnCWallent
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Countdown)

//- (void)startCountDownTime:(int)time textColor:(UIColor *)color withCountDownBlock:(void(^)(void))countDownBlock;
- (void)startCountDownTime:(int)time textNormalColor:(UIColor *)normalColor  textColor:(UIColor *)color withCountDownBlock:(void(^)(void))countDownBlock;
- (void)cancleCountDown;



//@property (nonatomic, strong) dispatch_source_t timer;


@end
