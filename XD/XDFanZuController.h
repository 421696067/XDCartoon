//
//  XDFanZuController.h
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import <UIKit/UIKit.h>
typedef void (^AdSelectBlock)(NSString *,NSString*);//头部广告业
typedef void (^CellButBlock)(NSString *);//底部每个cell的点击事件
typedef void (^FenLeiButBlock)();//番组分类按钮
typedef void (^XFTimeBlock)();//新番时间表按钮

@interface XDFanZuController : UIViewController
@property (nonatomic,strong)AdSelectBlock block;
@property (nonatomic,strong)CellButBlock cellBlock;
@property (nonatomic,strong)FenLeiButBlock fenLeiButBlock;
@property (nonatomic,strong)XFTimeBlock xfTimeBlock;

@end
