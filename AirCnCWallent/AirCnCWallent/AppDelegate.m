//
//  AppDelegate.m
//  AirCnCWallent
//
//  Created by Mars on 2018/2/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MainTabBarController.h"
#import "LoginController.h"
#import <UserNotifications/UserNotifications.h>
#import "BaseNavigationController.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    //[NSThread sleepForTimeInterval:3.0]; //设置启动页面时间,系统默认1秒
    //记录应用打开次数
    [Helper recordAppOpenTimes];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self keyboardManager];
    //选择本地语言
    [self choseLanguage];
    
//[Helper setValue:@"" forkey:USER_Token];
    
    //用户已经登录过，进入首页，没有则进入登录界面  //如果token存在，则直接登录，
    //[Helper setValue:@"5d2881e6941f5442305a3e02843560e3" forkey:USER_Token];
    NSString *token =  ValidStr([Helper getValueForKey:USER_Token]) ? [Helper getValueForKey:USER_Token]:@"" ;
    if (token.length > 2) {
        //如果token存在，则直接进入主页，
        self.window.rootViewController = [[MainTabBarController alloc] init];
    }else{
        LoginController* loginView = [[LoginController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginView];
        self.window.rootViewController = nav;
    }
    
    //ios自带推送
    [self registerRemoteNotification];
//    [self registLocationNotification];
    [self.window makeKeyAndVisible];
    return YES;
}




#pragma mark - 用户通知(推送) _自定义方法
/** 注册远程通知 */
- (void)registerRemoteNotification {
    /*
     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [self registeriOS10LaterRemoteNotification];
        
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}
#pragma mark - iOS 10 以上 注册 验车通知
- (void)registeriOS10LaterRemoteNotification{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
#else // Xcode 7编译会调用
    UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}



#pragma mark - 远程通知(推送)回调
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    DebugLog(@"远程通知 ---- %@",token)
}


/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
    
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
//        [self choiseLocation];
    }
}



#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
//    [GeTuiSdk setBadge:[UIApplication sharedApplication].applicationIconBadgeNumber+1];
    // 控制台打印接收APNs信息
    NSLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {

        [self sendBeforeiOS10LocalNotification:userInfo];
        }
    
    
    completionHandler(UIBackgroundFetchResultNewData);
    
  
    
}
#pragma mark - iOS 10以下版本本地通知
- (void)sendBeforeiOS10LocalNotification:(NSDictionary *)userInfo{
    NSDictionary *infoDic = [NSDictionary dictionaryWithDictionary:userInfo[@"aps"]];//aps
    
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //设置调用时间
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];//通知触发的时间，10s以后
    notification.repeatInterval = 2;//通知重复次数
    notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody = infoDic[@"alert"];;//[NSString stringWithFormat:@"Agent-%d",arc4random()%100]; //通知主体
        notification.applicationIconBadgeNumber += 1;//应用程序图标右上角显示的消息数
        notification.alertAction = @"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage = @"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
        notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
//    设置用户信息
        notification.userInfo = userInfo;//@{@"id": @1, @"user": @"cloudox"};//绑定到通知上的其他附加信息
        notification.alertBody = infoDic[@"alert"];
//    调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}



#pragma mark - iOS 10中收到推送消息
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#pragma mark - iOS 10: App在前台获取到通知 接收到通知的事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    
//    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
//
//    //这个和下面的userNotificationCenter:didReceiveNotificationResponse withCompletionHandler: 处理方法一样
//    NSDictionary *userInfo = notification.request.content.userInfo;
//
//    //收到推送的请求
//    UNNotificationRequest *request = notification.request;
//    //收到推送的内容
//    UNNotificationContent *content = request.content;
//    NSNumber *badge = content.badge;
//    NSString *body = content.body;
//    NSString *title = content.title;
//    NSString *subTitle = content.subtitle;
//    UNNotificationSound *sound =  [UNNotificationSound defaultSound];//content.sound;
//
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
//    } else {
//        // 判断为本地通知
//        NSLog(@"iOS10 应用在前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}", body, title, subTitle, badge, sound, userInfo);
//    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    
}
//应用在后台，但是还活着
//收到远程推送打开app时做的跳转页面###
#pragma mark - iOS 10: 点击通知进入App时触发 通知的点击事件
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
//    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:response.notification.request.content.userInfo];
//    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    //    //跳转页面
    //    DetailContentVC *detailVC=[DetailContentVC new];
    //    detailVC.titleValue=_webTitle;
    //    detailVC.requestUrl=_webUrl;
    //    detailVC.hidesBottomBarWhenPushed=YES;
    //    self.window.rootViewController.hidesBottomBarWhenPushed=NO;
    //    [((UITabBarController *)self.window.rootViewController).selectedViewController pushViewController:detailVC animated:YES];
    //
        completionHandler();
    
}
//#endif




#pragma mark - 选择本地语言
- (void)choseLanguage{
    //判断是否是第一次启动
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        //设置本地语言
        if ([self isChineseLanguage]) {
            NSString *languageStr = @"zh-Hans";
            [[NSUserDefaults standardUserDefaults] setObject:languageStr forKey:AppLanguage];
        }else{
            NSString *languageStr = @"en";
            [[NSUserDefaults standardUserDefaults] setObject:languageStr forKey:AppLanguage];
        }
    }
}

#pragma mark - 键盘工具
- (void)keyboardManager{
    /**
     IQKeyboardManager
     */
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时,通过点击“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
}

#pragma mark --- 获取系统语言
- (NSString *)getCurrentLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

#pragma mark --- 判断当前系统语言为中文
- (BOOL)isChineseLanguage{
    BOOL isChinese = NO;
    if ([[self getCurrentLanguage] rangeOfString:@"zh-Hans"].length > 0) {
        isChinese = YES;
        NSLog(@"当前中文");
    }
    return isChinese;
}



#pragma mark - 注册本地通知
-(void)registLocationNotification{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        
        if (@available(iOS 10.0, *)) {
            // 使用 UNUserNotificationCenter 来管理通知
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            //监听回调事件
            center.delegate = self;
            
            //iOS 10 使用以下方法注册，才能得到授权
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                                  completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                      // Enable or disable features based on authorization.
                                  }];
            //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {}];
            
        }
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0&&[[UIDevice currentDevice].systemVersion floatValue] < 10.0){
        //项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
    }
}


/**
 iOS 10以后的本地通知
 */
- (void)addlocalNotificationForNewVersion {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"Hello" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"Agent-%d",arc4random()%100] arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        
        //    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alertTime repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"OXNotification" content:content trigger:nil];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
