//
//  XDTuiJianViewController.h
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AdSelectBlock)(NSString *,NSString*);//广告--点击回调
typedef void (^AllXinFan)(void);//全部新番点击回调（调到第一个新番界面）
typedef void (^BjButBlock)(NSString *);//本季新番scollerview的but的点击
typedef void(^CellBlock)(NSString *);//点击下面的cell
typedef  void (^FootButBlock)(NSString *);//点击Section尾部视图的点击事件
@interface XDTuiJianViewController : UIViewController
@property (nonatomic,strong)AdSelectBlock block;
@property (nonatomic,strong)AllXinFan allXF;
@property (nonatomic,strong)BjButBlock bjButBlock;
@property (nonatomic,strong)CellBlock cellBlock;
@property (nonatomic,strong)FootButBlock  footBLock;
@end
