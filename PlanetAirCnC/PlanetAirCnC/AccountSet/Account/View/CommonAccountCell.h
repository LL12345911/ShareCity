//
//  CommonAccountCell.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsedAccountModel.h"

/**
 协议(procotol) 声明
 */
@protocol AccountUsedDelegate <NSObject>

//  ***********  协议(procotol) 定义方法（函数） ***********  //
- (void) clickOnModifyBuutonAccountUsedWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface CommonAccountCell : UITableViewCell

@property (nonatomic, weak) id<AccountUsedDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)setValueByUsedAccountModel:(UsedAccountModel *)model;

@end
