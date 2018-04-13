//
//  PopView.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "PopView.h"
#import "TDButton.h"
#import "PopViewCell.h"

@interface PopView ()<UITableViewDelegate,UITableViewDataSource,PopViewCellDeletage>

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIButton *coinType;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArr;


@end

@implementation PopView

#pragma mark -lifeCycle
- (instancetype)init{
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor clearColor] ;//UIColorFromHEX(0xffffff);
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.windowLevel = UIWindowLevelAlert;

    [window addSubview:self.superView];
    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];
    
    [self.superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];
    
    _coinType = [[TDCustomButton alloc] initWitAligenmentStyle:TDAligenmentStyleCenter];
    _coinType.frame = CGRectMake(0, 25*scale_h+kTop, kWidth, 49*scale_h);
    [_coinType setTitle:GetString(@"digital35") forState:0];
    [_coinType setTitleColor:kNavColor forState:0];
    _coinType.titleLabel.font = [UIFont systemFontOfSize:17*scale_h];
    _coinType.backgroundColor = [UIColor whiteColor];
    [_coinType setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    //[_selectBtn addTarget:self action:@selector(dropDownView) forControlEvents:UIControlEventTouchUpInside];
    
    _coinType.layer.shadowColor = [UIColor blackColor].CGColor;
    _coinType.layer.shadowOpacity = 0.8f;
    _coinType.layer.shadowRadius = 4.f;
    _coinType.layer.shadowOffset = CGSizeMake(0,0);
    [self addSubview:_coinType];
    
    [self addSubview:self.tableview];
    [_tableview registerClass:[PopViewCell class] forCellReuseIdentifier:NSStringFromClass([PopViewCell class])];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePayPopView)];
    [_superView addGestureRecognizer:tap];
    
   
}






- (void) clickPopViewCellWithValue:(NSIndexPath *)indexPath{
    DebugLog(@"===================");
    if ([self.delegate respondsToSelector:@selector(selectCoinTypeWithValue:)]) {
        [self.delegate selectCoinTypeWithValue:_dataArr[indexPath.row]];
    }
}


#pragma mark - UITableView 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*scale_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PopViewCell *popCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PopViewCell class]) forIndexPath:indexPath];
    popCell.selectionStyle = UITableViewCellSelectionStyleNone;
    popCell.deletage = self;
    popCell.indexPath = indexPath;
    
    if (_dataArr.count > 0) {
        PopCoinTypeModel *model = [PopCoinTypeModel yy_modelWithDictionary:_dataArr[indexPath.row]];
        [popCell setValueByPopCoinTypeModel:model];
    }
    return popCell;
    
}

#pragma mark - 懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 75*scale_h+kTop, kWidth, 300*scale_h)  style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}

#pragma mark -Public

- (void)showPayPopView:(NSArray *)arr{
    
    
    _dataArr = [NSArray arrayWithArray:arr];
    
    [_tableview reloadData];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    } completion:nil];
}

- (void)hidePayPopView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.alpha = 0.0;
        strongSelf.frame = CGRectMake(strongSelf.frame.origin.x, kHeight, strongSelf.frame.size.width, strongSelf.frame.size.height);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.superView removeFromSuperview];
        strongSelf.superView = nil;
    }];
}



#pragma mark -Setter/Getter
- (UIView *)superView{
    if (!_superView){
        _superView = [[UIView alloc] init];
    }
    return _superView;
}


@end
