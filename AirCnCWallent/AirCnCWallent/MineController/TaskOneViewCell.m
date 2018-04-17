//
//  TaskOneViewCell.m
//  AirCnCWallent
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "TaskOneViewCell.h"


@interface TaskOneViewCell()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *state;


@property (nonatomic, strong) UIButton *cityBtn; /**<  */


@end

@implementation TaskOneViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
       // [self.contentView addSubview:self.cityBtn];
        
//        [_cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView.mas_top).offset(0*scale_h);
//            make.left.mas_equalTo(self.contentView.mas_left).offset(0*scale_h);
//            make.right.mas_equalTo(self.contentView.mas_right).offset(0*scale_h);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0*scale_h);
//        }];
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
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, (kWidth-15)/3-1, 20)];
    _label2.text = @"邀请5名好友";
    _label2.font = [UIFont systemFontOfSize:14*scale_h];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.textColor = kGrayColor;
    [self.contentView addSubview:_label2];
    
    
    _state = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, (kWidth-15)/3-1, 20)];//CGRectMake(00, 50*scale_h, kWidth-40, 30*scale_h)
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




#pragma mark *** Getters ***
- (UIButton *)cityBtn {
    if (!_cityBtn) {
        _cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(00, 85*scale_h, kWidth-40, 30*scale_h)];//CGRectMake(00, 50*scale_h, kWidth-40, 30*scale_h)
        [_cityBtn setTitle:@"查看详情" forState:0];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:0];
        [_cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _cityBtn.layer.cornerRadius = 2;
        _cityBtn.titleLabel.numberOfLines = 0;
        _cityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cityBtn.selected = NO;
        [_cityBtn setBackgroundImage:[UIImage imageNamed:@"分享未选中"] forState:0];
        [_cityBtn setBackgroundImage:[UIImage imageNamed:@"分享选中2"] forState:UIControlStateSelected];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
        [_cityBtn addTarget:self action:@selector(selectcar) forControlEvents:UIControlEventTouchUpInside];

    }
    return _cityBtn;
}

@end
