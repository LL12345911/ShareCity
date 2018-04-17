//
//  BillingRecordsCell.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "BillingRecordsCell.h"


@interface BillingRecordsCell()

@property (nonatomic,strong) UIImageView *coinImage; //是否添加
@property (nonatomic,strong) UILabel *coinName;   //
@property (nonatomic,strong) UILabel *coinNum;   //
@property (nonatomic, strong) UIView *line;

@end

@implementation BillingRecordsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}


- (void)layoutReloadViewFrame{
    //
    _coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(20*scale_h, 15*scale_h, 50*scale_h, 50*scale_h)];
    _coinImage.layer.cornerRadius = 15*scale_h;
    _coinImage.layer.masksToBounds = YES;
    _coinImage.image = [UIImage imageNamed:@"组3"];
    [self.contentView addSubview:_coinImage];
    
    _coinName = [[UILabel alloc] initWithFrame:CGRectMake(80*scale_h, 0, kWidth-70*scale_h, 80*scale_h)];
    _coinName.numberOfLines = 0;
    [self.contentView addSubview:_coinName];
    
    _coinNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-20*scale_h, 80*scale_h)];
    _coinNum.numberOfLines = 0;
    _coinNum.textColor = kOrangeRed;
    _coinNum.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_coinNum];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 80*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
    _coinName.attributedText = [self setAttributed:@"挖矿" coinType:@"比特币" time:@"2018-09-10 12:12"];
    _coinNum.text = @"+0.99887772";
}


- (NSMutableAttributedString *)setAttributed:(NSString *)type coinType:(NSString *)coinType time:(NSString *)time{
    
    coinType = [NSString stringWithFormat:@"  (%@)",coinType];
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@\n%@",type,coinType,time]];
    NSRange rangle1 = NSMakeRange(0, type.length);
    NSRange rangle2 = NSMakeRange(type.length, coinType.length);
    NSRange rangle3 = NSMakeRange(strAtt.length-time.length, time.length);
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17*scale_h] range:rangle1];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kBlackColor  range:rangle1];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangle2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle2];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangle3];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle3];
    
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
