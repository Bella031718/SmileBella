//
//  XXCommon.h
//  SmileBella
//
//  Created by Bella on 16/12/10.
//  Copyright © 2016年 Bella. All rights reserved.
//

//#ifndef XXCommon_h
//#define XXCommon_h


#define kBLColor(R, G, B)           [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

/*************屏幕适配**************/
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height


#define Navigation_H self.navigationController.navigationBar.frame.size.height
#define Tabbar_H self.tabBarController.tabBar.frame.size.height


//系统版本
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]

#pragma mark - ios版本判断
#define kIOS5_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define kIOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define kIOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define kIOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )


//数据库表名
#define kRect (kScreenWidth - 40)/3

#define Document_Path  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]



#define iphone7P (kScreenHeight == 736)
#define iphone7 (kScreenHeight == 667)
#define iphone5 (kScreenHeight == 568)
#define iphone4 (kScreenHeight == 480)



//相对iphone6 屏幕比
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f

#define HalfF(x) ((x)/2.0f)
#define  Statur_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define  NAVIBAR_HEIGHT  (self.navigationController.navigationBar.frame.size.height)
#define  INVALID_VIEW_HEIGHT (Statur_HEIGHT + NAVIBAR_HEIGHT)
#define Max_OffsetY  50

/*************屏幕适配**************/

#define xRed                        kBLColor(255, 52, 70)
#define xGray                       kBLColor(123, 123, 123)
#define xBlack                      kBLColor(20, 20, 20)
#define xOrange                     kBLColor(237, 187, 64)
#define xBRed                       kBLColor(235, 53, 22)
//轮播图 图片张数
#define kImageCount                 6

#define NetworkURL                   @"http://api.budejie.com/api/api_open.php"










//#endif /* XXCommon_h */
