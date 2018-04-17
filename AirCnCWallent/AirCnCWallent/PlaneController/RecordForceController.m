//
//  RecordForceController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/3/1.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "RecordForceController.h"
#import "RecordForceCell.h"
#import "TaskViewController.h"

@interface RecordForceController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) UIButton *getForceBtn;


@end

@implementation RecordForceController
#pragma mark - 显示隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    // [self setStatusBarColor:[UIColor purpleColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"原力记录";
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:1];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[RecordForceCell class] forCellReuseIdentifier:NSStringFromClass([RecordForceCell class])];
    
    [self setTableviewHeadView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableview bindRefreshStyle:KafkaRefreshStyleReplicatorWoody fillColor:kOrangeColor atPosition:0 refreshHanler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableview.headRefreshControl endRefreshing];
        });
    }];
//    self.tableview.headRefreshControl.backgroundColor = [UIColor clearColor];
    
    [self setTableviewHeadView];
    [self.view addSubview:self.getForceBtn];
}

#pragma mark - 获取任务
- (void)speedMethod{
    TaskViewController *taskView = [[TaskViewController alloc] init];
    [self.navigationController pushViewController:taskView animated:YES];
}

- (void)setTableviewHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300+40*scale_h)];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headView;
    
    UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 140*scale_h)];
    imageBack.image = [UIImage imageNamed:@"millcolorGrad"];
    [_headView addSubview:imageBack];
    
    UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 30*scale_h)];
    numberL.text = @"当前原力值";
    numberL.font = [UIFont systemFontOfSize:16*scale_h];
    numberL.textAlignment = NSTextAlignmentCenter;
    numberL.textColor = [UIColor purpleColor];
    [imageBack addSubview:numberL];
    
    _number = [[UILabel alloc] initWithFrame:CGRectMake(20, 50*scale_h, kWidth-40, 70*scale_h)];
    _number.text = @"67";
    _number.font = [UIFont boldSystemFontOfSize:50*scale_h];
    _number.textAlignment = NSTextAlignmentCenter;
    _number.textColor = [UIColor whiteColor];
    _number.adjustsFontSizeToFitWidth = YES;
    [imageBack addSubview:_number];
    
    UIView *titleBack = [[UIView alloc] initWithFrame:CGRectMake(0, 150*scale_h, kWidth, 60*scale_h)];
    titleBack.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:titleBack];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 150*scale_h, kWidth-40, 60*scale_h)];
    title1.text = @"原力简介";
    title1.font = [UIFont boldSystemFontOfSize:16*scale_h];
    title1.textColor = kBlackColor;
    [_headView addSubview:title1];
    
    UIView *descBack = [[UIView alloc] initWithFrame:CGRectMake(0, 210*scale_h+1, kWidth, 60*scale_h)];
    descBack.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:descBack];
    
    UILabel *descL = [[UILabel alloc] initWithFrame:CGRectMake(20, 210*scale_h+1, kWidth-40, 30*scale_h)];
    descL.text = @"原力是用户获取黑钻的影响因子，原力越高，获得的黑钻越多。黑钻每天产量固定，第一年每天产量约27万个，每2年减半一次。按照用户当前的原力值在星球基地总的原力值占比分配黑钻。假设每日发放黑钻总数C，用户每日领取到的黑钻=C*该用户当前原力值/所有用户原力值之和";
    descL.font = [UIFont boldSystemFontOfSize:14*scale_h];
    descL.textColor = kGrayColor;
    descL.numberOfLines = 0;
    descL.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:descL];
    [descL sizeToFit];
    descL.height += 20;
    descBack.height = descL.height;
    
    UIView *titleBack2 = [[UIView alloc] initWithFrame:CGRectMake(0, descL.height+10*scale_h+1+210*scale_h, kWidth, 60*scale_h)];
    titleBack2.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:titleBack2];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(20, descL.height+10*scale_h+1+210*scale_h, kWidth-40, 60*scale_h)];
    title2.text = @"收支记录";
    title2.font = [UIFont boldSystemFontOfSize:16*scale_h];
    title2.textColor = kBlackColor;
    [_headView addSubview:title2];
    
    _headView.frame = CGRectMake(0, 0, kWidth, descL.height+10*scale_h+1+270*scale_h+1);
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*scale_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecordForceCell *forceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecordForceCell class]) forIndexPath:indexPath];
    //    [rankCell setValueModel:@"" indexPathRow:indexPath.row];
    forceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return forceCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-KBottom-kTop-50*scale_h) style:UITableViewStylePlain];
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

- (UIButton *)getForceBtn{
    if (!_getForceBtn) {
        _getForceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kHeight-KBottom-50*scale_h, kWidth, KBottom+50*scale_h)];
        [_getForceBtn setBackgroundImage:[UIImage imageNamed:@"millcolorGrad"] forState:0];
        [_getForceBtn setTitle:@"获取原力" forState:0];
        _getForceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*scale_h];
        [_getForceBtn addTarget:self action:@selector(speedMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getForceBtn;
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
