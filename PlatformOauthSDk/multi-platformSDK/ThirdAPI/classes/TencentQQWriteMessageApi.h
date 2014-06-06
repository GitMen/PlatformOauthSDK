/**
 * 微信api读取的调用类
 * 使用此接口最初需要先执行注册方法
 */

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "ThirdMarc.h"
@interface TencentQQWriteMessageApi : NSObject


/**
 向QQ好友发送消息
 return 是否成功
 */
+ (BOOL)sendTextMessage:(NSString *)message;

/**
 向QQ好友发送图片消息
 return 是否成功
 */
+ (BOOL)sendImageMessage:(UIImage *)image title:(NSString *)title description:(NSString *)desc;


/**
 向QQ好友发送视频连接消息
 return 是否成功
 */
+ (BOOL)sendVideoUrl:(NSString *)url title:(NSString *)title description:(NSString *)desc previewImage:(UIImage *)previewImage prviewImageUrl:(NSString *)pUrl;


/**
 （暂不可用）
 向QQ好友发送普通连接消息
 previewImage 和 previewUrl 选择输入一项即可，如果都有以previewImage为主
 return 是否成功
 */
+ (BOOL)sendUrlMessage:(NSString *)url title:(NSString *)title description:(NSString *)desc previewImage:(UIImage *)previewImage previewUrl:(NSString *)pUrl urlTargetType:(QQApiURLTargetType)type;

@end
