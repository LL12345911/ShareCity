//
//  TradingDetailsCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "TradingDetailsCell.h"


@interface TradingDetailsCell()

@property (nonatomic,strong) UILabel *typeName;   //
@property (nonatomic,strong) UILabel *right; //
@property (nonatomic,strong) UIButton *textBtn; //
@property (nonatomic,strong) UIView *line;//

@end

@implementation TradingDetailsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setTypeName:(NSString *)type value:(NSString *)value row:(NSInteger)row{
    
    if (row != 3) {
        _right.frame = CGRectMake(0, 0, kWidth-20, 50*scale_h);
        _textBtn.frame = CGRectMake(kWidth-50*scale_h-20, 25*scale_h/2.0, 0, 25*scale_h);
    }else{
        _right.frame = CGRectMake(0, 0,kWidth-50*scale_h-40, 50*scale_h);
        _textBtn.frame = CGRectMake(kWidth-50*scale_h-20, 25*scale_h/2.0, 50*scale_h, 25*scale_h);
    }
    
    _typeName.text = type;
    _right.text = value;
}

#pragma mark - 复制邀请码到 剪切板
- (void)copyMethodForButton{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:_right.text];
    
    [HUDTools showDetailText:@"已复制" withView:self.contentView withDelay:2];
    
}


- (void)layoutReloadViewFrame{
    
    _typeName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWidth-120, 50*scale_h)];
    _typeName.font = [UIFont systemFontOfSize:16*scale_h];
    _typeName.textColor = kGrayColor;
    [self.contentView addSubview:_typeName];
    
    _right = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-20, 50*scale_h)];
    _right.font = [UIFont systemFontOfSize:16*scale_h];
    _right.textColor = kBlackColor;
    _right.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_right];
    
    _textBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-50*scale_h-20, 25*scale_h/2.0, 50*scale_h, 25*scale_h)];
    _textBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _textBtn.layer.borderWidth = 1;
    _textBtn.layer.cornerRadius = 25*scale_h/2.0;
    [_textBtn setTitle:GetString(@"digital31") forState:0];
    [_textBtn setTitleColor:kGrayColor forState:0];
    _textBtn.titleLabel.font = [UIFont systemFontOfSize:13*scale_h];
    [_textBtn addTarget:self action:@selector(copyMethodForButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_textBtn];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 50*scale_h-1, kWidth, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_line];
    
    _typeName.text = @"收款";
    _right.text = @"+2.009987766";
    
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
