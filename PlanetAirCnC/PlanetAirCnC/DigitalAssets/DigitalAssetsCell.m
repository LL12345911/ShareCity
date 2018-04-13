//
//  DigitalAssetsCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "DigitalAssetsCell.h"
#import "HyperlinksButton.h"
#import "UIImage+QRcode.h"
#import <objc/message.h>

@interface DigitalAssetsCell()

@property (nonatomic,strong) UIView *back;

@property (nonatomic,strong) UILabel *coinNum;   //
@property (nonatomic,strong) UILabel *assetsAdd; //
@property (nonatomic,strong) UIButton *recordBtn;//收发记录
@property (nonatomic,strong) HyperlinksButton *textBtn;
@property (nonatomic,strong) UIButton *rollOutBtn; //转出
@property (nonatomic,strong) UIButton *collecteBtn; //收款
@property (nonatomic,strong) UIImageView *qrCode;   //


@end

@implementation DigitalAssetsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

//- (void)setValueModel:(NSString *)model indexPathRow:(NSInteger)row{
//
//    if (row == 0) {
//        [_ranking setTitle:@"" forState:0];
//        [_ranking setImage:[UIImage imageNamed:@"金牌"] forState:0];
//    }else if (row == 1) {
//        [_ranking setTitle:@"" forState:0];
//        [_ranking setImage:[UIImage imageNamed:@"银牌"] forState:0];
//    }else if (row == 2) {
//        [_ranking setTitle:@"" forState:0];
//        [_ranking setImage:[UIImage imageNamed:@"铜牌"] forState:0];
//    }else{
//        [_ranking setTitle:[NSString stringWithFormat:@"%ld",row] forState:0];
//        [_ranking setImage:[UIImage new] forState:0];
//    }
//
//}


///** 动态添加方法 */
//- (void)startWithTag:(NSInteger)tag
//{
//    NSString *metherName = @"qrCodeMethod";
//    SEL normalSelector = NSSelectorFromString(metherName);
//    if ([self respondsToSelector:normalSelector]) {
//        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
//    }
//}

#pragma mark - 生成二维码
-(void)qrCodeMethod:(NSString *)qrCode{
    //    [UIImage CreateQrcodeWithTitle:@"https://www.jianshu.com/p/ef738baf8e33" size:100*scale_h completion:^(UIImage *image) {
    //        _qrCodeView.image = image;
    //    }];
    
    //[CIColor colorWithRed:61/255.0 green:21/255.0 blue:92/255.0 alpha:1]
    [UIImage CreateQrcodeWithTitle:qrCode size:70*scale_h withColor:[CIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] completion:^(UIImage *image) {
        _qrCode.image = image;
    }];
    
}


#pragma mark - 复制邀请码到 剪切板
- (void)copyMethodForButton{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:_assetsAdd.text];
    
    [HUDTools showDetailText:@"已复制" withView:self.contentView withDelay:2];
    
}

- (void)recodeMethod{
    if ([self.delegate respondsToSelector:@selector(clickRecodeButtonWith:)]) {
        [self.delegate clickRecodeButtonWith:_indexPath];
    }
}

- (void)rollOutMethod{
    if ([self.delegate respondsToSelector:@selector(clickRollOutButtonWith:)]) {
        [self.delegate clickRollOutButtonWith:_indexPath];
    }
}


- (void)collectionMethod{
    if ([self.delegate respondsToSelector:@selector(clickCollectionScheduleButtonWith:)]) {
        [self.delegate clickCollectionScheduleButtonWith:_indexPath];
    }
}



- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 200*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.cornerRadius = 5;
    _back.layer.masksToBounds = YES;
    _back.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _back.layer.borderWidth = 1;
    [self.contentView addSubview:_back];
  
    _coinNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 10*scale_h, kWidth-80, 60*scale_h)];
    _coinNum.font = [UIFont systemFontOfSize:15*scale_h];
    _coinNum.numberOfLines = 0;
    [_back addSubview:_coinNum];
    
    _assetsAdd = [[UILabel alloc] initWithFrame:CGRectMake(20, 80*scale_h, kWidth-80, 20*scale_h)];
    _assetsAdd.text = @"sssssshfsjhuuujjjjjgghjjjjhhh";
    _assetsAdd.textColor = kGrayColor;
    _assetsAdd.font = [UIFont systemFontOfSize:15*scale_h];
    [_back addSubview:_assetsAdd];
    
    

    
    _textBtn = [[HyperlinksButton alloc] initWithFrame:CGRectMake(20, 100*scale_h, 150, 30*scale_h)];
    [_textBtn setTitle:GetString(@"digital03") forState:0];
    [_textBtn setTitleColor:kBlackColor forState:0];
    _textBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    _textBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_textBtn addTarget:self action:@selector(copyMethodForButton) forControlEvents:UIControlEventTouchUpInside];
    [_back addSubview:_textBtn];

    _recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-10-25*150.0/53.0*scale_h, 30*scale_h, 25*150.0/53.0*scale_h, 25*scale_h)];
//    [_recordBtn setTitle:@"收发记录" forState:0];
//    _recordBtn.backgroundColor = kNavColor;
    [_recordBtn setBackgroundImage:[UIImage imageNamed:@"组13"] forState:0];
    _recordBtn.titleLabel.font = [UIFont systemFontOfSize:14*scale_h];
    [_recordBtn addTarget:self action:@selector(recodeMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_recordBtn];
    
    _rollOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 150*scale_h, (kWidth-40-60)/2, 30*scale_h)];
    [_rollOutBtn setTitle:GetString(@"digital04") forState:0];
    _rollOutBtn.backgroundColor = kNavColor;
    _rollOutBtn.layer.cornerRadius = 15*scale_h;
    _rollOutBtn.titleLabel.font = [UIFont systemFontOfSize:16*scale_h];
    [_rollOutBtn addTarget:self action:@selector(rollOutMethod) forControlEvents:UIControlEventTouchUpInside];
    [_back addSubview:_rollOutBtn];
    
    _collecteBtn = [[UIButton alloc] initWithFrame:CGRectMake(40+(kWidth-40-60)/2, 150*scale_h, (kWidth-40-60)/2, 30*scale_h)];
    [_collecteBtn setTitle:GetString(@"digital05") forState:0];
    _collecteBtn.backgroundColor = kNavColor;
    _collecteBtn.layer.cornerRadius = 15*scale_h;
    _collecteBtn.titleLabel.font = [UIFont systemFontOfSize:16*scale_h];
    [_collecteBtn addTarget:self action:@selector(collectionMethod) forControlEvents:UIControlEventTouchUpInside];
    [_back addSubview:_collecteBtn];
    
    
    _qrCode = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-60-60*scale_h, 70*scale_h, 60*scale_h, 60*scale_h)];
    //_qrCode.backgroundColor = [UIColor redColor];
    _qrCode.image = [UIImage imageNamed:@"Btlogo"];
    _qrCode.layer.cornerRadius = 30*scale_h;
    _qrCode.layer.masksToBounds = YES;
    [_back addSubview:_qrCode];
    
    _coinNum.attributedText = [self setAttributedStr:@"分享砖" withStr2:@"23.000099888"];
//    [self qrCodeMethod:@"https://www.jianshu.com/p/ef738baf8e33"];
}


- (NSMutableAttributedString *)setAttributedStr:(NSString *)str1 withStr2:(NSString *)str2{
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    NSRange rangleft = NSMakeRange(0, str1.length+1);
    NSRange range2 = NSMakeRange(strAtt.length-str2.length, str2.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeColor  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeColor  range:range2];
    
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
