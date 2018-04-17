//
//  UIButton+Countdown.m
//  AirCnCWallent
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "UIButton+Countdown.h"

static NSString *yasinTempText;



@implementation UIButton (Countdown)

- (void)startCountDownTime:(int)time textNormalColor:(UIColor *)normalColor  textColor:(UIColor *)color withCountDownBlock:(void(^)(void))countDownBlock{
    
    [self initButtonData];
    
    [self startTime:time textNormalColor:normalColor textColor:color];
    
    if (countDownBlock) {
        countDownBlock();
    }
}

- (void)cancleCountDown{
    
}

- (void)initButtonData{
    
    yasinTempText = [NSString stringWithFormat:@"%@",self.titleLabel.text];
    
}

- (void)startTime:(int)time textNormalColor:(UIColor *)normalColor  textColor:(UIColor *)color{
    
    __block int timeout = time;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束
        if(timeout <= 0){
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:yasinTempText forState:UIControlStateNormal];
                [self setTitleColor:normalColor forState:0];
                self.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *text = [NSString stringWithFormat:@"%02d秒重新获取",timeout];
                [self setTitle:text forState:UIControlStateNormal];
                [self setTitleColor:color forState:0];
                self.userInteractionEnabled = NO;
                
            });
            
            timeout --;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}

@end
