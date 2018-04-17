//
//  MarsSearchBar.m
//  RentalCar
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//


#import "MarsSearchBar.h"

@implementation MarsSearchBar
//设置输入框光标颜色
- (void)setCursorColor:(UIColor *)cursorColor
{
    if (cursorColor) {
        _cursorColor = cursorColor;
        //获取输入框
        UITextField *searchField = self.searchBarTextField;
        if (searchField) {
            //光标颜色
            [searchField setTintColor:cursorColor];
        }
    }
}

//获取输入框
- (UITextField *)searchBarTextField
{
    //获取输入框
    _searchBarTextField = [self valueForKey:@"searchField"];
    return _searchBarTextField;
}

//设置清除按钮图标
- (void)setClearButtonImage:(UIImage *)clearButtonImage
{
    if (clearButtonImage) {
        _clearButtonImage = clearButtonImage;
        //获取输入框
        UITextField *searchField = self.searchBarTextField;
        if (searchField) {
            //设置清除按钮图片
            UIButton *button = [searchField valueForKey:@"_clearButton"];
            [button setImage:clearButtonImage forState:UIControlStateNormal];
            searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
}

- (void)setHideSearchBarBackgroundImage:(BOOL)hideSearchBarBackgroundImage {
    if (hideSearchBarBackgroundImage) {
        _hideSearchBarBackgroundImage = hideSearchBarBackgroundImage;
        self.backgroundImage = [[UIImage alloc] init];
    }
}

//获取取消按钮
- (UIButton *)cancleButton
{
    self.showsCancelButton = YES;
    for (UIView *view in [[self.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            _cancleButton = (UIButton *)view;
        }
    }
    return _cancleButton;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    UITextField *textField = [self valueForKey:@"searchBarTextField"];
    if (textField) {
        textField.frame = _rect;// CGRectMake(20, 10*scale_h, kWidth-40, 50*scale_h);
    }
//    if (textField) {
//        textField.frame = CGRectMake(20, 10*scale_h, kWidth-40, 50*scale_h);
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
