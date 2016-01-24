//
//  ParentNavigation.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ParentNavigation.h"

@interface ParentNavigation ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id gestureDelegate;

@end

@implementation ParentNavigation

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏纯色背景
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"FFFFFF"];
    /*
     导航栏图片背景
     [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""]
     */
    
    // 设置滑动返回
    [self setSlideBack];
}

+ (void)initialize
{
    //设置导航栏主题
    [self setupNavigationBarTheme];
    // 设置导航栏按钮主题
    [self setupItemButton];
}

+ (void)setupNavigationBarTheme
{  UINavigationBar *bar = [UINavigationBar appearance];
    // 设置导航栏文字
    NSDictionary *dict = @{
    NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]};
    [bar setTitleTextAttributes:dict];
}

+ (void)setupItemButton
{
    // 获取导航栏按钮全局实例
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置导航栏上item的颜色的渲染颜色
    item.tintColor = [UIColor whiteColor];
    
    NSDictionary *dict = @{
    NSFontAttributeName :[UIFont systemFontOfSize:14],
    NSForegroundColorAttributeName:[UIColor whiteColor]
                           };
    //item的字体颜色和大小
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateHighlighted];
}
#pragma mark - 统一设置滑动返回功能
- (void)setSlideBack
{
    // 设置代理
    self.delegate = self;
    
    // 把手势代理赋值给成员变量属性储存起来
    _gestureDelegate = self.interactivePopGestureRecognizer.delegate;
    
    // 禁止系统自带的手势功能
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 创建自定义pan手势,调用系统对象(self.interactivePopGestureRecognizer.delegate)的滑动方法(handleNavigationTransition:)
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
}

// 判断是否允许触发当前手势,如果是根控制器就不触发当前手势,当子控制器个数是1时就表示是根控制器,返回NO,表示不能触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (self.childViewControllers.count != 1);
}


//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{   // 判断当前是否为导航控制器的根控制器,如果是则把之前保存到成员变量里的值再恢复给手势代理
//    if (viewController == self.childViewControllers[0]) {self.interactivePopGestureRecognizer.delegate = _gestureDelegate;
//    }
//}


//重写pushView
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 隐藏tabar
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    // 让手势代理失效从而可以恢复滑动返回功能
    self.interactivePopGestureRecognizer.delegate = nil;
}
@end
