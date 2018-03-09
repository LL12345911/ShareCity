//
//  Helper.h
//  ZenCushion
//
//  Created by Mars on 16/8/23.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>



#define USER_First @"user_sign_first" //
#define IsAutoLogin @"IsAutoLogin" //是否自动登录 1自动登录 0 不自动登录
#define USER_Token @"user_token" //用户token


#define NetworkReachability @"NetworkReachability"  //网络状态 1有网 0断网


@interface Helper : NSObject

/**
 *  记录App打开次数
 */
+ (void)recordAppOpenTimes;
/**
 *  返回App打开次数
 */
+ (NSInteger)appOpenTimes;
/**
 *  是否是第一次打开App
 */
+ (BOOL)isFirstOpenApp;



+ (void)setValue:(id)value forkey:(NSString *)key;

+ (id)getValueForKey:(NSString *)key;

+ (void)removeValueForKey:(NSString *)key;

+ (void)removeAll;



@end
