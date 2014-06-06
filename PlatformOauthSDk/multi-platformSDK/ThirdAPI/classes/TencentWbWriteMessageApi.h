/**
 * 腾讯微博api写入的调用类
 */

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface TencentWbWriteMessageApi : NSObject

/**
 发表一条微博信息
 */
+ (void)sendStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip scuuessed:(void(^)(NSString *statusId))success fail:(void(^)())fail;

/**
 发表一条带图片的微博
 图片大小限制4M
 */
+ (void)sendImageStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip imageFilePath:(NSString *)pic scuuessed:(void(^)(NSString *statusId))success fail:(void(^)())fail;

/**
 用图片URL发表带图片的微博
 图片的URL地址，支持多张图片，此时各图片url之间用逗　号","隔开，且必须是微博域名下的url，即调用upload_pic或add_pic接口获取到的图片url，否则无效（最多支持9个url，多余9个忽略不计，单个URL最长不能超过1024字节）
 */
+ (void)sendImageUrlStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip imageUrl:(NSString *)picUrl scuuessed:(void(^)(NSString *statusId))success fail:(void(^)())fail;

/**
 发表带视频内容的微博
 视频url地址，后台自动分析视频信息，支持youku,tudou,ku6等（URL最长不能超过1024字节）
 */
+ (void)sendVideoStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip videoUrl:(NSString *)url scuuessed:(void(^)(NSString *statusId))success fail:(void(^)())fail;

/**
 上传一张图片
 pic_url 和 imageFilePath 二者选其中一个，如果多选以imageFilePath为主
 */
+ (void)uploadImageWithAccessToken:(NSString *)accessToken openId:(NSString *)openId openKey:(NSString *)openKey format:(FormatType)formatType imageFilePath:(NSString *)pic picUrl:(NSString *)picUrl scuuessed:(void(^)(NSString *imageUrl))success fail:(void(^)())fail;

/**
 删除一条微博(咱不通过，server error)
 */
+ (void)deleteStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid scuuessed:(void(^)(NSString *imageUrl))success fail:(void(^)())fail;

/**
 回复一条微博
 */
+ (void)replyStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType replyContent:(NSString *)content clientip:(NSString *)ip  statusId:(NSString *)sid scuuessed:(void(^)(NSString *replyId))success fail:(void(^)())fail;

/**
 评论一条微博
 */
+ (void)commentStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType replyContent:(NSString *)content clientip:(NSString *)ip  statusId:(NSString *)sid scuuessed:(void(^)(NSString *replyId))success fail:(void(^)())fail;

/**
 赞一条微博（ret:4）
 */
+ (void)likeStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid scuuessed:(void(^)(NSString *replyId))success fail:(void(^)())fail;


/**
 鉴权失败
 取消对一条微博的赞
 favoriteId(赞消息id,如果获取不到该值请填写随机数字值)
 */
+ (void)cancelLikeStatusAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid favoriteId:(NSString *)fid scuuessed:(void(^)(NSDictionary *result))success fail:(void(^)())fail;

/**
 收藏一条微博
 */
+ (void)favoriteStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid scuuessed:(void(^)(NSString *favoriteId))success fail:(void(^)())fail;


@end
