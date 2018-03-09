//
//  NSString+Extend.m
//  CarRental
//
//  Created by Mars on 2017/5/16.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonCrypto.h>

#define PI 3.1415926
@implementation NSString (Extend)

/**
 判断字符串是否为空字符的方法

 @param string 判断的字符串
 @return yes or NO
 */
+ (BOOL) isBlankString:(NSString *)string {
    
   // NSString *string = string;
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
    
   
}

+ (NSURL *)returnNSUTF8StringEncodingNSUrl:(NSString *)image_pic host:(NSString *)host{
    NSString *urlImage3 = [NSString stringWithFormat:@"%@/%@",host,image_pic]; //
    //NSString *imageDataStr3 = [urlImage3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSString *imageDataStr3 = [self NSUTF8StringEncodingNSUrl:urlImage3];
    NSURL *url = [NSURL URLWithString:imageDataStr3];
    return url;
}

+ (NSURL *)returnNSUTF8StringEncodingNSUrl:(NSString *)image_pic{
    NSString *urlImage3 = [NSString stringWithFormat:@"%@",image_pic]; //
//    NSString *imageDataStr3 = [urlImage3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSString *imageDataStr3 = [self NSUTF8StringEncodingNSUrl:urlImage3];
    NSURL *url = [NSURL URLWithString:imageDataStr3];
    return url;
}

+ (NSString *)NSUTF8StringEncodingNSUrl:(NSString *)image_pic{
    NSString *imageDataStr3 = [image_pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return imageDataStr3;
}

/**
 *  判断自己是否为空
 *
 *  @return <#return value description#>
 */
- (BOOL) isBlank
{
    if (!self.length ||
        self == nil ||
        self == NULL ||
        (NSNull *)self == [NSNull null] ||
        [self isKindOfClass:[NSNull class]] ||
        [self isEqualToString:@"(null)"] ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"null"] ||
        [self isEqualToString:@"NULL"]
        ) {
        return YES;
    }else {
        return NO;
    }
}

/**
 *  json字符串，转成字典
 *
 *  字符串调用
 *  @return <#return value description#>
 */
- (NSDictionary *)stringJsonToDictionary{
    if ([self isBlank]) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dictionary;
}

/**
 *  字典转json字符串
 *
 *  字典调用
 *  @return <#return value description#>
 */
- (NSString *)dictionaryToJsonString:(NSDictionary *)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  数组转json字符串
 *
 *  数组调用
 *  @return <#return value description#>
 */
+ (NSString *)arrayToJsonString:(NSArray *)arr{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}

+ (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}


#pragma mark - calculate distance  根据2个经纬度计算距离
+(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}
#pragma mark -
#pragma mark - 时间转时间戳
//获取当地时间
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

/**
 时间转时间戳 1970

 @param timeStr 时间字符串
 @return 时间戳
 */
+ (NSString *)timeToTimeIntervalSince1970:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];//格式化
    //NSString* timeStr = @"2016-11-2 10:58:50";
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [formatter dateFromString:timeStr];
    NSString *timestampStr = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    return timestampStr;
}
/**
 时间转时间戳 1970
 
 @param timeStr 时间字符串 @"YYYY-MM-dd HH:mm:ss"
 @return 时间戳
 */
+ (NSString *)timeTToTimeIntervalSince19702:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];//格式化
    //NSString* timeStr = @"2016-11-2 10:58:50";
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datenow = [formatter dateFromString:timeStr];
    NSString *timestampStr = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    return timestampStr;
}

/**
 时间转时间戳 now
 
 @param timeStr 时间字符串
 @return 时间戳
 */
+ (NSString *)timeToTimeIntervalSinceNow:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];//格式化
    //NSString* timeStr = @"2016-11-2 10:58:50";
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datenow = [formatter dateFromString:timeStr];
    NSString *timestampStr = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSinceNow]];
    return timestampStr;
}



/**
 把格式化的JSON格式的字符串转换成字典
 @param jsonString JSON格式的字符串
 @return 返回字典   json格式字符串转字典：
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DebugLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 把字典转换成格式化的JSON格式的字符串
 @param dic 字典
 @return JSON格式的字符串   字典转json格式字符串：
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        DebugLog(@"%@",error);
        return nil;
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    NSRange range = {0,jsonString.length};
//    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

/**
 获取指定宽度情况下，字符串textContent的高度
 
 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @return 返回的高度
 */
+(float)heightForString:(NSString *)textContent fontSize:(float)fontSize andWeight:(float)weight{
    
    CGSize titleSize = [textContent boundingRectWithSize:CGSizeMake(weight, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return titleSize.height;
    
}

/**
 获取指定宽度情况下，字符串textContent的高度
 
 @param textContent 待计算的字符串
 @param font 字体的大小
 @param weight 宽度
 @return 返回的高度
 */
+(float)heightForString:(NSString *)textContent font:(UIFont *)font andWeight:(float)weight{
    CGSize titleSize = [textContent boundingRectWithSize:CGSizeMake(weight, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize.height;
}



/**
  获取指定宽度情况下，字符串textContent的高度

 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @return 返回的高度
 */
+(float)heightForString:(NSString *)textContent fontSize:(float)fontSize{
    
     CGSize titleSize = [textContent boundingRectWithSize:CGSizeMake(kWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return titleSize.height;
    
}


/**
 获取指定宽度情况下，字符串textContent的宽度
 
 @param textContent 待计算的字符串
 @param fontSize 字体的大小
 @param height 高度
 @return 返回的宽度
 */
+(float)widthForString:(NSString *)textContent fontSize:(float)fontSize andHeight:(float)height{
    
    CGSize titleSize = [textContent boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return titleSize.width;
    
}

/**
 获取指定宽度情况下，字符串textContent的宽度
 
 @param textContent 待计算的字符串
 @param font 字体的大小
 @param height 高度
 @return 返回的宽度
 */
+(float)widthForString:(NSString *)textContent font:(UIFont *)font andHeight:(float)height{
    CGSize titleSize = [textContent boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize.width;
}




/**
 *  返回字符串所占用的尺寸
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark -  时间戳转时间
+ (NSString *)getDateAccordingTime:(NSString *)aTime formatStyle:(NSString *)formate{
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:[aTime intValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:formate];
    return[formatter stringFromDate:nowDate];
}


- (BOOL)dateOnlyBetweenTwoMonth:(NSString *)time1 andTime:(NSString *)time2{
    //@"2017-06-09 09:04"
    int year1 = [[time1 substringToIndex:4] intValue];
    int year2 = [[time2 substringToIndex:4] intValue];
    
    int month1 = [[time1 substringWithRange:NSMakeRange(5, 2)] intValue];
    int month2 = [[time2 substringWithRange:NSMakeRange(5, 2)] intValue];
    
    int day1 = [[time1 substringWithRange:NSMakeRange(8, 2)] intValue];
    int day2 = [[time2 substringWithRange:NSMakeRange(8, 2)] intValue];
    
    BOOL flag = YES;
    if ((year1 > year2) || ((year2-year1)>0) ) {
        flag = NO;
        
        if ((year2-year1) == 1 ) {
            if ((month2+12 - month1) == 2) {
                if (day1 <= day2) {
                    flag = YES;
                }
            }else if ((month2+12 - month1) == 1){
                flag = YES;
            }
        }
        
        return flag;
        
    }else{
        if ((month1 > month2) || ((month2-month1)>2)) {
            flag = NO;
            return flag;
        }else if ((month2 - month1) == 2) {
            if ((day1 < day2)) {
                
                flag = NO;//no
                return flag;
            }
        }else if ((month2 - month1) <= 1) {
            flag = YES;
            
        }
    }
    return flag;
}

@end
