//
//  AllHotModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/13.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllHotModel : NSObject
@end

@interface MADDetailModel : NSObject
proStr(_id);
proStr(bulletCount);//弹幕数
proStr(commentCount);//评论数
proStr(duration);//时长
proStr(url);//图片 需要自己 赋值
proStr(insertedTime);//发布时间
proStr(intro);//详情
proStr(playCount);//播放次数
proStr(status);
proStr(title);//标题

proStr(t);//自制 t=1  搬运  t=2
proStr(coinCount);
proStr(isFromAudio);//是否是声音
proStr(isMusic);//是否是音乐
proStr(number);
proStr(voteCount);

proStr(userId);
proDic(user);
@end

@interface MADDetailManger : NSObject
+(NSArray * )arrWithDict:(NSDictionary *)dict;
@end
