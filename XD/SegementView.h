//
//  SegementView.h
//  XD
//
//  Created by 李攀祥 on 16/1/7.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyBlock)(int);
typedef void (^SliderBlock)(NSInteger);
@interface SegementView : UIView
@property (nonatomic,strong)MyBlock selectBlock;
@property (nonatomic,strong)SliderBlock sliderBlock;
-(id)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr;
@end
