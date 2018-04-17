//
//  WkWebViewController.m
//  AirCnCWallent
//
//  Created by Mars on 2018/3/1.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WkWebViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface WkWebViewController ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate>

@property (assign, nonatomic) NSUInteger loadCount;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *wkWebView;


@end

@implementation WkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = _titleStr;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configUI];
    
}
- (void)configUI {
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0.1, kWidth, 0)];
    //progressView.tintColor = WebViewNav_TintColor;
    progressView.tintColor = RGBCOLOR(0x800080);
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    
    //    _progressView2 = [[GradientProgressView alloc] initWithFrame:CGRectMake(0, 0.1, self.view.frame.size.width, 1.0f)];
    //    _progressView2.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:_progressView2];
    
    
    // 网页
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kTop-KBottom)];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth;//|UIViewAutoresizingFlexibleHeight;
    wkWebView.backgroundColor = [UIColor whiteColor];
    wkWebView.navigationDelegate = self;
    //self.wk.navigationDelegate = self
    // [wkWebView loadFileURL:[NSURL URLWithString:_homeUrl] allowingReadAccessToURL:[NSURL URLWithString:@""]];
    //[self.view insertSubview:wkWebView belowSubview:_progressView2];
    
    [self.view insertSubview:wkWebView belowSubview:progressView];
    
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_homeUrl]];
    [wkWebView loadRequest:request];
    self.wkWebView = wkWebView;
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    }
    
    //    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
    //        if ([challenge previousFailureCount] == 0) {
    //            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    //            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    //        } else {
    //            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    //        }
    //    } else {
    //        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    //    }
}


#pragma mark - ios-WKWebView 拨打电话
-(void)webView:(WKWebView* )webView didStartProvisionalNavigation:(WKNavigation* )navigation
{
    NSString *path= [webView.URL absoluteString];
    NSString * newPath = [path lowercaseString];
    
    if ([newPath hasPrefix:@"sms:"] || [newPath hasPrefix:@"tel:"]) {
        
        UIApplication * app = [UIApplication sharedApplication];
        if ([app canOpenURL:[NSURL URLWithString:newPath]]) {
            [app openURL:[NSURL URLWithString:newPath]];
        }
        return;
    }
    
}

#pragma mark - wkWebView代理
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            
            //_progressView2.hidden = YES;
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
            //[_progressView2 setProgress:newprogress];
            
        }
    }
}

// 记得取消监听
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}

#pragma mark - webView代理

// 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadCount ++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadCount --;
    //    NSString *jsStr = @"function reSetImgFrame() { \
    //    var imgs = document.getElementsByTagName('img'); \
    //    for (var i = 0; i < imgs.length; i++) {\
    //    var img = imgs[i];   \
    //    img.style.maxWidth = %f;   \
    //    } \
    //    }";
    //    jsStr = [NSString stringWithFormat:jsStr, [UIScreen mainScreen].bounds.size.width - 20];
    //
    //    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    //    [webView stringByEvaluatingJavaScriptFromString:@"reSetImgFrame()"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.loadCount --;
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
