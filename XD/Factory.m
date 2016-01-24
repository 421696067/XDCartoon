//
//  Factory.m
//  XD
//
//  Created by 李攀祥 on 16/1/20.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "Factory.h"
@implementation Factory
+(UILabel *)creatLabelFont:(float)font Alignment:(NSTextAlignment)alignment textColor:(UIColor *) color  bgColor:(UIColor *)bgColor autoLine:(BOOL)autoline
{
    UILabel * label =[[UILabel  alloc] init];
    label.font=[UIFont systemFontOfSize:font];
    label.textAlignment =alignment;
    label.textColor = color;
    label.backgroundColor=bgColor;
    if (autoline)
    {
        label.numberOfLines=0;
    }
    return label;
}

+(UIImageView *)creatImageViewRadius:(float)radius;
{
    UIImageView * imageView=[[UIImageView alloc] init];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius = radius;
    return imageView;
}

@end

