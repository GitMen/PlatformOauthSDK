/**
 * 人人网api写入的调用类
 */

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface RenRenWriteMessageApi : NSObject

/**
 用户发表点评
 */
+ (void)commentStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)sId statusOwnerId:(NSString *)owerId content:(NSString *)content successed:(void(^)(NSDictionary *comment))success fail:(void(^)())fail;

/**
 分享人人网外部资源，例如：视频、图片等
 */
+ (void)shareToRenRenWithAccessToken:(NSString *)accessToken shareContent:(NSString *)content shareUrl:(NSString *)url  successed:(void(^)())success fail:(void(^)())fail;

/**
 赞人人内部资源，相册、照片、日志、分享、视频等。
 */
+ (void)likeFeedWithAccessToken:(NSString *)accessToken statusId:(NSString *)sId statusOwnerId:(NSString *)owerId successed:(void(^)())success fail:(void(^)())fail;

/**
 取消对站内资源的赞。
 */
+ (void)cancelLikeFeedWithAccessToken:(NSString *)accessToken statusId:(NSString *)sId statusOwnerId:(NSString *)owerId successed:(void(^)())success fail:(void(^)())fail;

/**
 发送自定义新鲜事
 targetUrl(新鲜事标题和图片指向的链接，此字段不能为空)
 */
+ (void)sendFeedWithAccessToken:(NSString *)accessToken message:(NSString *)message title:(NSString *)title imageUrl:(NSString *)url description:(NSString *)desc subtitle:(NSString *)subtitle targetUrl:(NSString *)tUrl successed:(void(^)(NSDictionary *newFeed))success fail:(void(^)())fail;

/**
 上传本地照片
 */
+ (void)uploadImageWithAccessToken:(NSString *)accessToken imageFielPath:(NSString *)imagePath successed:(void(^)(NSString *imageUrl))success fail:(void(^)())fail;

@end
