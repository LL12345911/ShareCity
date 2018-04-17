//
//  AccountCell.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface AccountCell : UITableViewCell

- (void)setImage:(NSString *)image Name:(NSString *)name detail:(AccountModel *)model isShow:(NSInteger)isShow;

@end
