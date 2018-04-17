//
//  Helper.m
//  ZenCushion
//
//  Created by Mars on 16/8/23.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "Helper.h"
#import "API.h"
@implementation Helper

/**
 *  记录App打开次数
 */
+ (void)recordAppOpenTimes  {
    //取出打开次数
    NSInteger times =  [[NSUserDefaults standardUserDefaults]integerForKey:kAppOpenTimes];
    //次数加1
    times++;
    [[NSUserDefaults standardUserDefaults] setInteger:times forKey:kAppOpenTimes];
}

/**
 *  返回App打开次数
 */
+ (NSInteger)appOpenTimes {
    return [[NSUserDefaults standardUserDefaults]integerForKey:kAppOpenTimes];
}

/**
 *  是否是第一次打开App
 */
+ (BOOL)isFirstOpenApp  {
    //    return YES
    
    if ([Helper appOpenTimes] == 1) {
        return YES;
    }
    return NO;
}



+ (void)setValue:(id)value forkey:(NSString *)key {
    [self removeValueForKey:key];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}


+ (void)removeAll {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //删除所有数据
    NSDictionary *dictionary = [userDefaults dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [userDefaults removeObjectForKey:key];
        [userDefaults synchronize];
    }
    //    userDefaults = nil;
    //    [userDefaults synchronize];
}


+ (id)getValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *retStr = [userDefaults stringForKey:key];
    return retStr;
}


+ (void)removeValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}
@end
