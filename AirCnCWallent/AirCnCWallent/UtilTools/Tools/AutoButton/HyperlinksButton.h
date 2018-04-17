//
//  HyperlinksButton.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyperlinksButton : UIButton
{
    UIColor *lineColor;
}


/**
 button 加 下划线

 @param color 颜色
 */
-(void)setColor:(UIColor*)color;


@end
