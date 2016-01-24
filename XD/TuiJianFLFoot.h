//
//  TuiJianFLFoot.h
//  XD
//
//  Created by 李攀祥 on 16/1/10.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MoreButBlock)();
@interface TuiJianFLFoot : UICollectionReusableView
@property(nonatomic,strong)MoreButBlock block;
@end
