/**
 * 微信api读取的调用类
 * 使用此接口最初需要先执行注册方法
 */

#import <Foundation/Foundation.h>
#import "ThirdMarc.h"
@interface WechatWriteMessageApi : NSObject<WXApiDelegate>


/**
 判断微信是否被用户安装
 */
+ (BOOL)userIsHaveWX;

/**
 向微信注册应用
 */
+ (void)registerWechatWithAppId:(NSString *)appId withDescription:(NSString *)desc;

/**
 发送文本消息到微信
 */
+ (void)sendTextMessage:(NSString *)content withSection:(WechatSectionType)sectionType;

/**
 发送图片到微信
 */
+ (void)sendImage:(UIImage *)image withSection:(WechatSectionType)sectionType;

/**
 发送媒体连接到微信
 */
+ (void)sendPage:(NSString *)url icon:(UIImage *)icon title:(NSString *)title desciption:(NSString *)desc withSection:(WechatSectionType)sectionType;

/**
 发送媒体视频到微信
 */
+ (void)sendVideouUrl:(NSString *)url icon:(UIImage *)icon title:(NSString *)title desciption:(NSString *)desc withSection:(WechatSectionType)sectionType;
@end
