//
//  SelectCoinTypeController.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/12.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BaseViewController.h"

/**
 协议(procotol) 声明
 */
@protocol SelectCoinTypeDelegate <NSObject>

//  ***********  添加币种 协议(procotol) 定义方法（函数） ***********  //
- (void) selectCoinTypeWithValue:(NSDictionary *)value;

@end


@interface SelectCoinTypeController : BaseViewController

@property (nonatomic, weak) id<SelectCoinTypeDelegate> delegate;



@end
