//
//  FenQvModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FenQvModel.h"

@implementation FenQvModel
@end

@implementation FenQvZu
@end

@implementation FenQvOne
@end

@implementation FenQvManger
+(NSArray *)arrWithDict:(NSDictionary *)dict
{
    NSMutableArray * mArr=[[NSMutableArray alloc] init];
    NSArray * arr=dict[@"result"][@"categories"];
    for (NSDictionary * subDict in arr)
    {
        FenQvZu * zu=[FenQvZu yy_modelWithJSON:subDict];
        NSMutableArray * subArr=[[NSMutableArray alloc] init];
        for (NSDictionary * subDict1 in zu.children)
        {
            FenQvOne * one=[FenQvOne yy_modelWithJSON:subDict1];
            [subArr addObject:one];
        }
        zu.children=subArr;
        [mArr addObject:zu];
    }
    return mArr;
}
@end