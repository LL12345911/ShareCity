//
//  NSString+Extend.h
//  CarRental
//
//  Created by Mars on 2017/5/16.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)


#pragma mark - 判断输入的字符串是否全为数字
/**
 判断输入的字符串是否全为数字
 @param checkedNumString 检测的字符串
 @return yes 是全为数字  no 有其他字符
 */
+ (BOOL)isNum:(NSString *)checkedNumString;



/**
 判断字符串是否为空字符的方法
 
 @param string 判断的字符串
 @return yes or NO
 */
+ (BOOL) isBlankString:(NSString *)string;


+ (NSURL *)returnNSUTF8StringEncodingNSUrl:(NSString *)image_pic host:(NSString *)host;

+ (NSURL *)returnNSUTF8StringEncodingNSUrl:(NSString *)image_pic;

#pragma mark - calculate distance  根据2个经纬度计算距离
+(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;
/**
 *  判断自己是否为空
 *
 *  @return 是否为空
 */
- (BOOL) isBlank;
/**
 *  json字符串，转成字典
 *
 *  字符串调用
 *  @return 字典
 */
- (NSDictionary *)stringJsonToDictionary;
/**
 *  字典转json字符串
 *
 *  字典调用
 *  @return json字符串
 */
- (NSString *)dictionaryToJsonString:(NSDictionary *)dic;
/**
 *  数组转json字符串
 *
 *  数组调用
 *  @return 数组转json字符串
 */
+ (NSString *)arrayToJsonString:(NSArray *)arr;
/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj;

//获取当地时间
+ (NSString *)getCurrentTime;

#pragma mark -
#pragma mark - 时间转时间戳
/**
 时间转时间戳 1970
 @param timeStr 时间字符串
 @return 时间戳
 */
+ (NSString *)timeToTimeIntervalSince1970:(NSString *)timeStr;


/**
 时间转时间戳 1970
 
 @param timeStr 时间字符串 @"YYYY-MM-dd HH:mm:ss"
 @return 时间戳
 */
+ (NSString *)timeTToTimeIntervalSince19702:(NSString *)timeStr;

/**
 时间转时间戳 now
 @param timeStr 时间字符串
 @return 时间戳
 */
+ (NSString *)timeToTimeIntervalSinceNow:(NSString *)timeStr;

/**
 把格式化的JSON格式的字符串转换成字典
 @param jsonString JSON格式的字符串
 @return 返回字典   json格式字符串转字典：
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 把字典转换成格式化的JSON格式的字符串
 @param dic 字典
 @return JSON格式的字符串   字典转json格式字符串：
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *  MD5加密, 32位 小写
 *  @param str 传入要加密的字符串
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *  @param str 传入要加密的字符串
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *  @param str 传入要加密的字符串
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *  @param str 传入要加密的字符串
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
/**
 获取指定宽度情况下，字符串textContent的高度
 
 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @return 返回的高度
 */
+(float)heightForString:(NSString *)textContent fontSize:(float)fontSize andWeight:(float)weight;

/**
 获取指定宽度情况下，字符串textContent的高度
 
 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @return 返回的高度
 */

/**
 获取指定宽度情况下，字符串textContent的高度

 @param textContent 待计算的字符串
 @param font 字体的大小
 @param weight 宽度
 @return 返回的高度
 */
+(float)heightForString:(NSString *)textContent font:(UIFont *)font andWeight:(float)weight;


/**
 获取指定宽度情况下，字符串textContent的宽度
 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @param height 高度
 @return 返回的宽度
 */
+(float)widthForString:(NSString *)textContent fontSize:(float)fontSize andHeight:(float)height;



/**
  获取指定宽度情况下，字符串textContent的宽度

 @param textContent 待计算的字符串
 @param font 字体的大小
 @param height 高度
 @return 返回的宽度
 */
+(float)widthForString:(NSString *)textContent font:(UIFont *)font andHeight:(float)height;


/**
 获取指定宽度情况下，字符串textContent的高度
 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @return 返回的高度
 */
+(float)heightForString:(NSString *)textContent fontSize:(float)fontSize;

/**
 *  返回字符串所占用的尺寸
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

#pragma mark -  时间戳转时间

/**
 时间戳转时间
 @param aTime 开始时间
 @param formate YYYY-MM-HH HH：MM：SS
 @return 相隔的时间
 */
+ (NSString *)getDateAccordingTime:(NSString *)aTime formatStyle:(NSString *)formate;





@end
