//
//  TuiJianModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/9.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TuiJianModel.h"

@implementation TuiJianModel
@end


@implementation TuiJianADModel
@end

@implementation TuiJianadManger
+(NSArray *)arrJsonWithData:(NSData *)data
{
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray * arr=dict[@"recommend_banner"];
    NSMutableArray * mArr=[[NSMutableArray alloc] init];
    for (NSDictionary * dict1 in arr)
    {
        TuiJianADModel * model=[TuiJianADModel  yy_modelWithJSON:dict1] ;
        [mArr addObject:model];
    }
    return mArr;
}
@end

@implementation FanZuAdManger

+(NSArray *)arrWithDict:(NSDictionary *)dict
{
    NSArray * arr=dict[@"featured_banner"];
    NSMutableArray * mArr=[[NSMutableArray alloc] init];
    for (NSDictionary * dict1 in arr)
    {
        TuiJianADModel * model=[TuiJianADModel  yy_modelWithJSON:dict1] ;
        [mArr addObject:model];
    }
    return mArr;
}
@end

@implementation tuijianBJModel
@end


@implementation TuiJianBJManger
+(NSArray *)arrayWithArr:(NSArray *)arr
{
    NSMutableArray * mArr=[[NSMutableArray alloc] init];
    for (NSDictionary * dict in arr)
    {
        NSDictionary * dict1=dict[@"anime"];
        tuijianBJModel * model =[tuijianBJModel yy_modelWithJSON:dict1];

        model.url=dict1[@"image"][@"url"];
        
        [mArr addObject:model];
    }
    return mArr;
}
@end
