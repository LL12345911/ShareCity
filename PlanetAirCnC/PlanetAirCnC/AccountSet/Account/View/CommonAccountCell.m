//
//  CommonAccountCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "CommonAccountCell.h"


@interface CommonAccountCell()

@property (nonatomic,strong) UILabel *account;   //
@property (nonatomic,strong) UILabel *address; //
@property (nonatomic,strong) UIButton *modifBtn; //
@property (nonatomic,strong) UIView *line; //

@end

@implementation CommonAccountCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)modifyMethod{
    if ([self.delegate respondsToSelector:@selector(clickOnModifyBuutonAccountUsedWithIndexPath:)]) {
        [self.delegate clickOnModifyBuutonAccountUsedWithIndexPath:_indexPath];
    }
}

- (void)setValueByUsedAccountModel:(UsedAccountModel *)model{
    _account.text = model.walletname;
    _address.text = model.walletpath;

}


- (void)layoutReloadViewFrame{
    
//
    _account = [[UILabel alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-100, 30*scale_h)];
    _account.font = [UIFont systemFontOfSize:15*scale_h];
    _account.textColor = kGrayColor;
    [self.contentView addSubview:_account];
    
    
    _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 50*scale_h, kWidth-100, 20*scale_h)];
    _address.font = [UIFont systemFontOfSize:15*scale_h];
    _address.textColor = kGrayColor;
//    _account.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_address];
    
    
    _modifBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-50*scale_h-20, 65*scale_h/2.0, 50*scale_h, 25*scale_h)];
    _modifBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _modifBtn.layer.borderWidth = 1;
    _modifBtn.layer.cornerRadius = 25*scale_h/2.0;
    [_modifBtn setTitle:GetString(@"account29") forState:0];
    [_modifBtn setTitleColor:kGrayColor forState:0];
    _modifBtn.titleLabel.font = [UIFont systemFontOfSize:13*scale_h];
    [_modifBtn addTarget:self action:@selector(modifyMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_modifBtn];
    
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 90*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
        _account.text = @"HLC";
        _address.text = @"dfgggggggggg2.98877655";
}


- (NSMutableAttributedString *)setAttributedStr:(NSString *)str1 withStr2:(NSString *)str2{
    
    NSString *sss = [str2 stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,sss]];
    NSRange rangleft = NSMakeRange(0, str1.length);
    NSRange range2 = NSMakeRange(strAtt.length-sss.length, sss.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangleft];
    
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
