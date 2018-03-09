//
//  UIButton+Countdown.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Countdown)

- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(void))countDownBlock;

- (void)cancleCountDown;

@end
