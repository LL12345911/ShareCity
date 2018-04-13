//
//  PopViewCell.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopCoinTypeModel.h"

/**
 协议(procotol) 声明
 */
@protocol PopViewCellDeletage <NSObject>

//  ***********  协议(procotol) 定义方法（函数） ***********  //
- (void) clickPopViewCellWithValue:(NSIndexPath *)indexPath;

@end

@interface PopViewCell : UITableViewCell

@property (nonatomic, weak) id<PopViewCellDeletage> deletage;

@property (nonatomic, strong) NSIndexPath *indexPath;


- (void)setValueByPopCoinTypeModel:(PopCoinTypeModel *)model;

@end
