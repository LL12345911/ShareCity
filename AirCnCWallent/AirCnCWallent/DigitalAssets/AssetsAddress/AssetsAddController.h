//
//  AssetsAddController.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BaseViewController.h"

/**
 协议(procotol) 声明
 */
@protocol AssetsAddressDeletage <NSObject>

//  ***********  数字资产 常用地址 协议(procotol) 定义方法（函数） ***********  //

- (void) clickOnAssetsAddressWithValue:(NSDictionary *)value;

@end



@interface AssetsAddController : BaseViewController

@property (nonatomic, weak) id<AssetsAddressDeletage> delegate;

@end
