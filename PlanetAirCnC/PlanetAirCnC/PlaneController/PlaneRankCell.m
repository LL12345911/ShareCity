//
//  PlaneRankCell.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/27.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "PlaneRankCell.h"

@interface PlaneRankCell()

@property (nonatomic,strong) UIView *back;

@property (nonatomic,strong) UIButton *ranking; //
@property (nonatomic,strong) UILabel *userName; //
@property (nonatomic,strong) UILabel *normal;   //
@property (nonatomic,strong) UILabel *luck;     //
@property (nonatomic,strong) UILabel *force;    //
@property (nonatomic,strong) UIView *line;


@end

@implementation PlaneRankCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self layoutReloadViewFrame];
    }
    return self;
}

- (void)setValueModel:(NSString *)model indexPathRow:(NSInteger)row{
    
    if (row == 0) {
        [_ranking setTitle:@"" forState:0];
        [_ranking setImage:[UIImage imageNamed:@"金牌"] forState:0];
    }else if (row == 1) {
        [_ranking setTitle:@"" forState:0];
        [_ranking setImage:[UIImage imageNamed:@"银牌"] forState:0];
    }else if (row == 2) {
        [_ranking setTitle:@"" forState:0];
        [_ranking setImage:[UIImage imageNamed:@"铜牌"] forState:0];
    }else{
        [_ranking setTitle:[NSString stringWithFormat:@"%ld",row] forState:0];
        [_ranking setImage:[UIImage new] forState:0];
    }
    
}


- (void)layoutReloadViewFrame{
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(0, 0*scale_h, kWidth, 60*scale_h)];
    _back.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_back];

    _ranking = [[UIButton alloc] initWithFrame:CGRectMake(10, 20*scale_h, 20, 20*scale_h)];
    [_ranking setTitle:@"1" forState:0];
    [_ranking setTitleColor:kBlackColor forState:0];
    _ranking.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [_back addSubview:_ranking];
    
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(10+20, 0, (kWidth-80*3-50)-10, 60*scale_h)];
    _userName.text = @"XXXXXX";
    _userName.textColor = kBlackColor;
    _userName.font = [UIFont systemFontOfSize:15*scale_h];
    [_back addSubview:_userName];
    
    _normal = [[UILabel alloc] initWithFrame:CGRectMake(20+(kWidth-80*3-50)+10, 0, 80, 60*scale_h)];
    _normal.text = @"53.777";
    _normal.textColor = kGrayColor;
    _normal.font = [UIFont systemFontOfSize:15*scale_h];
    _normal.textAlignment = NSTextAlignmentRight;
    [_back addSubview:_normal];
    
    _luck = [[UILabel alloc] initWithFrame:CGRectMake(20+(kWidth-80*3-50)+10+90, 0, 70, 60*scale_h)];
    _luck.text = @"3.777";
    _luck.textColor = [UIColor purpleColor];
    _luck.font = [UIFont systemFontOfSize:15*scale_h];
    _luck.textAlignment = NSTextAlignmentRight;
    [_back addSubview:_luck];
    
    _force = [[UILabel alloc] initWithFrame:CGRectMake(20+(kWidth-80*3-50)+10+90+80, 0, 70, 60*scale_h)];
    _force.text = @"455";
    _force.textColor = kGrayColor;
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
