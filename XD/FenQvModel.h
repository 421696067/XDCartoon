//
//  FenQvModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FenQvModel : NSObject
@end

@interface FenQvZu : NSObject
proArr(children);
proStr(name);
@end

@interface FenQvOne : NSObject
proStr(_id);
proStr(icon);
proStr(name);
@end

@interface FenQvManger : NSObject
+(NSArray *)arrWithDict:(NSDictionary *)dict;
@end