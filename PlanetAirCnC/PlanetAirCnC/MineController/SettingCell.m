//
//  SettingCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/27.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell()

@property (nonatomic,strong) UIView *back;

@property (nonatomic,strong) UILabel *userName; //
@property (nonatomic,strong) UILabel *normal;   //

@property (nonatomic,strong) UIImageView *imageview;     //
@property (nonatomic,strong) UIView *line;


@end


@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setValueModel:(NSString *)model rightClickValue:(NSString *)value indexPathRow:(NSInteger)row{
    
    if (row == 5) {
        _normal.frame = CGRectMake(20, 0, kWidth-40-20, 50*scale_h);
        _imageview.frame = CGRectMake(kWidth-20-20, 0, 20, 50*scale_h);
        
       
    }else{
        _normal.frame = CGRectMake(20, 0, kWidth-40, 50*scale_h);
        _imageview.frame = CGRectMake(kWidth-20-20, 0, 0, 50*scale_h);
        _imageview.image = [UIImage new];
    }
   _userName.text = model;
    _normal.text = value;
}



- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(0, 0*scale_h, kWidth, 50*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_back];
    
  
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50*scale_h)];
    _userName.text = @"XXXXXX";
    _userName.textColor = kBlackColor;
    _userName.font = [UIFont boldSystemFontOfSize:15*scale_h];
    [_back addSubview:_userName];
    
    _normal = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWidth-40-20, 50*scale_h)];
    _normal.text = @"53.777";
    _normal.textColor = kGrayColor;
    _normal.font = [UIFont systemFontOfSize:15*scale_h];
    _normal.textAlignment = NSTextAlignmentRight;
    [_back addSubview:_normal];
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-20-20, 0, 20, 50*scale_h)];
    _imageview.image = [UIImage imageNamed:@"右箭头"];
    _imageview.contentMode = UIViewContentModeScaleAspectFit;
    [_back addSubview:_imageview];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(20, 50*scale_h-1, kWidth-20, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_back addSubview:_line];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
