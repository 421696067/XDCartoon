//
//  AllHotModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/13.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "AllHotModel.h"
#import "User.h"
@implementation AllHotModel

@end

@implementation MADDetailModel
@end

@implementation MADDetailManger
+(NSArray * )arrWithDict:(NSDictionary *)dict;
{
    NSMutableArray * mArr=[[NSMutableArray alloc] init];
    NSArray  * arr=dict[@"result"][@"eps"];
    for (NSDictionary * subDict in arr) {
        MADDetailModel*model=[MADDetailModel yy_modelWithJSON:subDict];
    //User * user = [User yy_modelWithJSON:model.user];
        model.url=subDict[@"image"][@"url"];
        [mArr addObject:model];
    }
    return mArr;
}
@end
