//
//  SumSortHead.h
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuTiZu;
typedef void (^JSHeightBlock)(float);
@interface SumSortHead : UIView
@property (nonatomic,strong)ZhuTiZu * model;

//!!!:block 必须在 实例化完毕之后使用
/*!!!:特别注意:如果要使用
 * 使用类中的block属性  就必须等到该类实例化 完毕后才能使用
 * 要不然就会出现重读释放的情况（僵尸断点） 所以要想使用block 就必须在实例化完毕后 调用
 * jSheight 这个方法  就是专门为了调用block建立的
 */
@property (nonatomic,strong)JSHeightBlock jsBlock;
-(void)jSheight;
@end
