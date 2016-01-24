//
//  FanZuModel.m
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "FanZuModel.h"

@implementation FanZuModel

@end
@implementation fanzuFlModel
@end

@implementation fanzuFlManger
+(NSArray *)arrwithArr:(NSArray *)arr
{
    NSMutableArray * mArr=[[NSMutableArray  alloc] init];
    for (NSDictionary * dict  in arr) {
        NSDictionary * dict1=dict[@"anime"];
        fanzuFlModel * model=[fanzuFlModel yy_modelWithJSON:dict1];
        model.url=dict1[@"image"][@"url"];
        //FIXME: 瀑布流cell的高度的最重要的一句b
        model.height=(220+arc4random()%40)*View_Radio;
        [mArr addObject:model];
    }
    return mArr;
}
@end