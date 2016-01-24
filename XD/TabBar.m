//
//  TabBar.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TabBar.h"
@implementation TabBar
-(void)addTabBarItemWithTitle:(NSString *)title NormalImage:(NSString *)tabBarNormal selImage:(NSString *)tabBarSel
{
    TabBarButton *tabBarButton = [TabBarButton buttonWithType:UIButtonTypeCustom];
    [tabBarButton setTitle:title NormalImage:tabBarNormal selImage:tabBarSel];
    [tabBarButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarButton];
}

// 监听按钮点击事件
- (void)buttonDidClick:(TabBarButton *)button
{
    //检测代理中是否有这个方法:  安全验证
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickFrom:to:)])
    {
        [self.delegate tabBar:self didClickFrom:self.selectedBtn.tag to:button.tag-100];
        self.selectedBtn.selected = NO;
        self.selectedBtn = button;
        self.selectedBtn.selected = YES;
    }
}

//这个是系统方法（重写自动调用）（添加子视图）
- (void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    CGFloat width = self.bounds.size.width / count;
    CGFloat height = self.bounds.size.height;
    for (int i = 0; i < count; ++i) {
        CGFloat x = i * width;
        CGFloat y = 0;
        // 让第一个btn默认选中
        TabBarButton *btn = self.subviews[i];
        btn.tag =100+ i;
        if (btn.tag  == 100) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
        btn.frame = CGRectMake(x, y, width, height);
    }
}

@end
