//
//  MyLayout.h
//  TestWaterFlow
//
//  Created by gaokunpeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyLayoutDelegate <NSObject>

//返回有多少列
- (int)columnsInCollectionView;

//cell的高度
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MyLayout : UICollectionViewLayout

/*
 @param sectionInsets:上下左右的间距
 @param itemSpace:cell的横向间距
 @param lineSpace:cell的纵向间距
 */
- (instancetype)initWithSectionInsets:(UIEdgeInsets)sectionInsets itemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace;

//代理属性
@property (nonatomic,weak)id<MyLayoutDelegate> delegate;


@end
