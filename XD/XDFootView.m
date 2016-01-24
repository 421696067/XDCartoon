//
//  XDFootView.m
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "XDFootView.h"

@implementation XDFootView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        UILabel * label=[[UILabel alloc] initWithFrame:frame];
        label.text = @"炫动卡通";
        label.textColor=[UIColor blackColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont fontWithName:@"Helvetica" size:20];
        [self addSubview:label];
    }
    return self;
}

@end
