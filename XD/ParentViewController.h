//
//  ParentViewController.h
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentViewController : UIViewController<UIGestureRecognizerDelegate>
/*!
 * 动画详情界面的 ——id
 * 在重写set方法 跳转界面到动画详情界面
 */
@property (nonatomic,strong)NSString * animeDetailId;
/*!
 * 设置控制器的Push操作
 */
-(void)pushVc:(UIViewController *)vc;
/*!
 * 设置背景需不需要 透明的背景
 */
@property (nonatomic,assign) BOOL isBckView;

/*!
 * 设置后退按钮
 */
-(void)setHtBut;
/*!
 *设置左右item（image）
 */
-(void)setLeft:(BOOL)isLeft ImageName:(NSString * )imageName target:(id)target select:(SEL)select;

/*!
 * 设置左右item （title+image）
 */
-(void)setImageAndTitleLeft:(BOOL)isLeft ImageName:(NSString *)imageName andTitle:(NSString *)title target:(id)target select:(SEL)select;

/*!
 * 设置导航栏的标题视图（title）
 */
-(void)setTitleView:(NSString *)title textColor:(UIColor *)color;

@end
