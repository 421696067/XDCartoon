//
//  SortModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortModel : NSObject
proStr(_id);
proStr(animeCount);
proStr(name);
proStr(url);
@end

@interface SortManger : NSObject
+(NSMutableArray *)arrWithArr:(NSArray *)arr;
@end