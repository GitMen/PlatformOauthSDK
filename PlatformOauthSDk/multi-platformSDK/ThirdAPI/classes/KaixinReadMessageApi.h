/**
 * 有开心网api读取的调用类
 */


#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface KaixinReadMessageApi : NSObject

/**
 获取当前登录用户的资料
 */
+ (void)currentUserInfoWithAccessToken:(NSString *)accessToken successed:(void(^)(NSDictionary *userInfo))success fail:(void(^)())fail;

/**
 根据UID获取用户的详细资料
 */
+ (void)userDetailInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid successed:(void(^)(NSDictionary *userInfo))success fail:(void(^)())fail;

/**
 获取用户的记录列表
 */
+ (void)userStatusListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid start:(int)start num:(int)num category:(StatusType)type successed:(void(^)(NSArray *statuses))success fail:(void(^)())fail;

/**
 获取公共的记录列表
 */
+ (void)publicStatusListWithAccessToken:(NSString *)accessToken start:(int)start num:(int)num successed:(void(^)(NSArray *statuses))success fail:(void(^)())fail;

/**
 (暂未通过 oauth1.0错误提示)获取某一资源的所有评论
 */
+ (void)statusAllCommentsWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId uid:(NSString *)uid startIndex:(int)index num:(int)num successed:(void(^)(NSArray *comments))success fail:(void(^)())fail;

/**
 (暂未开通：授权问题)获取别人给我的评论
 */
+ (void)commentsToMeWithAccessToken:(NSString *)accessToken startIndex:(int)index num:(int)num successed:(void(^)(NSArray *comments))success fail:(void(^)())fail;

/**
 (暂未开通：授权问题)获取我发出的评论或者回复
 */
+ (void)commentOrReplyByMeAccessToken:(NSString *)accessToken startIndex:(int)index num:(int)num successed:(void(^)(NSArray *comments))success fail:(void(^)())fail;

/**
 获取某一资源的所有转发
 */
+ (void)statusAllForwardAccessToken:(NSString *)accessToken statusId:(NSString *)statusId uid:(NSString *)uid startIndex:(int)index num:(int)num successed:(void(^)(NSArray *forwards))success fail:(void(^)())fail;

/**
 获取对某一资源赞过的用户列表
 */
+ (void)statusUserLikeListWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId uid:(NSString *)uid startIndex:(int)index num:(int)num successed:(void(^)(NSArray *forwards))success fail:(void(^)())fail;
@end
