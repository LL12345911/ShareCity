//
//  MyIncomeCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "MyIncomeCell.h"



@interface MyIncomeCell()

@property (nonatomic, strong) UIView *back;
@property (nonatomic,strong) UIImageView *coinImage; //是否添加
@property (nonatomic,strong) UIImageView *rightImage; //
@property (nonatomic,strong) UILabel *coinName;   //
//@property (nonatomic,strong) UILabel *coinDesc; //


@end

@implementation MyIncomeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}


- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 100*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.shadowColor = [UIColor blackColor].CGColor;
    _back.layer.shadowOpacity = 0.8f;
    _back.layer.shadowRadius = 4.f;
    _back.layer.shadowOffset = CGSizeMake(0,0);
    [self.contentView addSubview:_back];
    
    
    //
    _coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(20*scale_h, 20*scale_h, 60*scale_h, 60*scale_h)];
    _coinImage.layer.cornerRadius = 15*scale_h;
    _coinImage.layer.masksToBounds = YES;
    _coinImage.image = [UIImage imageNamed:@"组2"];
    [_back addSubview:_coinImage];
    
    _coinName = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*scale_h, kWidth-40-20*scale_h, 60*scale_h)];
    _coinName.numberOfLines = 0;
    _coinName.textAlignment = NSTextAlignmentRight;
    [_back addSubview:_coinName];
    
    _rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-40-50*scale_h, 10*scale_h, 30*scale_h, 15*scale_h)];
    _rightImage.image = [UIImage imageNamed:@"箭头-右"];
    _rightImage.contentMode = UIViewContentModeRight;
    [_back addSubview:_rightImage];
    
    
    _coinName.attributedText = [self setAttributedStr:@"37.9876909" withStr2:@"纷享钻数量"];
    
}


- (NSMutableAttributedString *)setAttributedStr:(NSString *)str1 withStr2:(NSString *)str2{
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    NSRange rangleft = NSMakeRange(0, str1.length);
    NSRange range2 = NSMakeRange(strAtt.length-str2.length, str2.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:range2];
    
    return strAtt;
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
