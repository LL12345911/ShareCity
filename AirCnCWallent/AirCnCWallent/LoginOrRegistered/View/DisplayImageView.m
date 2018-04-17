//
//  DisplayImageView.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/2.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "DisplayImageView.h"

#define f_zero 0
#define gap_10 10

static DisplayImageView *instance;

@interface DisplayImageView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end


@implementation DisplayImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self showIamgeViewForView];
    }
    
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)showIamgeViewForView{
    
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel = UIWindowLevelAlert;
    self.frame = window.bounds;
    [window addSubview:self];
    
//    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    NSArray *imageNameArray = @[@"a",@"b",@"c"];
    
    //关闭滑动提示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;  //开启翻页设置
    _scrollView.contentSize = CGSizeMake(imageNameArray.count*kWidth, kHeight); //设置内容尺寸
    _scrollView.bounces = NO; //设置超出内容尺寸不能滑动
    _scrollView.delegate = self;  //设置代理
    _scrollView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_scrollView];
    
    //创建pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = imageNameArray.count;                      //设置pageControl圆点个数
    CGSize size = [_pageControl sizeForNumberOfPages:imageNameArray.count]; //获得pageControl的尺寸
    _pageControl.bounds = CGRectMake(f_zero, f_zero, size.width, size.height);//设置边界
    _pageControl.center = CGPointMake(kWidth/2, kHeight-2*gap_10);          //设置中心
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];      //设置当前圆点颜色
    _pageControl.pageIndicatorTintColor = kGrayColor;              //设置其他圆点颜色
    [self addSubview:_pageControl];
    //添加点击事件
    [_pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    
    //为scrollview添加图片
    for (int imageNum = 0; imageNum < imageNameArray.count; imageNum++) {
        UIImage *image = [UIImage imageNamed:imageNameArray[imageNum]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageNum*kWidth, f_zero, kWidth, kHeight)];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        if (imageNum == imageNameArray.count-1) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadToLoginView)];
            [imageView addGestureRecognizer:tap];
        }
    }
    
}


#pragma mark -
#pragma mark - 版本新特性  加载进入画面
- (void)loadLeadImage{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(f_zero, f_zero, kWidth, kHeight)];
    NSArray *imageNameArray = @[@"a",@"b",@"c"];
    
    //创建pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = imageNameArray.count;                      //设置pageControl圆点个数
    CGSize size = [_pageControl sizeForNumberOfPages:imageNameArray.count]; //获得pageControl的尺寸
    _pageControl.bounds = CGRectMake(f_zero, f_zero, size.width, size.height);//设置边界
    _pageControl.center = CGPointMake(kWidth/2, kHeight-2*gap_10);          //设置中心
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];      //设置当前圆点颜色
    _pageControl.pageIndicatorTintColor = kGrayColor;              //设置其他圆点颜色
    [self addSubview:_pageControl];
    //添加点击事件
    [_pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    
    //为scrollview添加图片
    for (int imageNum = 0; imageNum < imageNameArray.count; imageNum++) {
        UIImage *image = [UIImage imageNamed:imageNameArray[imageNum]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageNum*kWidth, f_zero, kWidth, kHeight)];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        if (imageNum == imageNameArray.count-1) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadToLoginView)];
            [imageView addGestureRecognizer:tap];
        }
    }
    
}
#pragma mark -
#pragma mark - 不是第一次打开应用时
- (void)loadToLoginView{
    [self removeFromSuperview];
    if ([self.deletage respondsToSelector:@selector(removeDisplayImageViewFromSuperview)]) {
        [self.deletage removeDisplayImageViewFromSuperview];
    }
}


//pagecontroller点击响应事件
- (void)pageChange{
    CGFloat x = _pageControl.currentPage*kWidth;
    [_scrollView setContentOffset:CGPointMake(x, f_zero) animated:YES];
}
//scrollview滑动结束设置pageControl偏移量
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x/kWidth;
    _pageControl.currentPage = page;
}


@end
