//
//  AccountCell.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "AccountCell.h"


@interface AccountCell()

@property (nonatomic,strong) UILabel *userName;   //
@property (nonatomic,strong) UILabel *account; //
@property (nonatomic,strong) UIImageView *accountImage; //
@property (nonatomic,strong) UIView *line; //

@end

@implementation AccountCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setImage:(NSString *)image Name:(NSString *)name detail:(AccountModel *)model isShow:(NSInteger)isShow{
    
    _accountImage.image = [UIImage imageNamed:image];
    _userName.text = name;
    
    if (isShow == 0 || isShow == 2) {
       _account.text = model.mobile;
    }
    
    if (isShow == 1) {
        if ([model.nickname isEqualToString:@"None"]) {
            _account.text = @"---";
            
        }else{
            _account.text = model.nickname;
        }
    }
    
    
    if (isShow== 1 || isShow== 3) {
        _account.frame = CGRectMake(0, 0, kWidth-30, 50*scale_h);
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        _account.frame = CGRectMake(0, 0, kWidth-15, 50*scale_h);
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (isShow == 4) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _account.text = app_Version;
        
    }
    
}




- (void)layoutReloadViewFrame{
    
    
    _accountImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10*scale_h, 30*scale_h, 30*scale_h)];
    _accountImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_accountImage];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(20+50*scale_h, 0, kWidth-100, 50*scale_h)];
    _userName.font = [UIFont systemFontOfSize:15*scale_h];
    [self.contentView addSubview:_userName];
    
    _account = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-15, 50*scale_h)];
    _account.font = [UIFont systemFontOfSize:15*scale_h];
    _account.textColor = kGrayColor;
    _account.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_account];
    
    
    
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 50*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
//    _userName.text = @"黄景瑜";
//////    _assets.text = @"2.98877655";
//    _account.attributedText = [self setAttributedStr:@"账户：" withStr2:@"18325717982"];
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
