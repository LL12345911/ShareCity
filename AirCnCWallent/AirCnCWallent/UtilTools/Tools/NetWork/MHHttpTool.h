//
//  MHHttpTool.h
//  CarRental
//
//  Created by Mars on 6/20/16.
//  Copyright © 2016 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 基于AFNetworking的网络请求
 */
@interface MHHttpTool : NSObject
NS_ASSUME_NONNULL_BEGIN

///  没touken 拼接传
///
///  @param URLString  url
///  @param parameters 参数
///  @param success    成功回调
///  @param failure    错误回调
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
   parameters:(nullable id)parameters
      success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
      failure:(nullable void (^)(NSError *error))failure;

///  上传文件
///
///  @param URLString  url
///  @param parameters 参数
///  @param success    成功回调
///  @param failure    错误回调
/*
 
 @param URLString  url
 @param parameters 参数
 @param success    成功回调
 @param failure    错误回调
 @Param arr data   图片的二进制数组
 @param  type      图片格式数组
// */
//+ (void)Uploading:(NSString *)URLString
//   parameters:(nullable id)parameters
//      success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//      failure:(nullable void (^)(NSError *error))failure;
//
//
//+(void)Uploading:(NSString *)URLString
//  parameters:(nullable id)parameters DataArr:(NSMutableArray *)arr TypeArr:(NSMutableArray *)type
//     success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//     failure:(nullable void (^)(NSError *error))failure;
//
//+(void)POST7:(NSString *)URLString
//  parameters:(nullable id)parameters
//     success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//     failure:(nullable void (^)(NSError *error))failure;

NS_ASSUME_NONNULL_END
@end
