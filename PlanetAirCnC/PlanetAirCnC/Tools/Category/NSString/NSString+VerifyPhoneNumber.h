//
//  NSString+VerifyPhoneNumber.h
//  RentalCar
//
//  Created by Mars on 2017/6/22.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VerifyPhoneNumber)

/**
 验证电话号码与手机号码的正则方法
 @param mobileNum 电话号码与手机号码
 @return yes 正确  no 不是标准电话号码
 */
+ (BOOL)verifyThePhoneNumber:(NSString *)mobileNum;


/**
 拨打电话
 @param phoneNum 电话号码
 */
+ (void)callPhoneStr:(NSString*)phoneNum;


/**
 判断 是否是 iPhone X

 @return 是 或 否
 */
+ (BOOL)isIphoneX;

@end
