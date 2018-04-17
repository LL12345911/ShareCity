//
//  EnergChargeTool.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/2.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnergChargeTool : NSObject


/**
 加入购物车的动画效果
 
 @param goodsImage 商品图片
 @param startPoint 动画起点
 @param endPoint   动画终点
 @param completion 动画执行完成后的回调
 */
+ (void)addToEnergChargeWithGoodsImage:(UIImage *)goodsImage
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                             completion:(void (^)(BOOL finished))completion;


@end
