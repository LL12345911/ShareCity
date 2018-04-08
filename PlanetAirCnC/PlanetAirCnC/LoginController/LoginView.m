//
//  LoginView.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/2.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setView];
    }
    
    return self;
}


- (void)setView{
    
//    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//    NSArray *imageNameArray = @[@"a",@"b",@"c"];
//
//    //关闭滑动提示条
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.pagingEnabled = YES;  //开启翻页设置
//    _scrollView.contentSize = CGSizeMake(imageNameArray.count*kWidth, kHeight); //设置内容尺寸
//    _scrollView.bounces = NO; //设置超出内容尺寸不能滑动
//    _scrollView.delegate = self;  //设置代理
//    _scrollView.backgroundColor = [UIColor yellowColor];
//    [self addSubview:_scrollView];
//
//    //创建pageControl
//    _pageControl = [[UIPageControl alloc] init];
//    _pageControl.numberOfPages = imageNameArray.count;                      //设置pageControl圆点个数
//    CGSize size = [_pageControl sizeForNumberOfPages:imageNameArray.count]; //获得pageControl的尺寸
//    _pageControl.bounds = CGRectMake(f_zero, f_zero, size.width, size.height);//设置边界
//    _pageControl.center = CGPointMake(kWidth/2, kHeight-2*gap_10);          //设置中心
//    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];      //设置当前圆点颜色
//    _pageControl.pageIndicatorTintColor = kGrayColor;              //设置其他圆点颜色
//    [self addSubview:_pageControl];
//    //添加点击事件
//    [_pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
//
//    //为scrollview添加图片
//    for (int imageNum = 0; imageNum < imageNameArray.count; imageNum++) {
//        UIImage *image = [UIImage imageNamed:imageNameArray[imageNum]];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageNum*kWidth, f_zero, kWidth, kHeight)];
//        imageView.image = image;
//        [_scrollView addSubview:imageView];
//        if (imageNum == imageNameArray.count-1) {
//            imageView.userInteractionEnabled = YES;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadToLoginView)];
//            [imageView addGestureRecognizer:tap];
//        }
//    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
