//
//  ReceiptViewController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/10.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "ReceiptViewController.h"
#import "HyperlinksButton.h"
#import "UIImage+QRcode.h"
#import <objc/message.h>

@interface ReceiptViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) UIView *headview;

@property (nonatomic,strong) UIView *back;

@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) UIView *addBack;
@property (nonatomic,strong) UILabel *assetAdd;
@property (nonatomic,strong) HyperlinksButton *textCopyBtn;

@property (nonatomic,strong) UIImageView *qrImage;

@property (nonatomic,strong) UILabel *desc;


@end

@implementation ReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.customNavBar.title = GetString(@"digital05");//收款
    
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    [self setHeadViewFrame];
    
}

#pragma mark - 复制邀请码到 剪切板
- (void)copyMethodForButton{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:_assetAdd.text];
    
    [HUDTools showDetailText:@"已复制" withView:self.view withDelay:2];
}


#pragma mark - 生成二维码
-(void)qrCodeMethod:(NSString *)qrCode{
    //    [UIImage CreateQrcodeWithTitle:@"https://www.jianshu.com/p/ef738baf8e33" size:100*scale_h completion:^(UIImage *image) {
    //        _qrCodeView.image = image;
    //    }];
    
    //[CIColor colorWithRed:61/255.0 green:21/255.0 blue:92/255.0 alpha:1]
    [UIImage CreateQrcodeWithTitle:qrCode size:kWidth-120 withColor:[CIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] completion:^(UIImage *image) {
        _qrImage.image = image;
    }];
    
}


- (void)setHeadViewFrame{
    
    _headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1000*scale_h)];
    _headview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.tableHeaderView = _headview;
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(20, 20*scale_h, kWidth-40, 180*scale_h+kWidth-120)];
    _back.backgroundColor = [UIColor whiteColor];
    _back.userInteractionEnabled = YES;
    [_headview addSubview:_back];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth-40, 60*scale_h)];
    _titleL.font = [UIFont systemFontOfSize:17*scale_h];
    _titleL.textColor = kBlackColor;
    _titleL.text = GetString(@"digital30");
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.adjustsFontSizeToFitWidth = YES;
    [_back addSubview:_titleL];
    
    _addBack = [[UIView alloc] initWithFrame:CGRectMake(10, 10*scale_h+_titleL.bottom, kWidth-60, 40*scale_h)];
    _addBack.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _addBack.userInteractionEnabled = YES;
    [_back addSubview:_addBack];
    
    _assetAdd = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth-70-60, 40*scale_h)];
    _assetAdd.font = [UIFont boldSystemFontOfSize:15*scale_h];
    _assetAdd.textColor = kBlackColor;
    _assetAdd.textAlignment = NSTextAlignmentCenter;
    _assetAdd.adjustsFontSizeToFitWidth = YES;
    [_addBack addSubview:_assetAdd];
    
    _textCopyBtn = [[HyperlinksButton alloc] initWithFrame:CGRectMake(kWidth-60-60, 0, 60, 40*scale_h)];
    [_textCopyBtn setTitle:GetString(@"digital31") forState:0];
    [_textCopyBtn setTitleColor:kBlueColor forState:0];
    [_textCopyBtn setColor:kBlueColor];
    _textCopyBtn.titleLabel.font = [UIFont systemFontOfSize:15*scale_h];
    [_textCopyBtn addTarget:self action:@selector(copyMethodForButton) forControlEvents:UIControlEventTouchUpInside];
    [_addBack addSubview:_textCopyBtn];
    
    _qrImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 140*scale_h, kWidth-120, kWidth-120)];
    //_qrImage.image = [UIImage imageNamed:@"Btlogo"];
    _qrImage.layer.cornerRadius = 30*scale_h;
    _qrImage.layer.masksToBounds = YES;
    [_back addSubview:_qrImage];

    
    
    _desc = [[UILabel alloc] initWithFrame:CGRectMake(20, _back.bottom+10*scale_h, kWidth-40, 40*scale_h)];
    _desc.font = [UIFont boldSystemFontOfSize:13*scale_h];
    _desc.textColor = kGrayColor;
    _desc.adjustsFontSizeToFitWidth = YES;
    _desc.numberOfLines = 0;
    [_headview addSubview:_desc];
    
    _desc.text = [NSString stringWithFormat:@"%@%@",GetString(@"digital32"),GetString(@"digital33")];
    [_desc sizeToFit];
    
    _headview.frame = CGRectMake(0, 0, kWidth, _back.bottom+10*scale_h+_desc.height+30);
    
    [_tableview beginUpdates];
    [_tableview setTableHeaderView:_headview];
    [_tableview endUpdates];
    
    

    [self qrCodeMethod:@"https://www.jianshu.com/p/ef738baf8e33"];
    _assetAdd.text = @"sjhdAAAAAAfsbkgsndgnslkjngksngksbnkdfnkdfffffff";
    
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
    
    UITableViewCell *tradingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    tradingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tradingCell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
        // _tableview.sectionIndexColor = kBlueColor;
        //_tableview.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
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
