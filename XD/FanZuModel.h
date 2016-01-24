//
//  FanZuModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/11.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FanZuModel : NSObject
@end

@interface fanzuFlModel : NSObject
proStr(_id);
proStr(intro);//详情
proStr(url);
proStr(name);
proStr(onairRuleDescription);//每周一更新
proStr(score);//评分
proStr(type);//类型
proArr(categoryNames);//标签
proArr(seiyuNames);//声优
proStr(onairEpNumber);//更新至多少话
@property(nonatomic,assign)float height;


@end



@interface fanzuFlManger : NSObject
+(NSArray *)arrwithArr:(NSArray *)arr;
@end