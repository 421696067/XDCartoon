//
//  ZhuTiSectionHead.h
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuTiZu;
typedef void (^SectionHeadBlock)(ZhuTiZu *);
@interface ZhuTiSectionHead : UICollectionReusableView
@property (nonatomic,strong)ZhuTiZu * model;
@property (nonatomic,strong)SectionHeadBlock block;
@end
