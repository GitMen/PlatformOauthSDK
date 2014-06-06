
/**
 * 有关新浪微博api读取的调用类
 */
#import <Foundation/Foundation.h>

@interface SinaWbReadMessageApi : NSObject


/**
 获取最新公共微博信息
 */
+ (void)publicStatusInfoWithAccessToken:(NSString *)accessToken count:(NSString *)count accessed:(void(^)(NSArray *status))access fail:(void(^)())fail;


/**
 获取用户信息
 */
+ (void)userInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid accessed:(void(^)(NSDictionary *userInfo))access fail:(void(^)())fail;


/**
 获取用户发布的微博 , feature为过滤类型，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 */
+ (void)userSendStatusWithAccess_token:(NSString *)accessToken uid:(NSString *)uid sinceId:(NSString *)sinceID maxId:(NSString *)maxId page:(int)page count:(int)count feature:(int)feature accessed:(void(^)(NSArray *statuses))access fail:(void(^)())fail;


/**
 获取某条微博的评论列
 */
+ (void)statusCommentListWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void(^)(NSArray *comments))access fail:(void(^)())fail;


/**
 获取@我的评论
 */
+ (void)touchMyCommentWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void(^)(NSArray *comments))access fail:(void(^)())fail;


/**
 获取用户的关注列表 
 cursor:返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0  
 返回参数说明：nextCursor(如果要看下一页则在cursor中传入)，previousCursor（如果要看上一页则传入）。
 */
+ (void)userAttentionListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid count:(int)count cursor:(int)cursor accessed:(void(^)(NSArray *attentions,long nextCursor,long previousCursor))access fail:(void(^)())fail;


/**
 获取相互关注列表
 */
+ (void)togetherAttentionListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid count:(int)count page:(int)page accessed:(void(^)(NSArray *attentions))access fail:(void(^)())fail;;


/**
 获取用户粉丝列表
 */
+ (void)fansListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid count:(int)count cursor:(int)cursor accessed:(void(^)(NSArray *attentions,long nextCursor,long previousCursor))access fail:(void(^)())fail;


/**
 获取用户收藏列表
 */
+ (void)userFavoriteListWithAccessToken:(NSString *)accessToken page:(int)page count:(int)count accessed:(void(^)(NSArray *collects))access fail:(void(^)())fail;


/**
 获取单条收藏信息
 */
+ (void)favoriteInfoWithAccessToken:(NSString *)accessToken collectId:(NSString *)collectId accessed:(void(^)(NSDictionary *collect))access fail:(void(^)())fail;


/**
 获取@我的微博
 */
+ (void)touchUserStatusListWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void(^)(NSArray *status))access fail:(void(^)())fail;


/**
 获取某条微博详情
 */
+ (void)checkStatusInfoWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId accessed:(void(^)(NSDictionary *statuInfo))access fail:(void(^)())fail;

/**
 获取我发出的评论
 */
+ (void)commentByMeWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void(^)(NSArray *comments,int nextCursor,int previousCursor))access fail:(void(^)())fail;

/**
 我收到的评论列表
 */
+ (void)commentToMeWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void(^)(NSArray *comments,int nextCursor,int previousCursor))access fail:(void(^)())fail;
@end
