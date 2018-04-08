//
//  Api.h
//  AirCnCWallet
//
//  Created by Mars on 2018/1/24.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


#ifndef Api_h
#define Api_h

//  测试服务器
#define AppApi @"http://127.0.0.1:8008" //测试地址
//#define AppImage @"http://192.168.0.211:8087"  //前缀测试
//#define AppImage2 @"http://192.168.0.211:8083"  //前缀测试

//  生产服务器
//#define AppApi @"https://webapp-api.aircnc.com.cn" //生产服务器
//#define AppImage @"https://img2.aircnc.com.cn"  //前缀测试  系统
//#define AppImage2 @"https://img1.aircnc.com.cn"  //前缀测试 是用户

#define Api @"newapi/" //接口
//注册
#define Api_signup [NSString stringWithFormat:@"%@/v1/userinfo/getusermoney",AppApi]
//登录接口
#define Api_login [NSString stringWithFormat:@"%@/v1/userinfo/login",AppApi]
//获取验证码
#define Api_mobilecode [NSString stringWithFormat:@"%@/v1/userinfo/getmobilecode",AppApi]
//获取发放纷享钻列表接口
#define Api_diamondlist [NSString stringWithFormat:@"%@/v1/userinfo/getunpaydiamondlist",AppApi]
//获取纷享城资产接口
#define Api_purseassets [NSString stringWithFormat:@"%@/v1/userinfo/getpurseassets",AppApi]
//获取用户算力接口
#define Api_userpower [NSString stringWithFormat:@"%@/v1/userinfo/getuserpower",AppApi]
//纷享钻最新获取排场榜（前10位）
#define Api_usermoney [NSString stringWithFormat:@"%@/v1/userinfo/getusermoney",AppApi]
//添加/修改/删除常用钱包
#define Api_modifypurseassets [NSString stringWithFormat:@"%@/v1/userinfo/modifypurseassets",AppApi]
//常用联系钱包列表
#define Api_spurseassetslist [NSString stringWithFormat:@"%@/v1/userinfo/getpurseassetslist",AppApi]
//获取今日获利次数
#define Api_splitnumberbydate [NSString stringWithFormat:@"%@/v1/userinfo/getsplitnumberbydate",AppApi]
//获取挖矿总次数
#define Api_splitnumber [NSString stringWithFormat:@"%@/v1/userinfo/getsplitnumber",AppApi]
//获取总用户数
#define Api_usernumber [NSString stringWithFormat:@"%@/v1/userinfo/getusernumber",AppApi]


////
//#define Api_signup [NSString stringWithFormat:@"%@/v1/userinfo/getusermoney",AppApi]
////
//#define Api_signup [NSString stringWithFormat:@"%@/v1/userinfo/getusermoney",AppApi]
////
//#define Api_signup [NSString stringWithFormat:@"%@/v1/userinfo/getusermoney",AppApi]
////
//#define Api_signup [NSString stringWithFormat:@"%@/v1/userinfo/getusermoney",AppApi]
//




#endif /* Api_h */
