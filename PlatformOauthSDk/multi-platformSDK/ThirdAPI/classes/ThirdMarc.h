


#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "OauthKey.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "UIImage+Compress.h"
/**
 * 存储第三方平台的url
 */

#pragma mark ----------新浪微博----------

#define kSina_BaseUrl @"https://api.weibo.com"
///公共微博
#define kSina_PublicStatus [NSString stringWithFormat:@"%@/2/statuses/public_timeline.json",kSina_BaseUrl]
///用户信息
#define kSina_UserInfo [NSString stringWithFormat:@"%@/2/users/show.json",kSina_BaseUrl]
///用户发表的微博
#define kSina_UserSendStatus [NSString stringWithFormat:@"%@/2/statuses/user_timeline.json",kSina_BaseUrl]
///获取@用户的微博列表
#define kSina_TouchMyStatusList [NSString stringWithFormat:@"%@/2/statuses/mentions.json",kSina_BaseUrl]
///根据ID获取单条微博信息
#define kSina_StatusInfo [NSString stringWithFormat:@"%@/2/statuses/show.json",kSina_BaseUrl]
///某条微博的评论列表
#define kSina_StatusCommentList [NSString stringWithFormat:@"%@/2/comments/show.json",kSina_BaseUrl]
///获取@我的评论
#define kSina_TouchMyCommentList [NSString stringWithFormat:@"%@/2/comments/mentions.json",kSina_BaseUrl]
///获取用户的关注列表
#define kSina_AttentionList [NSString stringWithFormat:@"%@/2/friendships/friends.json",kSina_BaseUrl]
///获取互相关注列表
#define kSina_TogetherAttentionList [NSString stringWithFormat:@"%@/2/friendships/friends/bilateral.json",kSina_BaseUrl]
///获取用户粉丝列表
#define kSina_FansList [NSString stringWithFormat:@"%@/2/friendships/followers.json",kSina_BaseUrl]
///获取当前用户的收藏列表
#define kSina_CollectList [NSString stringWithFormat:@"%@/2/favorites.json",kSina_BaseUrl]
///获取单条收藏信息
#define kSina_CollectInfo [NSString stringWithFormat:@"%@/2/favorites/show.json",kSina_BaseUrl]
///获取我发出的评论
#define kSina_commentByMe [NSString stringWithFormat:@"%@/2/comments/by_me.json",kSina_BaseUrl]
///我收到的评论列表
#define kSina_commentToMe [NSString stringWithFormat:@"%@/2/comments/to_me.json",kSina_BaseUrl]
///发布一条新微博
#define kSina_sendStatus  [NSString stringWithFormat:@"%@/2/statuses/update.json",kSina_BaseUrl]
///发布一条待图片的新微博
#define kSina_sendImageStatus [NSString stringWithFormat:@"%@/2/statuses/upload.json",kSina_BaseUrl]
///删除微博信息
#define kSina_deleteStatus [NSString stringWithFormat:@"%@/2/statuses/destroy.json",kSina_BaseUrl]
///评论一条微博
#define kSina_commentStatus  [NSString stringWithFormat:@"%@/2/comments/create.json",kSina_BaseUrl]
///删除一条评论
#define kSina_deleteComment  [NSString stringWithFormat:@"%@/2/comments/destroy.json",kSina_BaseUrl]
///批量删除评论
#define kSina_deleteComments [NSString stringWithFormat:@"%@/2/comments/destroy_batch.json",kSina_BaseUrl]
///回复一条评论
#define kSina_replyComment [NSString stringWithFormat:@"%@/2/comments/reply.json",kSina_BaseUrl]
///取消关注某个用户
#define kSina_cancelAttention [NSString stringWithFormat:@"%@/2/friendships/destroy.json",kSina_BaseUrl]
///移除当前登录用户的粉丝
#define kSina_removeFans [NSString stringWithFormat:@"%@/2/friendships/followers/destroy.json",kSina_BaseUrl]
///添加收藏
#define kSina_addFavorite [NSString stringWithFormat:@"%@/2/favorites/create.json",kSina_BaseUrl]
///删除收藏
#define kSina_deleteFavorite [NSString stringWithFormat:@"%@/2/favorites/destroy.json",kSina_BaseUrl]
///批量删除收藏
#define kSina_deleteFavorites [NSString stringWithFormat:@"%@/2/favorites/destroy_batch.json",kSina_BaseUrl]
///指定一个图片URL地址抓取后上传并同时发布一条新微博
#define kSina_sendImageUrlStatus [NSString stringWithFormat:@"%@/2/statuses/upload_url_text.json",kSina_BaseUrl]


#pragma mark ----------腾讯微博----------

#define kTencentWB_baseUrl @"https://open.t.qq.com"
///获取我的粉丝列表
#define kTencentWB_fansListUrl [NSString stringWithFormat:@"%@/api/friends/fanslist",kTencentWB_baseUrl]
///获取用户的粉丝列表
#define kTencentWB_userFansList [NSString stringWithFormat:@"%@/api/friends/user_fanslist",kTencentWB_baseUrl]
///获取用户的特别收听列表
#define kTencentWB_SpecialListenerList [NSString stringWithFormat:@"%@/api/friends/user_speciallist",kTencentWB_baseUrl]
///获取我的特别收听列表
#define kTencentWB_mySpecialListenerList [NSString stringWithFormat:@"%@/api/friends/speciallist",kTencentWB_baseUrl]
///获取用户的双向收听列表
///获取当前用户发表的最新微博
#define kTencentWB_userNewStatus [NSString stringWithFormat:@"%@/api/statuses/broadcast_timeline",kTencentWB_baseUrl]
///获取身边最新的微博
#define kTencentWB_nearbyStatus [NSString stringWithFormat:@"%@/api/lbs/get_around_new",kTencentWB_baseUrl]

///获取广播大厅的最新微博
#define kTencentWB_PublicStatusList [NSString stringWithFormat:@"%@/api/statuses/public_timeline",kTencentWB_baseUrl]
///获取单条微博的转发或评论列表
#define kTencentWB_ForwardOrCommentList [NSString stringWithFormat:@"%@/api/t/re_list",kTencentWB_baseUrl]
///根据微博ID获取一条微博数据
#define kTencentWB_StatusInfo [NSString stringWithFormat:@"%@/api/t/show",kTencentWB_baseUrl]
///根据链接地址获取视频信息
#define kTencentWB_AnalysisVideoInfo [NSString stringWithFormat:@"%@/api/t/getvideoinfo",kTencentWB_baseUrl]
///收藏的微博列表
#define kTencentWB_favoritesList [NSString stringWithFormat:@"%@/api/fav/list_t",kTencentWB_baseUrl]
///获取私信首页会话列表
#define kTencentWB_PrivateMessageGroupList [NSString stringWithFormat:@"%@/api/private/home_timeline",kTencentWB_baseUrl]
///获取与某人的私信会话列表
#define kTencentWB_PrivateMessageInfoList [NSString stringWithFormat:@"%@/api/private/user_timeline",kTencentWB_baseUrl]
///获取身边最新的微博
#define kTencentWB_LBSStatus [NSString stringWithFormat:@"%@/api/lbs/get_around_new",kTencentWB_baseUrl]
///发表一条微博信息
#define kTencentWB_SendStatus [NSString stringWithFormat:@"%@/api/t/add",kTencentWB_baseUrl]
///发表一条带图片的微博
#define kTencentWB_SendImageStatus [NSString stringWithFormat:@"%@/api/t/add_pic",kTencentWB_baseUrl]
///用图片URL发表带图片的微博
#define kTencentWB_SendImageUrlStatus [NSString stringWithFormat:@"%@/api/t/add_pic_url",kTencentWB_baseUrl]
///发表带视频内容的微博
#define kTencentWB_SendVideoStatus  [NSString stringWithFormat:@"%@/api/t/add_video",kTencentWB_baseUrl]
///上传一张图片
#define kTencentWB_UploadImage [NSString stringWithFormat:@"%@/api/t/upload_pic",kTencentWB_baseUrl]
///删除一条微博
#define kTencentWB_deleteStatus [NSString stringWithFormat:@"%@/api/t/del",kTencentWB_baseUrl]
///回复一条微博
#define kTencentWB_replyStatus [NSString stringWithFormat:@"%@/api/t/reply",kTencentWB_baseUrl]
///评论一条微博
#define kTencentWB_commentStatus [NSString stringWithFormat:@"%@/api/t/comment",kTencentWB_baseUrl]
///赞一条微博
#define kTencentWB_likeStatus [NSString stringWithFormat:@"%@/api/t/like",kTencentWB_baseUrl]
///取消对一条微博的赞
#define kTencentWB_cancelLikeStatus [NSString stringWithFormat:@"%@/api/t/unlike",kTencentWB_baseUrl]
///查询某人是否赞过某条微博
#define kTencentWB_userIslikeStatus [NSString stringWithFormat:@"%@/api/t/has_like",kTencentWB_baseUrl]
///收藏一条微博
#define kTencentWB_favoriteStatus [NSString stringWithFormat:@"%@/api/fav/addt",kTencentWB_baseUrl]



#pragma mark ----------开心网----------
#define kKaixin_baseUrl @"https://api.kaixin001.com"
///获取当前登录用户的资料
#define kKaixin_currentUserInfo [NSString stringWithFormat:@"%@/users/me.json",kKaixin_baseUrl]
///根据UID获取用户的详细资料
#define kKaixin_userDetailInfo  [NSString stringWithFormat:@"%@/users/show.json",kKaixin_baseUrl]
///获取用户的记录列表
#define kKaixin_userStatusList [NSString stringWithFormat:@"%@/records/user.json",kKaixin_baseUrl]
///获取某一资源的所有评论
#define kKaixin_statusComments [NSString stringWithFormat:@"%@/comment/list.json",kKaixin_baseUrl]
///获取“随便看看”的记录列表
#define kKaixin_publicStatusList [NSString stringWithFormat:@"%@/records/public.json",kKaixin_baseUrl]
///获取别人给我的评论
#define kKaixin_commentToMe [NSString stringWithFormat:@"%@/comment/comment_list.json",kKaixin_baseUrl]
///获取我给别人的评论及回复
#define kKaixin_commentOrReplyByMe [NSString stringWithFormat:@"%@/comment/reply_list.json",kKaixin_baseUrl]
///获取某一资源的所有转发
#define kKaixin_forwardList [NSString stringWithFormat:@"%@/forward/list.json",kKaixin_baseUrl]
///获取对某一资源赞过的用户列表
#define kKaixin_likeUserList [NSString stringWithFormat:@"%@/like/show.json",kKaixin_baseUrl]
///发表一条记录(可带图)
#define kKaixin_sendStatus [NSString stringWithFormat:@"%@/records/add.json",kKaixin_baseUrl]
///删除记录
#define kKaixin_deleteStatus [NSString stringWithFormat:@"%@/records/delete.json",kKaixin_baseUrl]
///添加对某一资源的评论
#define kKaixin_commentStatus  [NSString stringWithFormat:@"%@/comment/create.json",kKaixin_baseUrl]
///对某一资源的某条评论进行回复
#define kKaixin_replyComment  [NSString stringWithFormat:@"%@/comment/reply.json",kKaixin_baseUrl]
///删除评论
#define kKaixin_deleteComment [NSString stringWithFormat:@"%@/comment/delete.json",kKaixin_baseUrl]
///表达对某一资源的赞
#define kKaixin_likeStatus [NSString stringWithFormat:@"%@/like/create.json",kKaixin_baseUrl]
///取消对某一资源的赞
#define kKaixin_cancelLikeStatus [NSString stringWithFormat:@"%@/like/cancel.json",kKaixin_baseUrl]



#pragma mark  ----------人人网----------
#define kRenRen_baseUrl @"https://api.renren.com"
///通过经纬度获取新鲜事。
#define kRenRen_StatusByLocation [NSString stringWithFormat:@"%@/v2/location/feed/list",kRenRen_baseUrl]
///根据经纬度获取地点
#define kRenRen_LocationSit [NSString stringWithFormat:@"%@/v2/location/get",kRenRen_baseUrl]
///以分页的方式获取某个用户的分享列表
#define kRenRen_shareList [NSString stringWithFormat:@"%@/v2/share/list",kRenRen_baseUrl]
///获取站内资源被赞的次数。
#define kRenRen_FavourCount [NSString stringWithFormat:@"%@/v2/like/ugc/info/get",kRenRen_baseUrl]
///以分页的方式获取某个UGC的评论
#define kRenRen_StatusComments [NSString stringWithFormat:@"%@/v2/comment/list",kRenRen_baseUrl]
///根据新鲜事类型获取新鲜事列表
#define kRenRen_publicFeedList [NSString stringWithFormat:@"%@/v2/feed/list",kRenRen_baseUrl]
///获取用户信息
#define kRenRen_userInfo [NSString stringWithFormat:@"%@/v2/user/get",kRenRen_baseUrl]
///用户发表点评
#define kRenRen_comment  [NSString stringWithFormat:@"%@/v2/comment/put",kRenRen_baseUrl]
///分享人人网外部资源，例如：视频、图片等
#define kRenRen_shareToRenRen [NSString stringWithFormat:@"%@/v2/share/url/put",kRenRen_baseUrl]
///赞人人内部资源，相册、照片、日志、分享、视频等。
#define kRenRen_likeFeed [NSString stringWithFormat:@"%@/v2/like/ugc/put",kRenRen_baseUrl]
///取消对站内资源的赞。
#define kRenRen_cancelLikeFeed [NSString stringWithFormat:@"%@/v2/like/ugc/remove",kRenRen_baseUrl]
///发送自定义新鲜事。
#define kRenRen_sendFeed [NSString stringWithFormat:@"%@/v2/feed/put",kRenRen_baseUrl]
///上传照片
#define kRenRen_uploadImage [NSString stringWithFormat:@"%@/v2/photo/upload",kRenRen_baseUrl]
#pragma mark  ----------枚举----------
/**
 * 性别类型
 */
typedef enum{
    kSex_Male = 154 >> 1,
    kSex_Woman = 154 << 1,
    kSex_Normal = 154 >>2
}SexType;

/**
 * 格式类型
 */

typedef enum{
    kFormat_JSON = 221 >> 3,
    kFormat_XML
}FormatType;

/**
 * 列表类型
 */
typedef enum{
    kCommentList = 442 >>2,
    kForwordList
}ListTpe;

/**
 * 分页类型
 */
typedef enum{
    kFirstPage = 877 >>2, //第一页
    kNextPage,            //下一页
    kPreviousPage         //上一页
}PageType;

/**
 * 微博类型
 */
typedef enum{
    kStatusOriginalType = 887 >> 1, //原创
    kStatusForwordType,             // 转发
    kStatusNormalType,               //全部
    kStatusPhotoType,  //照片类型
    kStatusVideoType, //视屏类型
    kStatusPageType,   //连接类型
    kStatusTextType //文本类型
}StatusType;

/**
 * 人人网新鲜事类型
 */
typedef enum{
    TYPE_ALL = 715 >>4,//全部类型
    TYPE_IMAGE, //照片类型
    TYPE_CHECKIN, //签到类型
    TYPE_STATUS, //状态类型
    TYPE_POINT   //地点评价类型
}LocationFeedType;


/**
 * 人人网可以赞的类型
 */
typedef enum{
    LIKE_TYPE_VIDEO = 123<<2,	//枚举	视频类型
    LIKE_TYPE_PHOTO,	//枚举	照片类型
    LIKE_TYPE_SHARE,	//枚举	分享类型
}LikeUGCType;

/**
 * 微信平台类型
 */
typedef enum{
    FIREND_TYPE = WXSceneSession, //微信好友
    CIRCLE_TYPE = WXSceneTimeline, //微信圈
    FAVORITE_TYPE = WXSceneFavorite //收藏
}WechatSectionType;











