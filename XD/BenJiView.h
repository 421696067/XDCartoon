//
//  BenJiView.h
//  XD
//
//  Created by 李攀祥 on 16/1/9.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuiJianModel.h"
typedef void (^ButClickBlock) (NSString *);
@interface BenJiView : UIView
@property (nonatomic,strong)ButClickBlock butBlock;
-(id)initWithFrame:(CGRect)frame  Model:(tuijianBJModel *)model;
@end
