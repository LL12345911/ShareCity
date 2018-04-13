//
//  RecordViewCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "RecordViewCell.h"


@interface RecordViewCell()

@property (nonatomic,strong) UIImageView *typeImage;   //

@property (nonatomic,strong) UILabel *typeName;   //
@property (nonatomic,strong) UILabel *timeL; //
@property (nonatomic,strong) UILabel *assets;//
@property (nonatomic,strong) UIView *line;//


@end

@implementation RecordViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}



- (void)layoutReloadViewFrame{
    
    
    _typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20*scale_h, 50*scale_h, 50*scale_h)];
    _typeImage.backgroundColor = [UIColor redColor];
    _typeImage.layer.cornerRadius = 25*scale_h;
    _typeImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_typeImage];
    
    
    _typeName = [[UILabel alloc] initWithFrame:CGRectMake(15+60*scale_h, 20*scale_h, kWidth-120, 30*scale_h)];
    _typeName.font = [UIFont systemFontOfSize:17*scale_h];
    _typeName.textColor = kBlackColor;
    [self.contentView addSubview:_typeName];
    
   
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(15+60*scale_h, 50*scale_h, kWidth-120, 20*scale_h)];
    _timeL.font = [UIFont systemFontOfSize:13*scale_h];
    _timeL.textColor = kGrayColor;
    [self.contentView addSubview:_timeL];
    
    
    _assets = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-20, 90*scale_h)];
    _assets.font = [UIFont systemFontOfSize:17*scale_h];
    _assets.textColor = kOrangeRed;
    _assets.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_assets];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 90*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
    
//    "digital04" = "转出";
//    "digital05" = "收款";
    
    _typeName.text = @"收款";
    _timeL.text = @"2018-09-21 12:09:23";
    _assets.text = @"+2.009987766";
   
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
