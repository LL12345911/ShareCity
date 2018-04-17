//
//  PayPopupView.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "PayPopupView.h"
#import "PayPasswordView.h"
#import "MarsDefines.h"
//#import "Masonry.h"

#define kZJAnimationTimeInterval 0.3
#define kZJSupeViewAlpha 0.3


@interface PayPopupView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *payPopupView;

@property (nonatomic, strong) UIButton *backView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic, strong) PayPasswordView *payPasswordView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation PayPopupView

#pragma mark -lifeCycle

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor] ;//UIColorFromHEX(0xffffff);
        [self createUI];
    }
    return self;
}



- (void)createUI{
    
//    self.userInteractionEnabled = YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    
    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];
    
    [self.superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.bottom.right.left.equalTo(window);
    }];
    
    _backView = [[UIButton alloc] initWithFrame:CGRectMake(20, (kHeight-200*scale_h)/2.0-100-KBottom, kWidth-40, 200*scale_h)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 20;
    _backView.layer.masksToBounds = YES;
//    _backView.userInteractionEnabled = YES;
    [self addSubview:self.backView];
    
    [_backView addSubview:self.titleLabel];
    _titleLabel.frame = CGRectMake(0, 0, kWidth-40, 50*scale_h);
    
    [_backView addSubview:self.okButton];
    self.okButton.frame = CGRectMake(0, 150*scale_h, kWidth-40, 50*scale_h);

    [_backView addSubview:self.payPasswordView];
    self.payPasswordView.frame = CGRectMake(20, 70*scale_h, kWidth-80, 50*scale_h);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePayPopView)];
    [self addGestureRecognizer:tap];

}

#pragma mark -Private

- (void)FinishPasswordAction{
    if ([self.delegate respondsToSelector:@selector(didClickFinishPasswordButton)]){
        [self.delegate didClickFinishPasswordButton];
    }
}

#pragma mark -Public

- (void)showPayPopView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kZJAnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    } completion:nil];
}

- (void)hidePayPopView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kZJAnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.alpha = 0.0;
        strongSelf.frame = CGRectMake(strongSelf.frame.origin.x, SCREEN_HEIGHT, strongSelf.frame.size.width, strongSelf.frame.size.height);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.superView removeFromSuperview];
        strongSelf.superView = nil;
    }];
}

- (void)didInputPayPasswordError{
    [self.payPasswordView didInputPasswordError];
}

#pragma mark -Setter/Getter

- (PayPasswordView *)payPasswordView{
    
    if (!_payPasswordView){
        
        _payPasswordView = [[PayPasswordView alloc] init];
        _payPasswordView.frame = CGRectMake(20, 70*scale_h, kWidth-80, 50*scale_h);
        __weak typeof(self) weakSelf = self;
        _payPasswordView.completionBlock = ^(NSString *password) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([strongSelf.delegate respondsToSelector:@selector(didPasswordInputFinished:)]){
                [strongSelf.delegate didPasswordInputFinished:password];
            }
        };
    }
    return _payPasswordView;
}

- (UIView *)superView
{
    if (!_superView){
        _superView = [[UIView alloc] init];
    }
    return _superView;
}

- (UIView *)payPopupView
{
    if (!_payPopupView){
        _payPopupView = [[UIView alloc] init];
        _payPopupView.backgroundColor = [UIColor clearColor];//UIColorFromHEX(0xFFFFFF);
    }
    return _payPopupView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = [UIFont systemFontOfSize:16*scale_h];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"输入交易密码";
    }
    return _titleLabel;
}

- (UIButton *)okButton
{
    if (!_okButton){
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okButton setTitle:@"确定" forState:0];
        _okButton.backgroundColor = kNavColor;
        [_okButton addTarget:self action:@selector(FinishPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}



@end
