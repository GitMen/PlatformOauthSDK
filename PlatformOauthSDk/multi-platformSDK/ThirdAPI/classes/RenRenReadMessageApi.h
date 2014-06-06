/**
 * 人人网api读取的调用类
 */

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"


@interface RenRenReadMessageApi : NSObject

/**
 通过经纬度获取新鲜事
 */
+ (void)statusByLocationWithAccessToken:(NSString *)accessToken page:(int)page count:(int)count radius:(int)radius  longitude:(double)longitude latitude:(double)latitude feedType:(LocationFeedType)feedType successed:(void(^)(NSArray *statuses))success fail:(void(^)())fail;

/**
 根据经纬度获取地点
 */
+ (void)locationSiteWithAccessToken:(NSString *)accessToken longitude:(double)longitude latitude:(double)latitude successed:(void(^)(NSDictionary *location))success fail:(void(^)())fail;

/**
 以分页的方式获取某个用户的分享列表
 */
+ (void)shareListWithAccessToken:(NSString *)accessToken ownerId:(NSString *)ownerId page:(int)page count:(int)count successed:(void(^)(NSDictionary *shares))success fail:(void(^)())fail;

/**
 获取站内资源被赞的次数。
 */
+ (void)statusFavourCountWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId  likeType:(LikeUGCType)type successed:(void(^)(int favourCount))success fail:(void(^)())fail;

/**
 以分页的方式获取某个UGC的评论列表
 */
+ (void)statusCommentsWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId statusOwnerId:(NSString *)statusOwnerId page:(int)page count:(int)count successed:(void(^)(NSArray *comments))success fail:(void(^)())fail;

/**
 根据新鲜事类型获取新鲜事列表
 uid为好友id，如果查看自己的则不填
 */
+ (void)publicFeedListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid feedType:(StatusType)type  page:(int)page count:(int)count successed:(void(^)(NSArray *feeds))success fail:(void(^)())fail;

/**
 获取用户信息
 */
+ (void)userInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid successed:(void(^)(NSDictionary *userInfo))success fail:(void(^)())fail;
@end


