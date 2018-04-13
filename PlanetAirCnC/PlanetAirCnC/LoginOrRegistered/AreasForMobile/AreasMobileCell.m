//
//  AreasMobileCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/13.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "AreasMobileCell.h"



@interface AreasMobileCell()

@property (nonatomic,strong) UILabel *account;   //
@property (nonatomic,strong) UILabel *code; //
@property (nonatomic,strong) UIView *line; //

@end

@implementation AreasMobileCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setValueByAreaMobileModel:(AreaMobileModel *)model
{
    _account.text = model.country_name;
    _code.text = [NSString stringWithFormat:@"+%@",model.country_code];
    
}


- (void)layoutReloadViewFrame{
    
    //
    _account = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWidth-100, 60*scale_h)];
    _account.font = [UIFont systemFontOfSize:15*scale_h];
    _account.textColor = kGrayColor;
    [self.contentView addSubview:_account];
    
    
    _code = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-20, 60*scale_h)];
    _code.font = [UIFont systemFontOfSize:15*scale_h];
    _code.textColor = kGrayColor;
        _code.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_code];

    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 60*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
   
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
