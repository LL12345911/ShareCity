//
//  MHHttpTool.m
//  CarRental
//
//  Created by Mars on 6/20/16.
//  Copyright © 2016 Mars. All rights reserved.
//

#import "MHHttpTool.h"
#import "AFNetworking.h"


@implementation MHHttpTool

///  没touken 拼接传
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                       success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
                       failure:(nullable void (^)(NSError *error))failure  {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutinterval"];
    
    //[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    NSURLSessionDataTask *dataTask = [manager POST:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success((NSDictionary *)jsonDict);

//            if (success) {
//                NSData *dataObj = responseObject;
//                NSString *dataStr =  [[NSString alloc]initWithData:dataObj encoding:NSUTF8StringEncoding];
//                NSDictionary *dic = [NSString dictionaryWithJsonString:dataStr];
//                success((NSDictionary *)dic);
//               // success((NSDictionary *)responseObject);
//            }
//            NSData *dataObj = responseObject;
//            NSString *dataStr =  [[NSString alloc]initWithData:dataObj encoding:NSUTF8StringEncoding];
//            
//            NSDictionary *dic = [NSString dictionaryWithJsonString:[dataStr aci_decryptWithAES]];
//            success((NSDictionary *)dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure) {
            failure(error);
        }
    }];
    return dataTask;
}
/////  没touken 拼接传
//+ (void)POST1:(NSString *)URLString
//   parameters:(nullable id)parameters
//      success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//      failure:(nullable void (^)(NSError *error))failure  {
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes =
//    [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"httpss" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSString *cerPath1 = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
//    NSData * certData1 =[NSData dataWithContentsOfFile:cerPath1];
//    //导入多个证书
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData,certData1, nil];
//    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    // 是否允许,NO-- 不允许无效的证书
//    [securityPolicy setAllowInvalidCertificates:YES];
//    // 设置证书
//    [securityPolicy setPinnedCertificates:certSet];
//    manager.securityPolicy = securityPolicy;
//    securityPolicy.validatesDomainName = NO;
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 10.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    
//   [manager POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (success) {
//            
//            NSData *dataObj = responseObject;
//            NSString *dataStr =  [[NSString alloc]initWithData:dataObj encoding:NSUTF8StringEncoding];
//            
//            NSDictionary *dic = [NSString dictionaryWithJsonString:[dataStr aci_decryptWithAES]];
//            success((NSDictionary *)dic);
//            //success((NSDictionary *)responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//+ (void)Uploading:(NSString *)URLString
//       parameters:(nullable id)parameters
//          success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//          failure:(nullable void (^)(NSError *error))failure  {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    [manager POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        NSData *imagedata = [parameters objectForKey:@"avatar"];
//        [formData appendPartWithFileData:imagedata name:@"avatar" fileName:@"avatar.jpg" mimeType:@"multipart/form-data"];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (success) {
//            success((NSDictionary *)responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//+(void)Uploading:(NSString *)URLString
//      parameters:(nullable id)parameters DataArr:(NSMutableArray *)arr TypeArr:(NSMutableArray *)type
//         success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//         failure:(nullable void (^)(NSError *error))failure  {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    [manager POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        //NSArray *imagarr = [parameters objectForKey:@"files"];
//        for (NSInteger i=0; i<arr.count; i++) {
//            
//            NSData *imagedata=arr[i];
//            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *str = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//            [formData appendPartWithFileData:imagedata name:[NSString stringWithFormat:@"pic%ld",i+1] fileName:fileName mimeType:[NSString stringWithFormat: @"image/%@",type[i]]];
//        }
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (success) {
//            success((NSDictionary *)responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//+(void)POST7:(NSString *)URLString
//  parameters:(nullable id)parameters
//     success:(nullable void (^)(NSDictionary * _Nullable responseDic))success
//     failure:(nullable void (^)(NSError *error))failure  {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    [manager POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        NSData *imageDatae = [parameters objectForKey:@"photo"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//        [formData appendPartWithFileData:imageDatae name:@"photo" fileName:fileName mimeType:[NSString stringWithFormat: @"image/jpg"]];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (success) {
//            success((NSDictionary *)responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

@end
