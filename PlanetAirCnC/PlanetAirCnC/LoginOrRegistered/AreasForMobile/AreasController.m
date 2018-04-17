//
//  AreasController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/8.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "AreasController.h"
#import "MarsSearchBar.h"
#import "AreaMobileModel.h"
#import "AreasMobileCell.h"

@interface AreasController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MarsSearchBar *searchBar;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *allDataArr;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *searchText;


@end

@implementation AreasController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"login32");
    
    _allDataArr = [NSMutableArray arrayWithCapacity:10];
    _dataArr = [NSMutableArray arrayWithCapacity:10];
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[AreasMobileCell class] forCellReuseIdentifier:NSStringFromClass([AreasMobileCell class])];
    
    self.tableview.tableHeaderView = self.searchBar;
    
    [self getDataFromNetwork];
}


- (void)getDataFromNetwork{
    
    [self startLoading];
    [MHHttpTool POST:Api_getcountrylist parameters:nil success:^(NSDictionary * _Nullable responseDic) {
        DebugLog(@"%@",responseDic);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseDic];
        NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
        [self stopLoading:0.5];
        if ([code isEqualToString:@"0"]) {
            
            [_allDataArr addObjectsFromArray:[responseDic[@"result"] valueForKey:@"countrylist"]];
            [_dataArr addObjectsFromArray:[responseDic[@"result"] valueForKey:@"countrylist"]];
            [_tableview reloadData];
            
        }else{
            [HUDTools showText:dic[@"msg"] withView:self.view withDelay:2];
        }
     
    } failure:^(NSError * _Nonnull error) {
        [self stopLoading:0];
        [HUDTools showText:@"网络出错" withView:self.view withDelay:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}


#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*scale_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AreasMobileCell *rankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AreasMobileCell class]) forIndexPath:indexPath];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count > 0) {
        AreaMobileModel *model = [AreaMobileModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        [rankCell setValueByAreaMobileModel:model];
    }
    return rankCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count > 0) {
//        AreaMobileModel *model = [AreaMobileModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        if ([self.delegate respondsToSelector:@selector(returnAreasForMobileInfoDic:)]) {
            [self.delegate returnAreasForMobileInfoDic:_dataArr[indexPath.row]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTop-KBottom)  style:UITableViewStylePlain];
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

- (MarsSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[MarsSearchBar alloc] initWithFrame:CGRectMake(20, 0, kWidth-40, 60*scale_h)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.searchBarTextField.font = [UIFont systemFontOfSize:15*scale_h];
        _searchBar.placeholder = GetString(@"login33");
        _searchBar.delegate = self;
        //光标颜色
        _searchBar.cursorColor = kBlueColor;
        //TextField
        _searchBar.searchBarTextField.layer.cornerRadius = 4;
        _searchBar.searchBarTextField.layer.masksToBounds = YES;
        _searchBar.searchBarTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _searchBar.searchBarTextField.layer.borderWidth = 1.0;
        //去掉取消按钮灰色背景
        _searchBar.hideSearchBarBackgroundImage = YES;
        _searchBar.rect = CGRectMake(20, 10*scale_h, kWidth-40, 40*scale_h);
    }
    return _searchBar;
}

#pragma mark -  UISearchBar Delegate
//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    _searchText = searchText;
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    
    if (searchText.length == 0) {
        [self.view endEditing:YES];
        [_dataArr addObjectsFromArray:_allDataArr];
        DebugLog(@"====================\n");
    }else{
        for (NSDictionary *infoDic in _allDataArr) {
            NSString *str = [NSString stringWithFormat:@"%@",infoDic[@"country_name"]];
            if([str rangeOfString:_searchText].location !=NSNotFound)//_roaldSearchText
            {
                [_dataArr addObject:infoDic];
            }
        }
        
    }
    [_tableview reloadData];
    
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.view endEditing:YES];
    [_dataArr removeAllObjects];
    [_tableview reloadData];
    for (NSDictionary *infoDic in _allDataArr) {
        NSString *str = [NSString stringWithFormat:@"%@",infoDic[@"country_name"]];
        if([str rangeOfString:_searchText].location !=NSNotFound)//_roaldSearchText
        {
            [_dataArr addObject:infoDic];
        }
    }
    [_tableview reloadData];

}
//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    _searchBar.frame = CGRectMake(40, 27, kWidth-100, 30);
//    // _selectBtn.hidden = NO;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_selectBtn];
//    searchBar.showsCancelButton = NO;
//    searchBar.text = nil;
//    [self.view endEditing:YES];
//    [searchBar resignFirstResponder];
//    _searchBar.text = @"";
//    _fistTimeStr = @"";
//    _secondTimeStr = @"";
//    _orderStateStr = @"";
//    _orderIDStr = @"";
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
