//
//  TaskViewController.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/2/28.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskOneViewCell.h"
#import "TaskOneHeaderView.h"
#import "TaaskTwoHeaderView.h"
#import "TaskFooterView.h"
#import "TaskTwoViewCell.h"

@interface TaskViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collection;


@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"原力任务";
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 1.0;
    flow.minimumInteritemSpacing = 1.0;
    flow.itemSize = CGSizeMake((self.view.bounds.size.width - 2.)/3, 210);
    flow.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 5.);
    
    _collection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, kTop, kWidth, kHeight-kTop-KBottom) collectionViewLayout:flow];
    _collection.delegate =self;
    _collection.dataSource =self;
    _collection.backgroundColor =[UIColor groupTableViewBackgroundColor];
    _collection.alwaysBounceVertical = YES;
    [self.view addSubview:_collection];
    
    [_collection registerClass:[TaskOneViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TaskOneViewCell class])];
    [_collection registerClass:[TaskTwoViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TaskTwoViewCell class])];
    
    // 注册头视图
    [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [_collection registerClass:[TaskOneHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TaskOneHeaderView"];
    [_collection registerClass:[TaaskTwoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TaaskTwoHeaderView"];
    
    
    [_collection registerClass:[TaskFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TaskFooterView"];
    // [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footview"];
    
    __weak typeof(self) weakSelf = self;
    [self.collection bindRefreshStyle:KafkaRefreshStyleReplicatorWoody fillColor:kOrangeColor  atPosition:0 refreshHanler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collection.headRefreshControl endRefreshing];
        });
    }];
//    self.collection.headRefreshControl.backgroundColor = [UIColor clearColor];
}


#pragma mark - UICollectionView delegate
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 ) {
        
        TaskOneViewCell *cityCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TaskOneViewCell class]) forIndexPath:indexPath];
        return cityCell;
        
    }else if (indexPath.section == 1 ){//&& _airportRowStr.length > 0
        TaskTwoViewCell *airportCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TaskTwoViewCell class]) forIndexPath:indexPath];
        
        return airportCell;
    }else{
        return nil;
    }

    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return CGSizeMake((kWidth-2.0)/3, 140);
    }else if (indexPath.section == 1){
        
        return CGSizeMake((kWidth-2.0)/3, 120);
        
    }else{
        return CGSizeMake((kWidth - 30) / 2, 40*scale_h);
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 2;
    }else  if (section == 1 ) {
        return 3;
    
    }else{
        return 0;
    }
}


//返回头HeaderView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(kWidth,210);
    }else{
        return CGSizeMake(kWidth,50);
    }

}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(kWidth, 10);
    }else{
        
        return CGSizeMake(kWidth, 10);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            TaskOneHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TaskOneHeaderView" forIndexPath:indexPath];
            [header setValueForTitle:@"定期任务"];
//            header.titleStr = @"选择城市";
            return header;
        }else if (indexPath.section == 1){
            TaaskTwoHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TaaskTwoHeaderView" forIndexPath:indexPath];
//            header.titleStr = @"选择机场";
             [header setValueForTitle:@"独家任务"];
            return header;
        }else{
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            
            return header;
        }
        
    }else{
        
        TaskFooterView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TaskFooterView" forIndexPath:indexPath];
        return footview;
    }
    
    
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
