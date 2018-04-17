//
//  SelectCoinTypeCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/12.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "SelectCoinTypeCell.h"


@interface SelectCoinTypeCell()

@property (nonatomic, strong) UIView *back;
@property (nonatomic,strong) UIImageView *coinImage; //
//@property (nonatomic,strong) UIImageView *coinImage2; //是否添加
@property (nonatomic,strong) UILabel *coinName;   //
//@property (nonatomic,strong) UILabel *coinDesc; //


@end

@implementation SelectCoinTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setValueByCoinTypeModel:(SelectCoinTypeModel *)model{
    
    [_coinImage sd_setImageWithURL:[NSURL URLWithString:model.currencylogo] placeholderImage:[UIImage imageNamed:@"BtCoin"]];
    _coinName.attributedText = [self setAttributedStr:model.currencyname withStr2:model.currencyname_en];

}


- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(20, 15*scale_h, kWidth-40, 80*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.shadowColor = [UIColor blackColor].CGColor;
    _back.layer.shadowOpacity = 0.8f;
    _back.layer.shadowRadius = 4.f;
    _back.layer.shadowOffset = CGSizeMake(0,0);
    [self.contentView addSubview:_back];
    
    
    //
    _coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(20*scale_h, 20*scale_h, 40*scale_h, 40*scale_h)];
    _coinImage.layer.cornerRadius = 15*scale_h;
    _coinImage.layer.masksToBounds = YES;
    _coinImage.image = [UIImage imageNamed:@"BtCoin"];
    [_back addSubview:_coinImage];
    
    _coinName = [[UILabel alloc] initWithFrame:CGRectMake(70*scale_h, 0, kWidth-100, 80*scale_h)];
    _coinName.font = [UIFont systemFontOfSize:15*scale_h];
    _coinName.textColor = kGrayColor;
    _coinName.numberOfLines = 0;
    [_back addSubview:_coinName];
    
//    _coinImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-40-50*scale_h, 25*scale_h, 30*scale_h, 30*scale_h)];
//    _coinImage2.image = [UIImage imageNamed:@"对号"];
//    _coinImage2.contentMode = UIViewContentModeScaleAspectFit;
//    [_back addSubview:_coinImage2];
    
    
    _coinName.attributedText = [self setAttributedStr:@"比特币" withStr2:@"BTC"];
    
}


- (NSMutableAttributedString *)setAttributedStr:(NSString *)str1 withStr2:(NSString *)str2{
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    NSRange rangleft = NSMakeRange(0, str1.length);
    NSRange range2 = NSMakeRange(strAtt.length-str2.length, str2.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kBlackColor  range:rangleft];
    
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
