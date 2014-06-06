
/**
 * 有关新浪微博api数据写入的调用类
 */

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface SinaWbWriteMessageApi : NSObject

/**
 发布一条新微博
 参数说明：内容超过140个汉子     经纬度如果不填写默认为0
 */
+ (void)sendStatusMessageWithAccessToken:(NSString *)accessToken statusContent:(NSString *)content latitude:(double)latitude longitude:(double)longitude successed:(void(^)(NSDictionary *newStatus))success fail:(void(^)())fail;

/**
 发布一条带图片的新微博
 参数说明：内容超过140个汉子     经纬度如果不填写默认为0
 */
+ (void)sendStatusImageMessageWithAccessToken:(NSString *)accessToken statusContent:(NSString *)content imageFilePath:(NSString *)filePath latitude:(double)latitude longitude:(double)longitude successed:(void(^)(NSDictionary *newStatus))success fail:(void(^)())fail;

/**
 评论一条微博
 */
+ (void)commentStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId commentText:(NSString *)text successed:(void(^)(NSDictionary *newComment))success fail:(void(^)())fail;

/**
 删除一条微博
 */
+ (void)deleteStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId successed:(void(^)(NSDictionary *newComment))success fail:(void(^)())fail;

/**
 删除一条评论
 */
+ (void)deleteCommentWithAccessToken:(NSString *)accessToken commentId:(NSString *)commentId successed:(void(^)(NSDictionary *comment))success fail:(void(^)())fail;

/**
 批量删除一条评论
 参数 ids最多20个
 */
+ (void)deleteBatchCommentWithAccessToken:(NSString *)accessToken commentIds:(NSArray *)Ids successed:(void(^)(NSArray *comments))success fail:(void(^)())fail;

/**
 回复一条评论
 */
+ (void)replyCommentWithAccessToken:(NSString *)accessToken statudId:(NSString *)sid commentId:(NSString *)cid  replyText:(NSString *) text successed:(void(^)(NSDictionary *replyComment))success fail:(void(^)())fail;

/**
 取消关注一个用户
 */
+ (void)cancelAttentionWithAccessToken:(NSString *)accessToken uId:(NSString *)uid  successed:(void(^)(NSDictionary *userInfo))success fail:(void(^)())fail;

/**
 移除当前登录用户的粉丝（高级接口，需要新浪微博的高级授权）
 */
+ (void)removeFansWithAccessToken:(NSString *)accessToken uId:(NSString *)uid  successed:(void(^)(NSDictionary *userInfo))success fail:(void(^)())fail;

/**
 添加收藏
 */
+ (void)addFavoriteAccessToken:(NSString *)accessToken statusId:(NSString *)statusId  successed:(void(^)(NSDictionary *favorite))success fail:(void(^)())fail;

/**
 删除收藏
 */
+ (void)deleteFavoriteWithAccessToken:(NSString *)accessToken favorite:(NSString *)favorite  successed:(void(^)(NSDictionary *favorite))success fail:(void(^)())fail;

/**
 批量删除收藏
 */
+ (void)deleteBatchFavoriteWithAccessToken:(NSString *)accessToken favoriteIds:(NSArray *)ids  successed:(void(^)(NSDictionary *favorite))success fail:(void(^)())fail;

/**
 指定一个图片URL地址抓取后上传并同时发布一条新微博
 */
+ (void)sendStatusImageUrlWithAccessToken:(NSString *)accessToken content:(NSString *)content imageUrl:(NSString *)iUrl successed:(void(^)(NSDictionary *status))success fail:(void(^)())fail;
@end













