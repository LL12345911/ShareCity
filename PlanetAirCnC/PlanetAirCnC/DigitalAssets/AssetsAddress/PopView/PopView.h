//
//  PopView.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 协议(procotol) 声明
 */
@protocol PopViewDelegate <NSObject>

//  ***********  协议(procotol) 定义方法（函数） ***********  //
- (void) selectCoinTypeWithValue:(NSDictionary *)dic;

@end

@interface PopView : UIView

@property (nonatomic, weak) id<PopViewDelegate> delegate;


- (void)showPayPopView:(NSArray *)arr;
- (void)hidePayPopView;

@end
