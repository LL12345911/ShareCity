//
//  AddAcountController.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BaseViewController.h"
#import "UsedAccountModel.h"

@interface AddAcountController : BaseViewController

@property (nonatomic, copy) NSString *accountType; //默认 是 添加账户  2 是修改账户

- (void)setValueUsedAccountModel:(UsedAccountModel *)model;

@end
