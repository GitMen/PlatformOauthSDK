/**
 * 有关腾讯微博api读取的调用类
 */

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface TencentWbReadMessageApi : NSObject

/**
 我的粉丝列表 
 参数说明：format(返回数据的格式（json或xml）) 
           reqnum(请求个数(1-30)) 
           startindex(起始位置（第一页：填0，继续向下翻页：填上次请求返回的nextstartpos）) 
           sex(男，女，默认)
 */
+ (void)fansListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex sex:(SexType)sexType successed:(void(^)(NSArray *fans))success fail:(void(^)())fail;

/**
  获取用户的粉丝列表 fopenid为其他用户
 */
+ (void)userFansListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId fopenId:(NSString *)fopenId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex sex:(SexType)sexType successed:(void(^)(NSArray *fans))success fail:(void(^)())fail;


/**
 获取其他用户的特别收听列表 fopenid为其他用户
 */
+ (void)userSpeciallistWithAccessToken:(NSString *)accessToken openId:(NSString *)openId fopenId:(NSString *)fopenId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex  successed:(void(^)(NSArray *specials))success fail:(void(^)())fail;

/**
 获取当前用户的特别收听列表
 */
+ (void)mySpeciallistWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex  successed:(void(^)(NSArray *specials))success fail:(void(^)())fail;

/**
 获取用户的双向收听列表
 */

/**
 获取广播大厅的最新微博 
 参数说明：pos(记录的起始位置（第一次请求时填0，继续请求时填上次请求返回的pos）)  
           reqnum(每次请求记录的条数（1-100条）)
 */
+ (void)publicStatusListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pos:(int)pos reqnum:(int)reqnum successed:(void(^)(NSArray *status,int pos))success fail:(void(^)())fail;

/**   
  ( 暂不可用 )获取单条微博的转发或评论列表
  参数说明: listType(获取列表类型，暂支持评论和转发)
            rootid（需要获取的微博id）
            pageflag(分页标识)
            pagetime(本页起始时间，与pageflag、twitterid共同使用，实现翻页功能（第一页：填0，向上翻页：填上一次请求返回的第一条记录时间，向下翻页：填上一次请求返回的最后一条记录时间）)  
            reqnum(每次请求记录的条数（1-100条）,默认为20条)
            twitterid(微博id，与pageflag、pagetime共同使用，实现翻页功能（第1页填0，继续向下翻页，填上一次请求返回的最后一条记录id）)
 */
+ (void)forwordOrCommentListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format listType:(ListTpe)type rootid:(NSString *)rootid pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum twitterid:(NSString *)twitterid successed:(void(^)(NSArray *resultList))success fail:(void(^)())fail;

/**
 根据微博ID获取一条微博数据
 */
+ (void)statusInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format statusId:(NSString *)statusId successed:(void(^)(NSDictionary *statusInfo))success fail:(void(^)())fail;

/**
 根据链接地址获取视频信息
 */
+ (void)analysisVideoInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format videoUrl:(NSString *)url successed:(void(^)(NSDictionary *videoInfo))success fail:(void(^)())fail;

/**
 ( 暂不可用 )收藏的微博列表
 参数说明：lastid（翻页用，第一页时：填0；继续向上翻页：填上一次请求返回的第一条记录id；继续向下翻页：填上一次请求返回的最后一条记录id）
 */
+ (void)favoritesListAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum lastid:(NSString *)lastid successed:(void(^)(NSArray *resultList))success fail:(void(^)())fail;

/**
 获取私信首页会话列表
 */
+ (void)privateMessageGroupAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum lastid:(NSString *)lastid successed:(void(^)(NSArray *messageGroups))success fail:(void(^)())fail;

/**
 ( 暂不可用 )获取与某人的私信会话列表
 */
+ (void)privateMessageInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId otherOpenId:(NSString *)fopenId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum lastid:(NSString *)lastid successed:(void(^)(NSArray *messages))success fail:(void(^)())fail;

/**
 获取身边最新的微博
 参数说明： longitude(经度，例如：22.541321)
            latitude(纬度，例如：13.935558)
            pageinfo(翻页参数，由上次请求返回（第一次请求时请填空）)
            pagesize(请求的每页个数（1-50），建议25)
 */
+ (void)statusLBSWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format longitude:(float)longitude latitude:(float)latitude pageinfo:(NSString *)pageinfo pagesize:(int)pagesize successed:(void(^)(NSArray *status))success fail:(void(^)())fail;

/**
 获取当前用户发表的最新微博
 pageflag:(分页标识)
 pagetime:(本页起始时间（第一页：填0，向上翻页：填上一次请求返回的第一条记录时间，向下翻页：填上一次请求返回的最后一条记录时间）)
 reqnum:(每次请求记录的条数（1-100条）)
 lastid:(和pagetime配合使用（第一页：填0，向上翻页：填上一次请求返回的第一条记录id，向下翻页：填上一次请求返回的最后一条记录id）)
 statusType(微博类型)
  */
+ (void)userNewStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)count lastid:(NSString *)lastid statusType:(StatusType)stype successed:(void(^)(NSArray *status))success fail:(void(^)())fail;


/**
 查询某人是否赞过某条微博(鉴权失败)
 */
+ (void)userIsLikeStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format statusId:(NSString *)sid fopenid:(NSString *)fid successed:(void(^)(NSArray *status))success fail:(void(^)())fail;

/**
 获取身边最新的微博
 */
+ (void)nearbyStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format longitude:(double)lon latitude:(double)lat pageinfo:(int)page pagesize:(int)count successed:(void(^)(NSArray *status))success fail:(void(^)())fail;

@end


