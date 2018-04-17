//
//  AutoScrollLabel.h
//  AirCnCWallent
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DirtionType){
    
    DirtionTypeLeft, //left
    DirtionTypeRight //right
    
};

typedef void(^TapGestureRecognizerBlock)(void);

@interface AutoScrollLabel : UIScrollView

//set Text
@property (nonatomic, copy) NSString *text;
// label and label gap
@property (nonatomic, assign) NSInteger labelBetweenGap;
//deafult 2 秒
@property (nonatomic, assign) NSInteger pauseTime;
//deafult DirtionTypeLeft
@property (nonatomic, assign) DirtionType dirtionType;
//set speed ,default 30
@property (nonatomic, assign) NSInteger speed;
//set Color
@property (nonatomic, strong) UIColor  *textColor;
//点击手势 block
@property (nonatomic, copy) TapGestureRecognizerBlock tapGestureBlock;


- (void)rejustlabels;


//AutoScrollLabel *autoLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width, 40)];
//autoLabel.text = @"跑马灯效果！哈哈哈哈哈哈，实现了，看看效跑马灯效果！哈哈哈哈哈哈，实现了，看看效果好不好果好不好";
////color
//autoLabel.textColor = [UIColor redColor];
//[self.view addSubview:autoLabel];
//
////根据实际情况，添加速度及之间间距
////    autoLabel.speed = 70;
////    autoLabel.labelBetweenGap = 10;


@end
