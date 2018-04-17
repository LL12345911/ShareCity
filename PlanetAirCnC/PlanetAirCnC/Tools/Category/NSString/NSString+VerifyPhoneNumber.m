//
//  NSString+VerifyPhoneNumber.m
//  RentalCar
//
//  Created by Mars on 2017/6/22.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import "NSString+VerifyPhoneNumber.h"
#import "sys/utsname.h"


@implementation NSString (VerifyPhoneNumber)

+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}

+ (BOOL)verifyThePhoneNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186, 175,176,166,146,145
     17         */
    NSString * CU = @"^1(3[0-2]|4[56]|5[256]|6[6]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189 ,181,173,149,199,1410
     22         */
    NSString * CT = @"^1((33|49|53|73|77|99|8[019])[0-9]|349|410)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    NSString *GuoJI = @"^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
    NSPredicate *regextestGuo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", GuoJI];
    //[regextestct evaluateWithObject:mobileNumbel
    
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestPHS evaluateWithObject:mobileNum] == YES)
       || ([regextestGuo evaluateWithObject:mobileNum] == YES)){
        
        return YES;
    }else{
        return NO;
    }
}


#pragma mark -- 拨打电话
+ (void)callPhoneStr:(NSString*)phoneNum{
    if (phoneNum.length == 0) {
        return;
    }
    if (![NSString verifyThePhoneNumber:phoneNum]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号码格式错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callPhone]]) {
            /// 大于等于10.0系统使用此openURL方法
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            }
        }
    }else{
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callPhone]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }

    
//    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
//    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
//    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
//        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callPhone]]) {
//            /// 大于等于10.0系统使用此openURL方法
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
//        }
//    } else {
//        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callPhone]]) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
//        }
//    }
}


@end
