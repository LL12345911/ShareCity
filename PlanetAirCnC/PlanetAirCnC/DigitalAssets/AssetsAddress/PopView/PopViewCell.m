//
//  PopViewCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "PopViewCell.h"

@interface PopViewCell()

@property (nonatomic,strong) UIImageView *coinImage; //
@property (nonatomic,strong) UILabel *coinName;   //
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *clickBtn;


@end

@implementation PopViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setValueByPopCoinTypeModel:(PopCoinTypeModel *)model{
    
    [_coinImage sd_setImageWithURL:[NSURL URLWithString:model.currencylogo] placeholderImage:[UIImage imageNamed:@"BtCoin"]];
    _coinName.attributedText = [self setAttributedStr:model.currencyname withStr2:model.currencyname_en];

}


- (void)layoutReloadViewFrame{
    
    //
    _coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(20*scale_h, 20*scale_h, 40*scale_h, 40*scale_h)];
    _coinImage.layer.cornerRadius = 15*scale_h;
    _coinImage.layer.masksToBounds = YES;
    _coinImage.image = [UIImage imageNamed:@"BtCoin"];
    [self.contentView addSubview:_coinImage];
    
    _coinName = [[UILabel alloc] initWithFrame:CGRectMake(70*scale_h, 0, kWidth-100, 80*scale_h)];
    _coinName.font = [UIFont systemFontOfSize:15*scale_h];
    _coinName.textColor = kGrayColor;
    _coinName.numberOfLines = 0;
    [self.contentView addSubview:_coinName];
    
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 80*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
    
    _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kWidth, 80*scale_h)];
    _clickBtn.backgroundColor = [UIColor clearColor];
    [_clickBtn addTarget:self action:@selector(clickcellMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_clickBtn];
    
    
    
    _coinName.attributedText = [self setAttributedStr:@"比特币" withStr2:@"BTC"];
    
}

- (void)clickcellMethod{
    if ([self.deletage respondsToSelector:@selector(clickPopViewCellWithValue:)]) {
        [self.deletage clickPopViewCellWithValue:_indexPath];
    }
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
