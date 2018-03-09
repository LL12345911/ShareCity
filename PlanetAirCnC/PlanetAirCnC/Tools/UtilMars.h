//
//  UtilMars.h
//  CarRental
//
//  Created by Mars on 2017/5/24.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import "sys/utsname.h"


#ifndef UtilMars_h
#define UtilMars_h

//*************弱引用/强引用*************//
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;

//*************数据验证*************//
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f)?f:@"")
#define HasString(str,eky) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)//判断字符串是否为空
#define ValidDict(f) (f!=nil &&[f isKindOfClass:[NSDictionary class]])//判断字典是否为空
#define ValidArray(f) (f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)//判断数组是否为空
#define ValidNum(f) (f!=nil &&[f isKindOfClass:[NSNumber class]])//判断Number是否为空
#define ValidClass(f,cls) (f!=nil &&[f isKindOfClass:[cls class]])//判断类是否为空
#define ValidData(f) (f!=nil &&[f isKindOfClass:[NSData class]])//判断Data是否为空



//*************设置 view 圆角和边框*************//
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


//*************屏幕宽高*************//
//根据高度进行比例适配
#define scale_height kHeight/568.0

//#define scale_h kHeight/667.0
//#define scale_h (kHeight == 812.0 ? 1 : (kHeight/667.0))
#define scale_h (isIphone_X == YES ? 1 : (kHeight/667.0))

/*屏幕比例*/
#define screenRate ([[UIScreen mainScreen] bounds].size.width  / 375.0)
#define screenRate6P ([[UIScreen mainScreen] bounds].size.width  / 414.0)
/*屏幕宽度*/
#define kWidth [[UIScreen mainScreen] bounds].size.width
/*屏幕高度*/
#define kHeight [[UIScreen mainScreen] bounds].size.height


#define isIphone_X [NSString isIphoneX]
//NSString *deviceName = [[DeviceInfoManager sharedManager] getDeviceName];


#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBar ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)//kTabBarHeight
#define kTop (kStatusBarHeight + kNavBarHeight)  //kTopHeight
//替换 64px →kTopHeight
//替换 49px →kTabBarHeight
//#define iPhoneX [[[UIDevice currentDevice] modelName] isEqualToString: @"iPhone X"]
//#define bottomHeight iPhoneX == YES ? 34:0;
/// 底部宏，吃一见长一智吧，别写数字了 高度系数 812.0 是iPhoneX的高度尺寸，667.0表示是iPhone 8 的高度
//#define KBottom (kHeight == 812.0 ? 34 : 0)  //KBottomHeight
#define KBottom (isIphone_X == YES ? 34 : 0)  //KBottomHeight


//安全区域
//iOS11搞的safeArea ios 11 contentInsetAdjustmentBehavior 可以在Xcode8上面跑了
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]


//*************唯一Window*************//
/*唯一Window*/
#define WINDOW (((AppDelegate *)[[UIApplication sharedApplication] delegate]).window)

//设备ID
#define DeviceID [[UIDevice currentDevice].identifierForVendor UUIDString]


//----------------------颜色类---------------------------

//*************十六进制颜色*************//
#define RGBCOLOR(color) [UIColor colorWithRed:(((color)>>16)&0xff)*1.0/255.0 green:(((color)>>8)&0xff)*1.0/255.0 blue:((color)&0xff)*1.0/255.0 alpha:1.0]

#define RGBcolor(color) [UIColor colorWithHexString:color]

//颜色 色值
#define kBlueColor RGBCOLOR(0x00a1e5)//所有的蓝色色值
#define kOrangeColor RGBCOLOR(0xe75c01)//所有橙色色值 0xe75c01
#define kBlackColor RGBCOLOR(0x333333)//深灰：0x333333
#define kGrayColor RGBCOLOR(0x999999)//浅灰：0x999999
#define kRedColor RGBCOLOR(0xf6163b)//红色：0xf6163b
#define kDeepBlueColor RGBCOLOR(0x052533)//深蓝色：0x052533
#define DeepBluerColor RGBCOLOR(0x06c35f)
#define RentBackColor RGBCOLOR(0xd1f1ff)
#define kYellowColor RGBCOLOR(0xffd520)//黄色
#define NavColor RGBCOLOR(0x0078af)//标题栏 颜色
//清除背景色
#define CLEARCOLOR [UIColor clearColor]
//----------------------颜色类--------------------------


//----------------------是否竖屏--------------------------
#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)


#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

//大于等于7.0的ios版本
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//大于等于8.0的ios版本
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")


#endif /* UtilMars_h */
