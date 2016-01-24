//
//  FanzuheadView.h
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FenLeiButBlock)();//番组分类按钮
typedef void (^XFTimeBlock)();//新番时间表按钮
typedef void (^AdSelectBlock)(NSString *,NSString*);//广告页面
@interface FanzuheadView : UIView
@property (nonatomic,strong)AdSelectBlock block;
@property (nonatomic,strong)FenLeiButBlock fenLeiButBlock;
@property (nonatomic,strong)XFTimeBlock xfTimeBlock;
@end
