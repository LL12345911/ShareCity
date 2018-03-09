//
//  TaaskTwoHeaderView.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "TaaskTwoHeaderView.h"

@implementation TaaskTwoHeaderView

- (void)setValueForTitle:(NSString *)title{
    _label.text = title;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width-20, 50)];
        self.label.font = [UIFont boldSystemFontOfSize:15*scale_h];
        self.label.textColor = [UIColor blackColor];
        //self.label.textAlignment = NSTextAlignmentCenter;
        //self.label.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        [self addSubview:self.label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50-1, kWidth, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
         [self addSubview:line];
    }
    return self;
}

@end
