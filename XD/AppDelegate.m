//
//  AppDelegate.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.


#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "ZhuYeViewController.h"


@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyAndVisible];
    
    /*!
     * 打印出所有的字体
     */
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        printf( "Family: %s \n", [familyName UTF8String] );
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }

    
    MainTabBarController  * mtb=[[MainTabBarController alloc] init];
    
    ZhuYeViewController* zyc=[[ZhuYeViewController alloc] init];
    /*!
     *特别注意：_sideViewController 必须要xib创建
     */
    _sideViewController =
    [[YRSideViewController alloc] initWithNibName:nil bundle:nil];
    _sideViewController.rootViewController=mtb;
    _sideViewController.leftViewController=zyc;
    
    _sideViewController.leftViewShowWidth = 200*View_Radio;
    [_sideViewController setNeedSwipeShowMenu:NO];
 //默认开启的可滑动展示
    self.window.rootViewController=_sideViewController;
    return YES;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
