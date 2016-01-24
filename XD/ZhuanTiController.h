//
//  ZhuanTiController.h
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuTiZu;
typedef void (^SectionHeadBlock)(ZhuTiZu *);//sectionhead 共8部
typedef void (^CellDidBlock)(NSString *);//专题界面cell的点击事件
@interface ZhuanTiController : UIViewController
@property (nonatomic,strong)SectionHeadBlock sectionHeadBlock;
@property (nonatomic,strong)CellDidBlock didCellBlock;
@end
