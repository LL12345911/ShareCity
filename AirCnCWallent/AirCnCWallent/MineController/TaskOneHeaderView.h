//
//  TaskOneHeaderView.h
//  AirCnCWallent
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskOneHeaderView : UICollectionReusableView

@property (nonatomic,strong) UILabel * label;

- (void)setValueForTitle:(NSString *)title;


@end
