//
//  UIImage+QRcode.m
//  AirCnCWallent
//
//  Created by Mars on 2018/3/6.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "UIImage+QRcode.h"
#import <objc/runtime.h>
#define queue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@implementation UIImage (QRcode)

/** 创建二维码 */
#pragma mark - 给二维码设置背景（默认方形）
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size completion:(void (^)(UIImage *image))completion{
    [self CreateQrcodeWithTitle:string size:size WithIconImage:nil withScal:0.2 CenterImageType:0 completion:^(UIImage *image) {
        !completion ?: completion(image);
    }];
}
/*
 inputImage,     需要设定颜色的图片
 inputColor0,    前景色 - 二维码的颜色
 inputColor1     背景色 - 二维码背景的颜色
 */
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size withColor:(CIColor *)color completion:(void (^)(UIImage *image))completion{
    [self CreateQrcodeWithTitle:string size:size withColor:color WithIconImage:nil withScal:0 CenterImageType:0 completion:^(UIImage *image) {
        !completion ?: completion(image);
    }];
}

+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size WithIconImage:(UIImage *)iconImage withScal:(CGFloat)scale CenterImageType:(CenterImgType)type completion:(void (^)(UIImage *image))completion{
    NSAssert(completion, @"必须传入完成回调");
    dispatch_async(queue, ^{
        CIImage *ciimage = [self creatOrignQrcode:string];
        UIImage *image = [self createHighQualityUIImageFormCIImage:ciimage withSize:size];
        UIImage *okImage = image;
        if (iconImage) okImage = [self qrcodeImage:image addIconImage:iconImage centerImageType:type scale:scale];
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion ?: completion(okImage);
        });
    });
}

+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size withColor:(CIColor *)color WithIconImage:(UIImage *)iconImage withScal:(CGFloat)scale CenterImageType:(CenterImgType)type completion:(void (^)(UIImage *image))completion{
    [self CreateQrcodeWithTitle:string size:size withColor:color WithIconImage:iconImage withBackGroundColor:[CIColor colorWithRed:255 green:255 blue:255 alpha:1] withScal:scale CenterImageType:type completion:^(UIImage *image) {
        !completion ?: completion(image);
    }];
}

+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size withColor:(CIColor *)color WithIconImage:(UIImage *)iconImage withBackGroundColor:(CIColor *)backGroundColor withScal:(CGFloat)scale CenterImageType:(CenterImgType)type completion:(void (^)(UIImage *image))completion{
    NSAssert(completion, @"必须传入完成回调");
    NSLog(@"%@====%@",string,color);
    dispatch_async(queue, ^{
        CIImage *ciimage = [self creatOrignQrcode:string];
        ciimage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
        // 5.创建颜色过滤器
        CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
        NSLog(@"%@",colorFilter.inputKeys);
        // 6.设置默认值
        [colorFilter setDefaults];
        [colorFilter setValue:ciimage forKey:@"inputImage"];
        [colorFilter setValue:color forKey:@"inputColor0"];
        [colorFilter setValue:backGroundColor forKey:@"inputColor1"];
        ciimage = colorFilter.outputImage;
        UIImage *image = [UIImage imageWithCIImage:ciimage];
        UIImage *okImage = image;
        if (iconImage) okImage = [self qrcodeImage:image addIconImage:iconImage centerImageType:type scale:scale];
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion ?: completion(okImage);
        });
    });
}

+(void)CreatBarCodeWithTitle:(NSString *)string completion:(void (^)(UIImage *image))completion{
    [self CreatBarCodeWithTitle:string withColor:nil completion:^(UIImage *image) {
        !completion ?: completion(image);
    }];
}

+(void)CreatBarCodeWithTitle:(NSString *)string withColor:(CIColor *)color completion:(void (^)(UIImage *image))completion{
    dispatch_async(queue, ^{
        // 注意生成条形码的编码方式
        NSData *data = [string dataUsingEncoding: NSASCIIStringEncoding];
        CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        [filter setValue:data forKey:@"inputMessage"];
        // 设置生成的条形码的上，下，左，右的margins的值
        [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];
        CIImage *ciimage = filter.outputImage;
        if (color) {
            ciimage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
            CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
            // 6.设置默认值
            [colorFilter setDefaults];
            [colorFilter setValue:ciimage forKey:@"inputImage"];
            [colorFilter setValue:color forKey:@"inputColor0"];
            [colorFilter setValue:[CIColor colorWithRed:255 green:255 blue:255 alpha:1] forKey:@"inputColor1"];
            ciimage = colorFilter.outputImage;
        }
        UIImage *image = [UIImage imageWithCIImage:ciimage];
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion ?: completion(image);
        });
    });
}
/** 生成原始二维码 */
+(CIImage *)creatOrignQrcode:(NSString *)title{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSString *string = title;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];//给二维码过滤器添加信息
    //    L　: 7%
    //    M　: 15%
    //    Q　: 25%
    //    H　: 30%
    [filter setValue:@"H" forKeyPath:@"inputCorrectionLevel"];//给二维码过滤器添加信息
    // 3. 生成二维码
    return filter.outputImage;
}
/** 生成高质量二维码 */
+ (UIImage *)createHighQualityUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark  小图片二维码合并
+ (UIImage *)qrcodeImage:(UIImage *)qrImage addIconImage:(UIImage *)iconImage centerImageType:(CenterImgType) type scale:(CGFloat)scale{
    // 图片放大倍数等于屏幕分辨类
    //    CGFloat screenScale = [UIScreen mainScreen].scale; // 是屏幕分辨率
    //    CGRect rect = CGRectMake(0, 0, size, size);
    //    NSLog(@"rect=============%f",rect.size.width);
    //    UIGraphicsBeginImageContext(rect.size);
    //
    //    [qrImage drawInRect:rect];
    //
    //    if(iconImage){ // 如果有图片
    //        CGSize avatarSize = CGSizeMake(rect.size.width * scale, rect.size.height * scale);
    //        CGFloat x = (rect.size.width - avatarSize.width) * 0.5;
    //        CGFloat y = (rect.size.height - avatarSize.height) * 0.5;
    //        if (type == CenterImgType_Circle) { // 如果为圆形
    //            iconImage = [UIImage createCircularImage:iconImage];
    //        }else if (type == CenterImgType_CornorRadious){
    //            iconImage = [UIImage imageWithRoundedCorners:iconImage Size:avatarSize andCornerRadius:5.0f];
    //        }
    //        NSLog(@"%f=======%f",avatarSize.width,x);
    //        [iconImage drawInRect:CGRectMake(x, y, avatarSize.width, avatarSize.height)];
    //    }
    //    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return finalImage;
    //
    CGFloat screenScale = [UIScreen mainScreen].scale; // 是屏幕分辨率
    CGRect rect = CGRectMake(0, 0, qrImage.size.width * screenScale, qrImage.size.height * screenScale);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, screenScale);
    
    [qrImage drawInRect:rect];
    
    if(iconImage){ // 如果有图片
        
        CGSize avatarSize = CGSizeMake(rect.size.width * scale, rect.size.height * scale);
        CGFloat x = (rect.size.width - avatarSize.width) * 0.5;
        CGFloat y = (rect.size.height - avatarSize.height) * 0.5;
        if (type == CenterImgType_Circle) { // 如果为圆形
            
            iconImage = [UIImage createCircularImage:iconImage];
            
        }else if (type == CenterImgType_CornorRadious){
            iconImage = [UIImage imageWithRoundedCorners:iconImage Size:avatarSize andCornerRadius:5.0f];
        }
        
        [iconImage drawInRect:CGRectMake(x, y, avatarSize.width, avatarSize.height)];
    }
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:result.CGImage scale:screenScale orientation:UIImageOrientationUp] ;
}

#pragma mark - 剪裁圆形图片
+ (instancetype)createCircularImage:(UIImage *)iconImage{
    // 1. 创建一个bitmap类型图形上下文（空白的UiImage）
    // NO 将来创建的透明的UiImage
    // YES 不透明
    UIGraphicsBeginImageContextWithOptions(iconImage.size, NO, 0);
    // 2. 指定可用范围
    // 2.1 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2.2 画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, iconImage.size.width, iconImage.size.height));
    // 2.3 裁剪，指定将来可以画图的可用范围
    CGContextClip(ctx);
    // 3. 绘制图片
    [iconImage drawInRect:CGRectMake(0, 0, iconImage.size.width, iconImage.size.height)];
    // 4. 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 4.1 关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 图片切圆角
+ (UIImage *)imageWithRoundedCorners: (UIImage *)image Size:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius{
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [image drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

-(void)setLogoScal:(CGFloat)logoScal{
    objc_setAssociatedObject(self, "logoScal", [NSNumber numberWithFloat:logoScal], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)logoScal{
    return [objc_getAssociatedObject(self, "logoScal") floatValue];
}

@end
