//
//  Api.h
//  PlanteAirCnc
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
#define AppApi @"http://192.168.0.178:8088" //测试地址
//  生产服务器
//#define AppApi @"https://webapp-api.aircnc.com.cn" //生产服务器



#define Api @"newapi/" //接口
//注册
#define Api_signup [NSString stringWithFormat:@"%@/v1/userinfo/signup",AppApi]
//登录接口
#define Api_login [NSString stringWithFormat:@"%@/v1/userinfo/login",AppApi]
//验证码登录：/v1/userinfo/smslogin
#define Api_smslogin [NSString stringWithFormat:@"%@/v1/userinfo/smslogin",AppApi]
//获取验证码
#define Api_mobilecode [NSString stringWithFormat:@"%@/v1/userinfo/getmobilecode",AppApi]
//设置1代表 登陆密码  2代表交易密码
#define Api_resetpwd [NSString stringWithFormat:@"%@/v1/userinfo/resetpwd",AppApi]
//获取国家接口
#define Api_getcountrylist [NSString stringWithFormat:@"%@/v1/baseinfo/getcountrylist",AppApi]
//设置页面
#define Api_getuserinfo [NSString stringWithFormat:@"%@/v1/userinfo/getuserinfo",AppApi]
//添加用户姓名
#define Api_updatenameinfo  [NSString stringWithFormat:@"%@/v1/userinfo/updatenameinfo",AppApi]
//修改邮箱
#define Api_updatemail  [NSString stringWithFormat:@"%@/v1/userinfo/updatemail",AppApi]
//获取常用地址
#define Api_getpurseassetslist [NSString stringWithFormat:@"%@/v1/userinfo/getpurseassetslist",AppApi]
//创建/修改钱包
#define Api_editpurseassetsinfo  [NSString stringWithFormat:@"%@/v1/userinfo/editpurseassetsinfo",AppApi]
//获取用户币种
#define Api_getcurrencylist  [NSString stringWithFormat:@"%@/v1/userinfo/getcurrencylist",AppApi]
//获取所有币种信息
#define Api_getallcurrencylist  [NSString stringWithFormat:@"%@/v1/userinfo/getallcurrencylist",AppApi]
//增加货币接口
#define Api_setcurrency  [NSString stringWithFormat:@"%@/v1/userinfo/setcurrency",AppApi]

//增加货币接口 /v1/userinfo/setcurrency
//传递参数：currencyid  userid  type  token 。type=1代表增加 type=2代表删除




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
