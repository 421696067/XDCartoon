//
//  TuiJianFLModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/10.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuiJianFLModel : NSObject
@end

@interface EverZu : NSObject
proStr(_id);
proStr(icon);
proStr(name);
proArr(eps);
@end

@interface EverOne : NSObject
proStr(_id);//需要传出去的变量
proStr(title);
proStr(status);
proStr(playCount);//播放次数
proStr(url);//需要自己设置的属性
@end

@interface TuiJIanFlManger : NSObject
+(NSArray *)arrWithArr:(NSArray *)arr;

@end