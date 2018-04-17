//
//  EnergyView.m
//  AirCnCWallent
//
//  Created by Mars on 2018/3/1.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "EnergyView.h"
#import "MarsButton.h"

@interface EnergyView()

@property (nonatomic, strong) NSMutableArray *frameArr;
@property (nonatomic, strong) NSMutableArray *frameRandom;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray *randomArr;


@end

@implementation EnergyView
//那么如何把frame装入nsarray呢
//[_array addObject:[NSValue valueWithCGRect:staticLabel.frame]];
//
//先转换成nsvalue 再用valuewithcgrect 搞定
//CGRect frame =  [_array[i] CGRectValue];

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat kwidth = frame.size.width;
        _height = frame.size.height;
        CGFloat width =  kwidth/10.0;
//        self.backgroundColor = [UIColor redColor];
        _frameArr = [NSMutableArray arrayWithCapacity:10];
        _frameRandom = [NSMutableArray arrayWithCapacity:10];
        _viewArr = [NSMutableArray arrayWithCapacity:10];
        _randomArr = @[@"-20",@"-19",@"-18",@"-17",@"-16",@"-15",@"-14",@"-13",@"-12",@"-11",@"-10",@"-9",@"-8",@"-7",@"-6",@"-5",@"-4",@"-3",@"-2",@"-1",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
        [self setViewFrame:width height:_height/8.0];
    }
    return self;
}

- (void)setViewFrameByRandom:(NSInteger)count{
    [_frameRandom removeAllObjects];
    for (UIButton *btn in _viewArr) {
        [btn removeFromSuperview];
    }
    [_viewArr removeAllObjects];
    
    
    while ([_frameRandom count] < count) {
        int r = arc4random() % 80;
        //去重 （数组）
        if (![_frameRandom containsObject:_frameArr[r]]) {
            [_frameRandom addObject:_frameArr[r]];
            NSLog(@" # %ld %@",_frameRandom.count,_frameArr[r]);
        }
    }
    
//    NSInteger num = 4;
    
    for (int i=0; i<count; i++) {
        MarsButton *button = [[MarsButton alloc] initWithFrame:[_frameRandom[i] CGRectValue]];
        button.frame = CGRectMake(0, 0, kWidth/5.0, kWidth/5.0);
        [button setTitle:@"0.112" forState:0];
//        button.titleLabel.font = [UIFont systemFontOfSize:9*scale_h];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setImage:[UIImage imageNamed:@"组28"] forState:0];
        button.tag = 100+i;
        [self addSubview:button];
//        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_viewArr addObject:button];
//        NSLog(@"%@",_frameRandom[i]);
        
        CGRect rect = [_frameRandom[i] CGRectValue];
        
        button.center = CGPointMake(rect.origin.x+ [_randomArr[(arc4random()%40)] intValue]*2, rect.origin.y+[_randomArr[(arc4random()%40)] intValue]*2);
        
        
        
        CGFloat xx = button.center.x;
        CGFloat yy = button.center.y;
        if (button.center.x< kWidth/10.0) {
            xx = kWidth/10.0;
            button.center = CGPointMake(xx, yy);
        }
        if (button.center.x > kWidth - kWidth/10.0) {
            xx = kWidth - kWidth/10.0;
            button.center = CGPointMake(xx, yy);
        }
        if (button.center.y < kWidth/10.0) {
            yy = kWidth/10.0;
            button.center = CGPointMake(xx, yy);
        }
        if (button.center.y > _height-kWidth/10.0) {
            yy = _height-kWidth/10.0;
            button.center = CGPointMake(xx, yy);
        }
        
        //让足球来回转动
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        //kCAMediaTimingFunctionLinear 表示时间方法为线性，使得足球匀速转动
        rotation.fromValue = [NSNumber numberWithFloat:-5];
        rotation.toValue = [NSNumber numberWithFloat:5];
        rotation.duration = arc4random()%3 + 0.5  ;//执行时间
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        rotation.autoreverses = YES; //是否重复
        rotation.repeatCount = HUGE_VALF;//次数
        rotation.removedOnCompletion = NO;
        [button.layer addAnimation:rotation forKey:@"shakeAnimation2"];
    }
    
}


- (void)buttonClick:(UIButton *)button{
    NSInteger tag = button.tag-100;
    if (self.energyBlock) {
        self.energyBlock(tag);
    }
    if ([self.delegate respondsToSelector:@selector(energyViewClickButton:)]) {
        [self.delegate energyViewClickButton:tag];
    }
    
}


//分配20个视图的 frame 并存入 数组
- (void)setViewFrame:(CGFloat)width height:(CGFloat)height{
    
    for (int i=0; i<80; i++) {
        int x = (i % 10);
        int y = (i / 10);
        [_frameArr addObject:[NSValue valueWithCGRect:CGRectMake(x*width, y*height, width, height)]];
        
//        NSLog(@" x=%f   y=%f   w=%f  h=%f   %d  %d  %d",x*width,y*height,width,height,x,y,i);
        //        [_frameArr addObject:[NSValue valueWithCGRect:CGRectMake(x*width+10, y*height+10*scale_h, width, height)]];
    }
    
}
@end
