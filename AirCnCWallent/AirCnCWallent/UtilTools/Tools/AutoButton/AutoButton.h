//
//  AutoButton.h
//  AirCnCWallent
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SJControlState) {
    SJControlStateNormal,
    SJControlStateHighlighted,
    SJControlStateSelected
};

typedef NS_ENUM(NSInteger, SJButtonType) {
    /**
     * 竖直排布，图片在上，文字在下，默认类型
     */
    SJButtonTypeVerticalImageTitle,
    /**
     * 竖直排布，文字在上，图片在下
     */
    SJButtonTypeVerticalTitleImage,
    /**
     * 水平排布，图片在左，文字在右
     */
    SJButtonTypeHorizontalImageTitle,
    /**
     * 水平排布，文字在左，图片在右
     */
    SJButtonTypeHorizontalTitleImage
};


@interface AutoButton : UIControl

+ (instancetype)button;
+ (instancetype)buttonWithType:(SJButtonType)buttonType;

@property (nonatomic, readonly) SJButtonType buttonType;
@property (nonatomic, strong) UIFont *font;
/**
 * 只有在image是UIImageRenderingModeAlwaysTemplate的渲染类型时才有效
 */
@property (nonatomic, strong) UIColor *imageTintColor;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIImageView *imageView;
/**
 * 图片和文字之间的距离,默认为6
 */
@property (nonatomic) CGFloat space;

- (void)setImage:(UIImage *)image forState:(SJControlState)state;
- (void)setTitle:(NSString *)title forState:(SJControlState)state;
- (void)setTitleColor:(UIColor *)color forState:(SJControlState)state;
- (void)setBackgroundColor:(UIColor *)color forState:(SJControlState)state;

// UIControlEventTouchUpInside
- (void)addTarget:(id)target action:(SEL)action;

@end
