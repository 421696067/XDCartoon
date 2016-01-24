//
//  ZhuTiModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/19.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhuTiModel : NSObject
@end

@interface ZhuTiOne : NSObject
proStr(_id);
proStr(url);
proStr(onairEpNumber);//更新至
proStr(totalEpCount);//总共
proStr(name);//名字
@end

@interface ZhuTiZu : NSObject
proStr(_id);
proStr(epPlayCount);
proStr(url);
proStr(intro);
proStr(anime);
proStr(title);
proArr(items);
@end

@interface ZhuTiManger : NSObject
+(NSMutableArray *)arrWithArr:(NSArray *)arr;
@end