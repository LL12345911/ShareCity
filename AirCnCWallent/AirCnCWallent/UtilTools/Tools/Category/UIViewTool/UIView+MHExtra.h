//
//  UIView+Extra.h
//  
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 *  @brief view的拓展
 */
@interface UIView (MHExtra)


/**
 *  返回UIView及其子类的位置和尺寸。分别为左、右边界在X轴方向上的距离，上、下边界在Y轴上的距离，View的宽和高。
 */
/**
* Shortcut for frame.origin.x.
* Sets frame.origin.x = left
*/
@property(nonatomic, assign) CGFloat left;
/**
 * Shortcut for frame.origin.x + frame.size.width
 * Sets frame.origin.x = right - frame.size.width
 */
@property(nonatomic, assign) CGFloat right;
/**
 * Shortcut for frame.origin.y
 * Sets frame.origin.y = top
 */
@property(nonatomic, assign) CGFloat top;
/**
 * Shortcut for frame.origin.y + frame.size.height
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property(nonatomic, assign) CGFloat bottom;
/**
 * Shortcut for frame.size.width
 * Sets frame.size.width = width
 */
@property(nonatomic, assign) CGFloat width;
/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property(nonatomic, assign) CGFloat height;
/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property(nonatomic, assign) CGFloat centerX;
/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property(nonatomic, assign) CGFloat centerY;
/**
 * Shortcut for frame.size
 */
@property(nonatomic, assign) CGSize size;
/**
 * Shortcut for frame.origin
 */
@property(nonatomic, assign) CGPoint origin;
/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat screenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat screenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;


/*!
 *  @brief  设置视图圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

/*!
 *  @brief  设置边框
 */
- (void)setBorderWidth:(CGFloat)borderWidth;

/*!
 *  @brief  设置边框颜色
 */
- (void)setBorderColor:(UIColor *)borderColor;

/**
 *  @brief  移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  @brief 获取viewcontroller
 */
- (UIViewController *)viewController;
/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 Attaches the given block for a single tap action to the receiver.
 @param block The block to execute.
 */
- (void)setTapActionWithBlock:(void (^)(void))block;

/**
 Attaches the given block for a long press action to the receiver.
 @param block The block to execute.
 */
- (void)setLongPressActionWithBlock:(void (^)(void))block;

@end
