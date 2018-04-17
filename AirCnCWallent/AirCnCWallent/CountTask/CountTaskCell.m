//
//  CountTaskCell.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "CountTaskCell.h"



@interface CountTaskCell()

@property (nonatomic, strong) UIView *back;
@property (nonatomic,strong) UIImageView *coinImage; //
@property (nonatomic,strong) UILabel *coinName;   //

@property (nonatomic,strong) UIButton *finishBtn;   //


@property (nonatomic,strong) UILabel *coinNum;   //

//@property (nonatomic, strong) UIView *line;

//@property (nonatomic,strong) UILabel *coinDesc; //


@end

@implementation CountTaskCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setValueByIndexPath:(NSIndexPath *)indexpath{
    

    
    if (indexpath.row == 0) {
        _coinImage.image = [UIImage imageNamed:@"邀请好友"];
        _coinName.attributedText = [self setAttributed:GetString(@"task05") pow:@"10" desc:@"邀请无名好友" other:@""];

    }else if (indexpath.row == 1) {
        _coinImage.image = [UIImage imageNamed:@"每日登陆"];
        _coinName.attributedText = [self setAttributed:GetString(@"task06") pow:@"1" desc:@"每日登录" other:@""];
        
    }else if (indexpath.row == 2) {
        _coinImage.image = [UIImage imageNamed:@"交易密码"];
        _coinName.attributedText = [self setAttributed:GetString(@"task07") pow:@"1" desc:@"设置交易密码" other:@""];
        
        
    }else if (indexpath.row == 3) {
        _coinImage.image = [UIImage imageNamed:@"邮箱绑定"];
        _coinName.attributedText = [self setAttributed:GetString(@"task08") pow:@"1" desc:@"绑定邮箱" other:@""];
        
        
    }
    
}

- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(20, 1*scale_h, kWidth-40, 80*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.shadowColor = [UIColor blackColor].CGColor;
    _back.layer.shadowOpacity = 0.8f;
    _back.layer.shadowRadius = 1.f;
    _back.layer.shadowOffset = CGSizeMake(0,0);
    [self.contentView addSubview:_back];
    
    
    
    //
    _coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(10*scale_h, 15*scale_h, 50*scale_h, 50*scale_h)];
    _coinImage.layer.cornerRadius = 15*scale_h;
    _coinImage.layer.masksToBounds = YES;
    _coinImage.image = [UIImage imageNamed:@"组3"];
    [_back addSubview:_coinImage];
    
    _coinName = [[UILabel alloc] initWithFrame:CGRectMake(70*scale_h, 0, kWidth-70*scale_h, 80*scale_h)];
    _coinName.numberOfLines = 0;
    [_back addSubview:_coinName];
    
    
   
    
    
    _finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-70*scale_h-20, 55*scale_h/2.0, 60*scale_h, 25*scale_h)];
    //_finishBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    //_finishBtn.layer.borderWidth = 1;
    _finishBtn.layer.cornerRadius = 3;
    [_finishBtn setTitle:GetString(@"task10") forState:0];
    //[_finishBtn setTitleColor:kGrayColor forState:0];
    _finishBtn.titleLabel.font = [UIFont systemFontOfSize:13*scale_h];
    _finishBtn.backgroundColor = kGrayColor;
    [_finishBtn addTarget:self action:@selector(modifyMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_finishBtn];
    
    
    
//    "task05" = "每邀请1位";
//    "task06" = "每日登录";
//    "task07" = "交易密码";
//    "task08" = "邮箱绑定";
//    "task09" = "算力";
//    "task10" = "未完成";
//    "task11" = "已完成";

    
    
//    _coinName.attributedText = [self setAttributed:@"挖矿" coinType:@"比特币" time:@"2018-09-10 12:12"];
//    _coinNum.text = @"+0.99887772";
    
}


- (NSMutableAttributedString *)setAttributed:(NSString *)type pow:(NSString *)pow desc:(NSString *)desc other:(NSString *)other{
    

    pow = [NSString stringWithFormat:@"+%@%@",pow,GetString(@"task12")];
    NSString *str = GetString(@"task09");
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@\n%@%@",type,pow,str,desc,other]];
    
    NSRange rangle1 = NSMakeRange(0, type.length);
    NSRange rangle2 = NSMakeRange(type.length, pow.length);
    NSRange rangle3 = NSMakeRange(type.length+pow.length, str.length);
    NSRange rangle4 = NSMakeRange(strAtt.length-desc.length-other.length, desc.length+other.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17*scale_h] range:rangle1];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kBlackColor  range:rangle1];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17*scale_h] range:rangle2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:rangle2];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17*scale_h] range:rangle3];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kBlackColor  range:rangle3];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangle4];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangle4];
    
    return strAtt;
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
