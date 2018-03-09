//
//  TaskOneHeaderView.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "TaskOneHeaderView.h"

@interface TaskOneHeaderView()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
//@property (nonatomic, strong) UIButton *state;
@property (nonatomic, strong) UIView *lineBack;

//@property (nonatomic, strong) UIButton *cityBtn; /**<  */


@end

@implementation TaskOneHeaderView

- (void)setValueForTitle:(NSString *)title{
    _label.text = title;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width-20, 50*scale_h)];
//        self.label.font = [UIFont systemFontOfSize:15*scale_h];
//        self.label.textColor = [UIColor blackColor];
//        //self.label.textAlignment = NSTextAlignmentCenter;
//        //self.label.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
//        [self addSubview:self.label];
//
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50-1)];
//        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        [self addSubview:line];
        [self makeUI];
        
    }
    return self;
}

- (void)makeUI{
    
    
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150)];
//    _image.image = [UIImage imageNamed:@"资产"];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    _image.backgroundColor = [UIColor purpleColor];
    [self addSubview:_image];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kWidth, 50)];
    _label1.text = @"邀请5名好友";
    _label1.font = [UIFont boldSystemFontOfSize:25*scale_h];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [UIColor whiteColor];
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, kWidth-100, 30)];
    _label2.text = @"邀请5名好友";
    _label2.font = [UIFont boldSystemFontOfSize:15*scale_h];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.layer.cornerRadius = 15;
    _label2.layer.masksToBounds = YES;
    [self addSubview:_label2];
    
    _lineBack = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kWidth, 10)];
    _lineBack.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_lineBack];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, self.frame.size.width-20, 50)];
    self.label.font = [UIFont boldSystemFontOfSize:15*scale_h];
    self.label.textColor = [UIColor blackColor];
    //self.label.textAlignment = NSTextAlignmentCenter;
    //self.label.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self addSubview:self.label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 210-1, kWidth, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    
    
}

@end
