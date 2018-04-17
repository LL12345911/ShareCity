//
//  IntroduceController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

// 纷享城介绍

#import "IntroduceController.h"
#import "MarsButton.h"


#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64

@interface IntroduceController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIView *backview;
@property (nonatomic, strong) MarsButton *assets;
@property (nonatomic, strong) UILabel *shareNum;
@property (nonatomic, strong) UILabel *shareNum1;

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UILabel *todayTimes;
@property (nonatomic, strong) UILabel *allTimes;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UILabel *introduceDesc;


@end

@implementation IntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"account49");// 纷享城介绍
    
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.view addSubview:self.tableview];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    [self setHeadView];
   [self setFootView];
  
}


- (void)setFootView{
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300*scale_h)];
    _footView.backgroundColor = [UIColor whiteColor];
    _tableview.tableFooterView = _footView;
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWidth-40, 50*scale_h)];
    desc.textColor = kBlackColor;
    desc.textAlignment = NSTextAlignmentCenter;
    desc.text = GetString(@"account54");
    desc.font = [UIFont systemFontOfSize:17*scale_h];
    [_footView addSubview:desc];
    
    
    _introduceDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, desc.bottom+10*scale_h, kWidth-40, 50*scale_h)];
    _introduceDesc.textColor = kGrayColor;
    _introduceDesc.textAlignment = NSTextAlignmentCenter;
    _introduceDesc.font = [UIFont systemFontOfSize:15*scale_h];
    _introduceDesc.numberOfLines = 0;
    [_footView addSubview:_introduceDesc];
    
    _introduceDesc.text = @"＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取＊提取数量：满10个可提取";
    
    [_introduceDesc sizeToFit];
    
    _footView.frame = CGRectMake(0, 0, kWidth, 60*scale_h+_introduceDesc.frame.size.height+20);
    [_tableview beginUpdates];
    [_tableview setTableFooterView:_footView];
    [_tableview endUpdates];
}



- (void)setHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, 360*scale_h+kTop)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headView;
    
    UIImageView* topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 170*scale_h+kTop)];
    topView.image = [UIImage imageNamed:@"navImage"];
    [_headView addSubview:topView];
//    "account54" = "介绍";
    
    _backview = [[UIView alloc] initWithFrame:CGRectMake(20, 20*scale_h+kTop, kWidth-40, 200*scale_h)];
    _backview.backgroundColor = [UIColor whiteColor];
    _backview.layer.cornerRadius = 5;
    _backview.layer.masksToBounds = YES;
    [_headView addSubview:self.backview];
    
    _assets = [[MarsButton alloc] initWithFrame:CGRectMake(0, 20*scale_h, kWidth-40, 100*scale_h)];
    [_assets setTitle:GetString(@"account50") forState:0];
    _assets.titleLabel.font = [UIFont systemFontOfSize:17*scale_h];
    _assets.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_assets setTitleColor:kBlackColor forState:0];
    [_assets setImage:[UIImage imageNamed:@"home"] forState:0];
    //[_assets addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:self.assets];
    
    _shareNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 20*scale_h+_assets.bottom, kWidth-100, 30*scale_h)];
    _shareNum.textColor = kBlackColor;
//    _shareNum.textAlignment = NSTextAlignmentCenter;
    _shareNum.text = GetString(@"account51");
    _shareNum.font = [UIFont systemFontOfSize:15*scale_h];
    [_backview addSubview:self.shareNum];
    
    _shareNum1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*scale_h+_assets.bottom, kWidth-60, 30*scale_h)];
    _shareNum1.textColor = kOrangeRed;
    _shareNum1.textAlignment = NSTextAlignmentRight;
    _shareNum1.font = [UIFont boldSystemFontOfSize:18*scale_h];
    [_backview addSubview:self.shareNum1];
    
    
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop+240*scale_h, kWidth, 100*scale_h)];
    _centerView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:self.centerView];
    
    _todayTimes = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (kWidth-1)/2, 100*scale_h)];
    _todayTimes.numberOfLines = 0;
    _todayTimes.textAlignment = NSTextAlignmentCenter;
    [_centerView addSubview:self.todayTimes];
    
    
    _allTimes = [[UILabel alloc] initWithFrame:CGRectMake((kWidth-1)/2+1, 0, (kWidth-1)/2, 100*scale_h)];
    _allTimes.numberOfLines = 0;
    _allTimes.textAlignment = NSTextAlignmentCenter;
    [_centerView addSubview:self.allTimes];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake((kWidth-1)/2, 15*scale_h, 1, 70*scale_h)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_centerView addSubview:self.line];
    
    
    _shareNum1.text = @"222222222";
    _todayTimes.attributedText = [self setAttributedNumber:@"23444" withType:1];
     _allTimes.attributedText = [self setAttributedNumber:@"2344499" withType:2];
 
    
}

/**
 NSMutableAttributedString

 @param number 次数
 @param type 1 今日挖钻获利次数 2 累计挖钻获利次数
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)setAttributedNumber:(NSString *)number withType:(NSInteger)type{
    
    
    NSString *str = @"";
    if (type == 1) {
        str = [NSString stringWithFormat:@"%@\n",GetString(@"account52")];
    }else{
        str = [NSString stringWithFormat:@"%@\n",GetString(@"account53")];
    }

    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str,number]];
    
    NSRange rangleft = NSMakeRange(0, str.length);
    NSRange range2 = NSMakeRange(strAtt.length-number.length, number.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kGrayColor  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:kOrangeRed  range:range2];
    
    return strAtt;
}



#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return accountCell;
}


#pragma mark - 导航栏 隐藏显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self setBackgroundAlpha:alpha];//:alpha];
        //self.customNavBar.title = @"纷享基地";
    }
    else
    {
        [self setBackgroundAlpha:0];
        //self.customNavBar.title = @"";
    }
    
    //让uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
    //    CGFloat sectionHeaderHeight = 50;
    //    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
    //        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    //    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
    //        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    //    }
    
}


#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-KBottom)  style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
