//
//  KaixinWriteMessageApi.h
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-6-3.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface KaixinWriteMessageApi : NSObject

/**
 （暂未实现，服务器内部错误）
 发表一条记录(可带图)
 filePath 和 imageUrl 2选1  优先imageUrl , 如果没有图片则传空字符串
 */
+ (void)sendImageStatusWithAccessToken:(NSString *)accessToken content:(NSString *)content imageFilePath:(NSString *)filePath imageUrl:(NSString *)iUrl successed:(void(^)(NSDictionary *newStatus))success fail:(void(^)())fail;

/**
 删除记录
 */
+ (void)deleteStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)sid successed:(void(^)())success fail:(void(^)())fail;

/**
 添加对某一资源的评论
 */
+ (void)commentStatusWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid content:(NSString *)content successed:(void(^)(NSString *commentId))success fail:(void(^)())fail;

/**
 对某一资源的某条评论进行回复
 statusOwnerId(被评论资源所有者的UID)
 statusId(被评论资源的ID)
 commentOwnerId(评论所有者的UID)
 commentId(评论的ID)
 */
+ (void)replyCommentWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid commentOwnerId:(NSString *)coid commentId:(NSString *)cid content:(NSString *)content successed:(void(^)(NSString *replyId))success fail:(void(^)())fail;

/**
 删除评论
 */
+ (void)deleteCommentWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid commentId:(NSString *)cid successed:(void(^)(NSString *replyId))success fail:(void(^)())fail;


/**
 表达对某一资源的赞
 */
+ (void)likeStatusWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid successed:(void(^)())success fail:(void(^)())fail;

/**
 取消对某一资源的赞
 */
+ (void)cancelLikeStatusWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid successed:(void(^)())success fail:(void(^)())fail;



@end
