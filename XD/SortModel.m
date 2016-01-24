//
//  SortModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.

#import "SortModel.h"

@implementation SortModel

@end

@implementation SortManger
+(NSMutableArray *)arrWithArr:(NSArray *)arr
{
    NSMutableArray * mArr=[NSMutableArray array];
   [arr enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
       SortModel * model=[SortModel yy_modelWithJSON:dict];
       model.url=dict[@"image"][@"url"];
       [mArr addObject:model];
   }];
 return mArr;
}
@end