//
//  CustomLoader.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/26.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "CustomLoader.h"

@interface CustomLoader ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator ;

@end

@implementation CustomLoader

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self setCustomLoaderView];
    }
    return self;
}

- (void)setCustomLoaderView{
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.frame = CGRectMake((kWidth-80)/2, (kHeight-80)/2, 80, 80);
    //设置小菊花颜色
//    self.activityIndicator.color = [UIColor redColor];
 
        [self addSubview:_activityIndicator];
    [_activityIndicator startAnimating]; // 开始旋转
}


@end
