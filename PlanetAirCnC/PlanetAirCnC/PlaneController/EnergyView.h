//
//  EnergyView.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/3/1.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
  协议(procotol) 声明
  */
@protocol EnergyViewDelegate <NSObject>

//  ***********  协议(procotol) 定义方法（函数） ***********  //
- (void)energyViewClickButton:(NSInteger)tag;

@end

typedef void(^EnergyViewChargeBlock)(NSInteger tag);


@interface EnergyView : UIView

@property (nonatomic, copy) EnergyViewChargeBlock energyBlock;

@property (nonatomic, weak) id<EnergyViewDelegate> delegate;

//保存控件的数组
@property (nonatomic, strong) NSMutableArray *viewArr;




- (void)setViewFrameByRandom:(NSInteger)count;



@end
