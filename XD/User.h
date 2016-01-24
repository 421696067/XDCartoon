//
//  User.h
//  XD
//
//  Created by 李攀祥 on 16/1/13.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
proStr(_id);//用户id
proStr(birthday);//生日
proStr(nickname);//名字
proStr(intro);//签名
proStr(epCount);//视频数
proStr(audioCount);//语音数
proStr(commentCount);//吐槽评论数
proStr(gender);//专辑数
proStr(picCount);//图片数
proStr(topicCount);//帖子数

proStr(coinCount);
proStr(followingBoardCount);
proStr(boardCount);
proStr(isAdmin);//
proStr(followerCount);//粉丝数
proStr(followingCount);//关注数
proStr(rongCloudActivated);//融云 是否活动
proStr(strangerChatEnabled);//是否能与陌生人聊天
proStr(blocked);//是否封锁

proDic(avatar);//头像
proDic(background);//背景

@end
