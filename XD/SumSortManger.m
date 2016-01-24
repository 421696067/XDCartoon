//
//  SumSortManger.m
//  XD
//
//  Created by 李攀祥 on 16/1/20.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SumSortManger.h"
#import "AnimaDetailModel.h"
@implementation SumSortManger
+(NSMutableArray *)arrWithArr:(NSArray *)arr
{
    NSMutableArray  * mArr=[NSMutableArray array ];
   [arr enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
      NSDictionary * subDict = dict[@"item"];
      AnimaDetailModel * model = [AnimaDetailModel yy_modelWithJSON:subDict];
      model.url = subDict[@"image"][@"url"];
      model.intro = dict[@"intro"];//替换intro
      [mArr addObject:model];
   }];
    return mArr;
}
@end
