//
//  DigitalAssetsCell.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 协议(procotol) 声明
 */
@protocol DigitalAssetsDelegate <NSObject>

//  ***********  协议(DigitalAssetsDelegate) 定义方法（函数） ***********  //

//收发记录
- (void) clickRecodeButtonWith:(NSIndexPath *)indexPath;

//转出
- (void) clickRollOutButtonWith:(NSIndexPath *)indexPath;

//收款
- (void) clickCollectionScheduleButtonWith:(NSIndexPath *)indexPath;


@end


@interface DigitalAssetsCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, weak) id<DigitalAssetsDelegate> delegate;




@end






