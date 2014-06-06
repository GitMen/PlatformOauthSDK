/**
 分享类别类：用于分享功能时的数据类
 */

#import <Foundation/Foundation.h>

/**
 分享类别类：基类
 */
@interface CShareObject :  NSObject


@property (nonatomic,copy)NSString *title; //标题
@property (nonatomic,copy)NSString *description; //描述
@property (nonatomic,copy)NSString *iconUrl; //图标连接
@property (nonatomic,copy)NSString *videoUrl; //视频连接
@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)NSArray *imageUrls;
@property (nonatomic,copy)NSString *imageUrl; //图片连接
@property (nonatomic,copy)NSString *pageUrl; //视频连接
@property (nonatomic,strong)NSData *iconData; //视频连接
@end


/**
 分享类别类：文本类别
 */
@interface CShareTextObject : CShareObject

/**
 类方法构造文本分享类
 */
+ (id)shareTextTitle:(NSString *)title description:(NSString *)desc;

@end


/**
 分享类别类：图片类别
 */
@interface CShareImageObject : CShareObject



/**
 分享单张图片：如果是分享到QQ朋友，微信平台，优先使用iData形式的构造方法，不然如果url对应的图片过大  则分享会失败。
 */
+ (id)shareImageTitle:(NSString *)title description:(NSString *)desc imageUrl:(NSString *)iUrl;
/**
 分享多张图片：连接形势
 */
+ (id)shareImagesTitle:(NSString *)title description:(NSString *)desc imageUrls:(NSArray *)iUrls;
/**
 分享单张图片：数据形式
 iData大小不超过4M
 此构造出来的分享对象不适合分享到QZone,QZone只能用连接的形式分享
 */
+ (id)shareImagesTitle:(NSString *)title description:(NSString *)desc imageData:(NSData *)iData;
@end


/**
 分享类别类：视频类别
 
 */
@interface CShareVideoObject : CShareObject

/**
 分享视频
 优先使用iData 大小不超过4M
 */
+ (id)shareVideoTitle:(NSString *)title description:(NSString *)desc videoUrl:(NSString *)iUrl iconUrl:(NSString *)iconUrl iconData:(NSData *)data;
@end

/**
 分享类别类：连接类别
 */
@interface CSharePageObject : CShareObject
/**
 分享连接
  优先使用iData 大小不超过4M
 */
+ (id)sharePageTitle:(NSString *)title description:(NSString *)desc pageUrl:(NSString *)pUrl iconUrl:(NSString *)iconUrl iconData:(NSData *)data;
@end
