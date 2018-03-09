//
//  EnergyView.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/3/1.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EnergyViewChargeBlock)(NSString *energy);

@interface EnergyView : UIView

@property (nonatomic, copy) EnergyViewChargeBlock energyBlock;


- (void)initWithEnergyViewByEnergy:(NSString *)energy;

@end
