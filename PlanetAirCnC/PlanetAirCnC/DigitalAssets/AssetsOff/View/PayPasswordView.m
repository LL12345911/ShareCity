//
//  PayPasswordView.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "PayPasswordView.h"
#import <objc/runtime.h>
#import "MarsDefines.h"

#define kZJPasswordBoxWidth XX_6(50)
#define kZJPasswordBoxSpace XX_6(8)
#define kZJPasswordBoxMargin XX_6(18)
#define kZJPasswordBoxNumber 6

@interface PayPasswordView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray <UILabel*> *labelBoxArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *currentText;

@property (nonatomic, assign) float width;


@end

@implementation PayPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        self.backgroundColor = [UIColor redColor];
        
        //self.frame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, XX_6(50));
        //self.frame = CGRectMake(frame.origin.x, frame.origin.y, kWidth-80, XX_6(50));
        
       
        
        [self addSubview:self.textField];
        [self.textField becomeFirstResponder];
        [self initData];
    }
    return self;
}

- (void)initData
{
     _width = (kWidth-80-5*10)/6;
//    DebugLog(@"%f",_width);
    self.currentText = @"";
    for (int i = 0; i < kZJPasswordBoxNumber; i ++)
    {
         UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * (10 + _width), 0, _width, 50*scale_h)];
        //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kZJPasswordBoxMargin + i * (kZJPasswordBoxWidth + kZJPasswordBoxSpace), 0, kZJPasswordBoxWidth, kZJPasswordBoxWidth)];
        label.textColor = UIColorFromHEX(0x444444);
        label.layer.borderWidth = 0.5f;
        label.layer.borderColor = UIColorFromHEX(0xCCCCCC).CGColor;
        label.layer.cornerRadius = XX_6(2);
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = Font_XX6(30);
        [self addSubview:label];
        
        [self.labelBoxArray addObject:label];
    }
}

- (void)startShakeViewAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shake.values = @[@0,@-10,@10,@-10,@0];
    shake.additive = YES;
    shake.duration = 0.25;
    [self.layer addAnimation:shake forKey:@"shake"];
}

- (void)textDidChanged:(UITextField *)textField
{
    if (textField.text.length > kZJPasswordBoxNumber)
    {
        textField.text = [textField.text substringToIndex:kZJPasswordBoxNumber];
    }
    
    [self updateLabelBoxWithText:textField.text];
    if (textField.text.length == kZJPasswordBoxNumber)
    {
        if (self.completionBlock)
        {
            self.completionBlock(self.textField.text);
        }
    }
}

#pragma mark - Public

- (void)updateLabelBoxWithText:(NSString *)text
{
    //输入时
    if (text.length > self.currentText.length) {
        for (int i = 0; i < kZJPasswordBoxNumber; i++)
        {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length - 1)
            {
                //特殊字符不居中显示，设置文本向下偏移
                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSBaselineOffsetAttributeName:@(-3)}];
                label.attributedText = att1;
            }
            else if (i == text.length - 1)
            {
                label.text = [text substringWithRange:NSMakeRange(i, 1)];
                [self animationShowTextInLabel: label];
            }
            else
            {
                label.text = @"";
            }
        }
    }
    //删除时
    else
    {
        for (int i = 0; i < kZJPasswordBoxNumber; i++)
        {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length)
            {
                //特殊字符不居中显示，设置文本向下偏移
                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSBaselineOffsetAttributeName:@(-3)}];
                label.attributedText = att1;
            }
            else
            {
                label.text = @"";
            }
        }
    }
    self.textField.text = text;
    self.currentText = text;
}

- (void)animationShowTextInLabel:(UILabel *)label
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //特殊字符不居中显示，设置文本向下偏移
        NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSBaselineOffsetAttributeName:@(-3)}];
        label.attributedText = att1;
    });
}

- (void)didInputPasswordError
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startShakeViewAnimation];
        self.textField.text = @"";
        [self updateAllLabelTextToNone];
    });
}

- (void)updateAllLabelTextToNone
{
    for (int i = 0; i < kZJPasswordBoxNumber; i++)
    {
        UILabel *label = self.labelBoxArray[i];
        label.text = @"";
    }
}

- (void)transformTextInTextField:(UITextField *)textField
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        textField.text = @"*";
    });
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark - Getter/Setter

- (NSMutableArray *)labelBoxArray
{
    if (!_labelBoxArray)
    {
        _labelBoxArray = [NSMutableArray array];
    }
    return _labelBoxArray;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }
    return _textField;
}

@end
