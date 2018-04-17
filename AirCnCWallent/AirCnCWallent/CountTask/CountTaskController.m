//
//  CountTaskController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

//算力任务

#import "CountTaskController.h"
#import "CountTaskCell.h"
#import "MarsButton.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64

@interface CountTaskController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UILabel *basePow;
@property (nonatomic, strong) UILabel *currentPow;
@property (nonatomic, strong) UILabel *plusPow;
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation CountTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = GetString(@"task01");//算力任务
    
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:0];
//    [self.view addSubview:self.tableview];
//    [self.view insertSubview:self.customNavBar aboveSubview:self.tableview];
//    [_tableview registerClass:[CountTaskCell class] forCellReuseIdentifier:NSStringFromClass([CountTaskCell class])];
//
//    [self setHeadView];
    
    
    
}


- (void)setHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 260*scale_h+kTop)];
    _headView.backgroundColor = [UIColor whiteColor];
    _tableview.tableHeaderView = _headView;
    
    UIImageView* topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200*scale_h+kTop)];
    topView.image = [UIImage imageNamed:@"背景3"];
    [_headView addSubview:topView];
    
    
    
    _basePow = [[UILabel alloc] initWithFrame:CGRectMake(20, 0*scale_h+kTop, kWidth-40, 80*scale_h)];
    _basePow.textAlignment = NSTextAlignmentCenter;
    _basePow.numberOfLines = 0;
    [topView addSubview:self.basePow];
    
    _currentPow = [[UILabel alloc] initWithFrame:CGRectMake(0, topView.bottom-70*scale_h, kWidth/2, 50*scale_h)];
    _currentPow.textAlignment = NSTextAlignmentCenter;
    _currentPow.numberOfLines = 0;
    [topView addSubview:self.currentPow];
    
    _plusPow = [[UILabel alloc] initWithFrame:CGRectMake( kWidth/2, topView.bottom-70*scale_h, kWidth/2, 50*scale_h)];
    _plusPow.textAlignment = NSTextAlignmentCenter;
    _plusPow.numberOfLines = 0;
    [topView addSubview:self.plusPow];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, topView.bottom, kWidth, 60*scale_h)];
    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.image = [UIImage imageNamed:@"任务列表"];
    [_headView addSubview:_imageView];
    
    
    
    _basePow.attributedText = [self setAttributedNumber:@"78" withType:1 fontSize:35];
     _currentPow.attributedText = [self setAttributedNumber:@"68" withType:2 fontSize:25];
     _plusPow.attributedText = [self setAttributedNumber:@"48%" withType:3 fontSize:25];
    
//    "task02" = "基础算力";
//    "task03" = "当前算力";
//    "task04" = "加乘算力";
//    "task05" = "每邀请1位";
//    "task06" = "每日登录";
//    "task07" = "交易密码";
//    "task08" = "邮箱绑定";
//    "task09" = "算力";
        
}

#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CountTaskCell *accountCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CountTaskCell class]) forIndexPath:indexPath];
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    accountCell.indexPath = indexPath;
    [accountCell setValueByIndexPath:indexPath];
    return accountCell;
}




/**
 DescriptionNSMutableAttributedString

 @param number ss
 @param type 1 基础算力 2 当前算力 3加乘算力
 @param size 字体大小
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)setAttributedNumber:(NSString *)number withType:(NSInteger)type fontSize:(NSInteger)size{
    
    
    NSString *str = @"";
    if (type == 1) {
        str = [NSString stringWithFormat:@"%@\n",GetString(@"task02")];
    }else  if (type == 2) {
        str = [NSString stringWithFormat:@"%@\n",GetString(@"task03")];
    }else {
        str = [NSString stringWithFormat:@"%@\n",GetString(@"task04")];
    }
    
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str,number]];
    
    NSRange rangleft = NSMakeRange(0, str.length);
    NSRange range2 = NSMakeRange(strAtt.length-number.length, number.length);
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*scale_h] range:rangleft];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:rangleft];
    
    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:size*scale_h] range:range2];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:range2];
    
    return strAtt;
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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kTabBar)  style:UITableViewStylePlain];
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
