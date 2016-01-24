//
//  ZhuTiModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ZhuTiModel.h"

@implementation ZhuTiModel
@end

@implementation ZhuTiOne
@end

@implementation ZhuTiZu
@end

@implementation ZhuTiManger
+(NSMutableArray *)arrWithArr:(NSArray *)arr
{
    NSMutableArray * mArr=[NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
        ZhuTiZu * zu=[ZhuTiZu yy_modelWithJSON:dict];
        zu.url=dict[@"image"][@"url"];
        zu.anime=dict[@"itemCount"][@"anime"];
        
         NSMutableArray * mSubArr=[NSMutableArray array];
        [zu.items enumerateObjectsUsingBlock:^(NSDictionary * subDict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * ssbDict=subDict[@"item"];
            ZhuTiOne * one =[ZhuTiOne yy_modelWithJSON:ssbDict];
            one.url=ssbDict[@"image"][@"url"];
            [mSubArr addObject:one];
            
            //当加入2（0。1。2）之后就停止就要3个
            if (idx>=2){
                *stop = YES ;
            }
            
        }];
        zu.items =mSubArr;
        [mArr addObject:zu];
    }];
    return mArr;
}
@end