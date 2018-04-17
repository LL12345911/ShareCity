//
//  DisplayImageView.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/2.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DisplayImageViewDeletage <NSObject>

/**
 DisplayImageViewDeletage 移除版本新特性  加载进入画面
 */
- (void)removeDisplayImageViewFromSuperview;

@end
@interface DisplayImageView : UIView

@property (nonatomic, weak) id<DisplayImageViewDeletage> deletage;
//
//+ (instancetype)sharedInstance;
//- (void)showIamgeViewForView;

@end

