//
//  AreasController.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BaseViewController.h"

/**
 协议(procotol) 声明
 */
@protocol AreasForMobileDalagate <NSObject>

//  ***********  协议(procotol) 定义方法（函数） ***********  //
- (void) returnAreasForMobileInfoDic:(NSDictionary *)infoDic;

@end

@interface AreasController : BaseViewController

@property (nonatomic, weak) id<AreasForMobileDalagate> delegate;


@end
