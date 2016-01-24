//
//  TuiJianFLModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/10.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TuiJianFLModel.h"

@implementation TuiJianFLModel
@end


@implementation EverZu
@end

@implementation EverOne
@end

@implementation TuiJIanFlManger
+(NSArray *)arrWithArr:(NSArray *)arr
{
    NSMutableArray * GArr=[[NSMutableArray alloc] init];
    for (NSDictionary * dict in arr)
    {
        NSMutableArray * OArr=[[NSMutableArray alloc] init];
        EverZu * group=[EverZu yy_modelWithJSON:dict];
        for (NSDictionary * dict1 in group.eps)
        {
            EverOne * one=[EverOne yy_modelWithJSON:dict1];
            one.url=dict1[@"image"][@"url"];
            [OArr addObject:one];
        }
        //FIXME: 最重要的 绑定数组和eps的一句话
        group.eps=OArr;
       [GArr addObject:group];
    }
    return GArr;
}
@end



