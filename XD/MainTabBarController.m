//
//  MainTabBarController.m
//  XD
//
//  Created by 李攀祥 on 16/1/5.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "MainTabBarController.h"
#import "TabBar.h"
#import "ParentNavigation.h"

#import "XDNewsController.h"
#import "XDManHuaController.h"
#import "XDTuiJianController.h"

#import "AppDelegate.h"

@interface MainTabBarController ()<TabBarDelegate>
@property(nonatomic,strong)TabBar * myTabBar;

@end
@implementation MainTabBarController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController * sideViewController=[delegate sideViewController];
    [sideViewController setNeedSwipeShowMenu:NO];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    //tabbar的背景图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tapbar_bg"]];
    // 初始化taBar
    [self.tabBar addSubview:self.myTabBar];
    // 初始化控制器
    [self setupChildViewControllers];
}

// 初始化子控制器
- (void)setupChildViewControllers
{
    NSArray * vcName=@[@"XDTuiJianController",@"XDManHuaController",@"XDNewsController"];
    NSArray * normalImage=@[@"tabbar_1_no",@"tarbar_2_no",@"tarbar_3_no"];
    NSArray * selImage=@[@"tabbar_1",@"tabbar_2",@"tarbar_3"];
    NSArray * titleArr=@[@"推荐",@"漫画",@"资讯"];
    
    //创建视图控制器
    for (int i=0;i< (int)vcName.count; i++)
    {   Class class =  NSClassFromString(vcName[i]);
        UIViewController *vc =  [[class alloc] init];
        [self setupChildViewController:vc title:titleArr[i] normalImageNamed:normalImage[i] selImageNamed: selImage[i]];
    }
}

-(void)setupChildViewController:(UIViewController *)controller title:(NSString *)title normalImageNamed:(NSString *)normalImage selImageNamed:(NSString *)selImage;
{
    //创建导航控制器
     ParentNavigation  *nav = [[ParentNavigation alloc]initWithRootViewController:controller];
    [self.myTabBar addTabBarItemWithTitle:title NormalImage:normalImage selImage:selImage];
    controller.navigationItem.title = title;
    nav.tabBarItem.enabled = NO;
    [self addChildViewController:nav];
}


#pragma mark - TabBar点击事件的代理方法
- (void)tabBar:(TabBar *)tabBar didClickFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex =to;
}

#pragma mark-懒加载
-(TabBar *)myTabBar
{
    if (!_myTabBar)
    {
        _myTabBar =[[TabBar alloc] initWithFrame:self.tabBar.bounds];
        _myTabBar.delegate=self;
    }
    return _myTabBar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
