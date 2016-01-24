//
//  TuiJianHeadView.h
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AdSelectBlock)(NSString *,NSString*);//广告--点击回调
typedef void (^AllXinFan)(void);//全部新番点击回调（调到第一个新番界面）
typedef void (^BjButBlock)(NSString * );//本季新番scollerview的but的点击
@interface TuiJianHeadView : UIView
@property (nonatomic,assign)float viewHeight;
@property (nonatomic,strong)AdSelectBlock block;
@property (nonatomic,strong)AllXinFan allXF;
@property (nonatomic,strong)BjButBlock bjBlock;
@end
