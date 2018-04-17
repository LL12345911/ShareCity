//
//  UIImage+QRcode.h
//  AirCnCWallent
//
//  Created by Mars on 2018/3/6.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CenterImgType) {
    // 方形
    CenterImgType_Square = 0,
    // 圆形
    CenterImgType_Circle = 1,
    // 切圆角
    CenterImgType_CornorRadious = 2
};


@interface UIImage (QRcode)

/** */
@property (nonatomic , assign) CGFloat logoScal;
/** 创建普通二维码
 *  @param string 数据
 *  @param size 二维码的大小
 * @param completion 二维码制作成功回调block
 */
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size completion:(void (^)(UIImage *image))completion;
/** 创建自定义颜色二维码
 * @param string     数据
 * @param size       二维码的大小
 * @param color      二维码的颜色
 * @param completion 二维码制作成功回调block
 */
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size withColor:(CIColor *)color completion:(void (^)(UIImage *image))completion;
/** 创建带有图标二维码（默认正方形）
 * @param string     数据
 * @param size       二维码的大小
 * @param iconImage  图标
 * @param type       自定义二维码图片的种类（中间图片为方形，中间图片为圆形）
 * @param scale      头像占二维码图像的比例默认0.2(0~1)
 * @param completion 二维码制作成功回调block
 */
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size WithIconImage:(UIImage *)iconImage withScal:(CGFloat)scale CenterImageType:(CenterImgType)type completion:(void (^)(UIImage *image))completion;
/** 创建自定义颜色带有图标的二维码
 * @param string     数据
 * @param size       二维码的大小
 * @param color      二维码的颜色
 * @param type       自定义二维码图片的种类（中间图片为方形，中间图片为圆形）
 * @param iconImage  图标
 * @param scale      头像占二维码图像的比例默认0.2(0~1)
 * @param completion 二维码制作成功回调block
 */
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size withColor:(CIColor *)color WithIconImage:(UIImage *)iconImage withScal:(CGFloat)scale CenterImageType:(CenterImgType)type completion:(void (^)(UIImage *image))completion;
/** 创建自定义颜色和背景色且带有logo的二维码
 * @param string           数据
 * @param size             二维码的大小
 * @param color            二维码的颜色
 * @param type             自定义二维码图片的种类（中间图片为方形，中间图片为圆形
 * @param iconImage        图标
 * @param backGroundColor  二维码背景色
 * @param scale       头像占二维码图像的比例默认0.2(0~1)
 * @param completion       二维码制作成功回调block
 */
+(void)CreateQrcodeWithTitle:(NSString *)string size:(CGFloat)size withColor:(CIColor *)color WithIconImage:(UIImage *)iconImage withBackGroundColor:(CIColor *)backGroundColor withScal:(CGFloat)scale CenterImageType:(CenterImgType)type completion:(void (^)(UIImage *image))completion;
/** 创建条形二维码
 * @param string 数据
 * @param completion 二维码制作成功回调block
 */
+(void)CreatBarCodeWithTitle:(NSString *)string completion:(void (^)(UIImage *image))completion;
/** 创建自定义颜色条形二维码
 *  @param string    数据
 *  @param color     二维码颜色
 * @param completion 二维码制作成功回调block
 */
+(void)CreatBarCodeWithTitle:(NSString *)string withColor:(CIColor *)color completion:(void (^)(UIImage *image))completion;

@end
