//
//  PayPasswordView.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^InputPasswordCompletionBlock)(NSString *password);

@interface PayPasswordView : UIView

@property (nonatomic,copy) InputPasswordCompletionBlock completionBlock;

/** 更新输入框数据 */
- (void)updateLabelBoxWithText:(NSString *)text;

/** 抖动输入框 */
- (void)startShakeViewAnimation;

- (void)didInputPasswordError;


@end
