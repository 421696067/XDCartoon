//
//  FenQBHotView.h
//  XD
//
//  Created by 李攀祥 on 16/1/29.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FenQBModel.h"
typedef void (^DidbutBlock)(NSString *);
@interface FenQBHotView : UIView
@property (nonatomic,strong)FenQBHot* model;
@property (nonatomic,strong)  DidbutBlock block;
+(id)fenQBView;
@end
