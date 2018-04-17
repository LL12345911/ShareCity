//
//  DiamondsRecordCell.m
//  AirCnCWallent
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "DiamondsRecordCell.h"

@interface DiamondsRecordCell()

@property (nonatomic,strong) UIView *back;

@property (nonatomic,strong) UILabel *titleL; //
@property (nonatomic,strong) UILabel *timeL;   //
@property (nonatomic,strong) UILabel *force;    //
@property (nonatomic,strong) UIView *line;


@end

@implementation DiamondsRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self layoutReloadViewFrame];
    }
    return self;
}




- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(0, 0*scale_h, kWidth, 60*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_back];
    
   
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 10*scale_h, 300, 20*scale_h)];
    _titleL.text = @"日常领取";
    _titleL.textColor = kBlackColor;
    _titleL.font = [UIFont boldSystemFontOfSize:15*scale_h];
    [_back addSubview:_titleL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(20, 30*scale_h, 300, 20*scale_h)];
    _timeL.text = @"2018-02-28 13:00";
    _timeL.textColor = kGrayColor;
    _timeL.font = [UIFont systemFontOfSize:13*scale_h];
//    _timeL.textAlignment = NSTextAlignmentRight;
    [_back addSubview:_timeL];
    
    
    _force = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-20, 60*scale_h)];
    _force.text = @"+0.00009";
    _force.textColor = kOrangeColor;
    _force.font = [UIFont systemFontOfSize:15*scale_h];
    _force.textAlignment = NSTextAlignmentRight;
    [_back addSubview:_force];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(20, 60*scale_h-1, kWidth-20, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_back addSubview:_line];
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
