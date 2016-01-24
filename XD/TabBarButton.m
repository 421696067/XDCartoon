//
//  TabBarButton.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TabBarButton.h"
#define MyTabBarButtonImageRatio 0.65
@implementation TabBarButton
- (void)setTitle:(NSString *)title NormalImage:(NSString *)tabBarNormal selImage:(NSString *)tabBarSel
{
    [self setImage:[UIImage imageNamed:tabBarNormal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:tabBarSel] forState:UIControlStateSelected];
    [self setTitle:title forState:UIControlStateNormal];
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置文字的字体
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    // 选中时文字的颜色
    UIColor *selColor = [UIColor orangeColor];
    // 正常时候文字颜色
    UIColor *nolColor = [UIColor colorWithHexString:@"6e6e6e"];
    [self setTitleColor:selColor forState:UIControlStateSelected];
    [self setTitleColor:nolColor forState:UIControlStateNormal];
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * MyTabBarButtonImageRatio;
    return CGRectMake(0, 5, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * MyTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

@end
