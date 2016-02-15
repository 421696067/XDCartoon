//
//  FenQBModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/29.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FenQBModel.h"

@implementation FenQBModel
@end

@implementation FenQBAD

@end

@implementation FenQBHot

@end

@implementation FenQBNews

@end

@implementation FenQBHotManger
+(NSArray *)arrWithArr:(NSArray *)arr
{
    NSMutableArray * mArr=[NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSDictionary *dict , NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<4) {
            FenQBHot * hot =[FenQBHot yy_modelWithJSON:dict];
            hot.url=dict[@"image"][@"url"];
            [mArr addObject:hot];
        }
    }];
    return mArr;
}

@end
