//
//  DiamondsRecordController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "DiamondsRecordController.h"
#import "DiamondsRecordCell.h"

@interface DiamondsRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UILabel *number;


@end

@implementation DiamondsRecordController

#pragma mark - 显示隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    // [self setStatusBarColor:[UIColor purpleColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"黑钻记录";
    
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[DiamondsRecordCell class] forCellReuseIdentifier:NSStringFromClass([DiamondsRecordCell class])];
    
    [self setTableviewHeadView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableview bindRefreshStyle:KafkaRefreshStyleReplicatorWoody fillColor:kOrangeColor atPosition:0 refreshHanler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableview.headRefreshControl endRefreshing];
        });
    }];
//    self.tableview.headRefreshControl.backgroundColor = [UIColor clearColor];
    
    [self setTableviewHeadView];
    
}

- (void)setTableviewHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300+40*scale_h)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headView;
    
   
    UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200*scale_h)];
    imageBack.image = [UIImage imageNamed:@"millcolorGrad"];
    [_headView addSubview:imageBack];
    
    UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 30*scale_h)];
    numberL.text = @"黑钻总数";
    numberL.font = [UIFont systemFontOfSize:16*scale_h];
    numberL.textAlignment = NSTextAlignmentCenter;
    numberL.textColor = [UIColor purpleColor];
    [imageBack addSubview:numberL];
    
    _number = [[UILabel alloc] initWithFrame:CGRectMake(20, 50*scale_h, kWidth-40, 70*scale_h)];
    _number.text = @"0.000009";
    _number.font = [UIFont boldSystemFontOfSize:50*scale_h];
    _number.textAlignment = NSTextAlignmentCenter;
    _number.textColor = [UIColor whiteColor];
    _number.adjustsFontSizeToFitWidth = YES;
    [imageBack addSubview:_number];
    
    UIButton *exchangeBtn = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-150)/2, 140*scale_h, 150, 40*scale_h)];
    [exchangeBtn setTitle:@"兑换" forState:0];
    [exchangeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    exchangeBtn.backgroundColor = [UIColor redColor];
    [imageBack addSubview:exchangeBtn];
    
    UIView *titleBack = [[UIView alloc] initWithFrame:CGRectMake(0, 210*scale_h, kWidth, 60*scale_h)];
    titleBack.backgroundColor = [UIColor whiteColor];
     [_headView addSubview:titleBack];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 210*scale_h, kWidth-40, 60*scale_h)];
    title1.text = @"黑钻简介";
    title1.font = [UIFont boldSystemFontOfSize:16*scale_h];
    title1.textColor = kBlackColor;
    [_headView addSubview:title1];
    
    UIView *descBack = [[UIView alloc] initWithFrame:CGRectMake(0, 270*scale_h+1, kWidth, 60*scale_h)];
    descBack.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:descBack];
    
    UILabel *descL = [[UILabel alloc] initWithFrame:CGRectMake(20, 270*scale_h+1, kWidth-40, 30*scale_h)];
    descL.text = @"黑钻是依托于区块链技术，基于个人星球活动产生的奖励，可以用于星球上的消费与兑换等。除日常活动根据原力大小生长黑钻之外，原力大于35的用户有机会获取额外的黑钻大奖，称之为幸运钻。同时，获得幸运钻也会消耗一定数量的原力。48小时不领取黑钻将暂停生长。黑钻总量有限，且每2年产出量减少一半，随着时间的推移获取难度越来越大，前期参与更有优势。";
    descL.font = [UIFont boldSystemFontOfSize:14*scale_h];
    descL.textColor = kGrayColor;
    descL.numberOfLines = 0;
    descL.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:descL];
    [descL sizeToFit];
    descL.height += 20;
    descBack.height = descL.height;

    
    UIView *titleBack2 = [[UIView alloc] initWithFrame:CGRectMake(0, descL.height+10*scale_h+1+270*scale_h, kWidth, 60*scale_h)];
    titleBack2.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:titleBack2];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(20, descL.height+10*scale_h+1+270*scale_h, kWidth-40, 60*scale_h)];
    title2.text = @"收支记录";
    title2.font = [UIFont boldSystemFontOfSize:16*scale_h];
    title2.textColor = kBlackColor;
    [_headView addSubview:title2];
    
    
    _headView.frame = CGRectMake(0, 0, kWidth, descL.height+10*scale_h+1+330*scale_h+1);
    [_tableview beginUpdates];
    [_tableview setTableHeaderView:_headView];
    [_tableview endUpdates];
    
}



- (void)overloadingReloadData{
    DebugLog(@"++++++++++++++");
}

#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*scale_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiamondsRecordCell *rankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DiamondsRecordCell class]) forIndexPath:indexPath];
//    [rankCell setValueModel:@"" indexPathRow:indexPath.row];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rankCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-KBottom-kTop) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.sectionIndexColor = kBlueColor;
        _tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
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
