//
//  TaskTwoViewCell.m
//  AirCnCWallent
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "TaskTwoViewCell.h"


@interface TaskTwoViewCell()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *state;


@property (nonatomic, strong) UIButton *cityBtn; /**<  */


@end

@implementation TaskTwoViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
      
        [self setCellView];
        
    }
    return self;
}

- (void)setCellView{
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, (kWidth-15)/3-1, 40)];
    _image.image = [UIImage imageNamed:@"资产"];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_image];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, (kWidth-15)/3-1, 20)];
    _label1.text = @"邀请5名好友";
    _label1.font = [UIFont boldSystemFontOfSize:15*scale_h];
    _label1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label1];
    
    
    _state = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, (kWidth-15)/3-1, 20)];//CGRectMake(00, 50*scale_h, kWidth-40, 30*scale_h)
    [_state setTitle:@"查看详情" forState:0];
    [_state setTitleColor:[UIColor blackColor] forState:0];
    _state.layer.cornerRadius = 2;
    _state.titleLabel.numberOfLines = 0;
    _state.titleLabel.textAlignment = NSTextAlignmentCenter;
    _state.selected = NO;
    _state.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [self.contentView addSubview:_state];
    
    
}

- (void)selectcar{
    // NSLog(@"111");
    //    if ([self.deletage respondsToSelector:@selector(airportShareCarAddressCityCellSelectRow:)]) {
    //        [self.deletage airportShareCarAddressCityCellSelectRow:_row];
    //    }
}

//
//- (void)setValueByAirportShareCarAddressAllModel:(AirportShareCarAddressAllModel *)model selectKey:(NSString *)key{
//    [_cityBtn setTitle:[NSString stringWithFormat:@"%@\n%@",model.city_name,model.city_spell] forState:0];
//
//    if ([key isEqualToString:@"1"]) {
//        _cityBtn.selected = YES;
//    }else{
//        _cityBtn.selected = NO;
//    }
//}

@end
