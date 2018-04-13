//
//  LoadingView.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, strong) UIView *superView;

@end

@implementation LoadingView

#pragma mark -lifeCycle
- (instancetype)init{
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor clearColor] ;//UIColorFromHEX(0xffffff);
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];
    
    [self.superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];
    
  
    
}

#pragma mark -Public

//+ (void)showPayPopView{
//    __weak typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.3 animations:^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
//    } completion:nil];
//}
//
//+ (void)hidePayPopView{
//    __weak typeof(self) weakSelf = [LoadingView class];
//    [UIView animateWithDuration:0.3 animations:^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.superView.alpha = 0.0;
//        strongSelf.frame = CGRectMake(strongSelf.frame.origin.x, kHeight, strongSelf.frame.size.width, strongSelf.frame.size.height);
//    } completion:^(BOOL finished) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf.superView removeFromSuperview];
//        strongSelf.superView = nil;
//    }];
//}



#pragma mark -Setter/Getter
- (UIView *)superView{
    if (!_superView){
        _superView = [[UIView alloc] init];
    }
    return _superView;
}


@end
