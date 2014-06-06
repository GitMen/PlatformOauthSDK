

/**
 * 授权专用组建
 * 如果需要使用减号方法，最好使用单例获取对象，否则可能会失败
 */
 

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
typedef enum{
    kSinaOauth = 22110, //新浪授权类型
    kTencentWbOauth,    //腾讯微博授权类型
    kTencentQqOauth,    //QQ授权类型
    kRenRenOauth,       //人人网授权类型
    kKaixinOauth       //开心网授权类型
}OauthEnum;



//授权回掉代理，订阅后可知道当前是给哪个平台授权，是否成功
@class ShareObject;
@protocol  BaseOauthDelegate<NSObject>

///授权后的返回结果:oauthType为授权类型 ， isOk：是否授权成功
- (void)resultWithOauthType:(OauthEnum)oauthType isOauth:(BOOL)isOk errorMsg:(NSString *)msg;

@end


@interface OauthControl : UIViewController<WeiboSDKDelegate,WBHttpRequestDelegate,UIWebViewDelegate,TencentSessionDelegate>


@property (nonatomic,strong)id<BaseOauthDelegate> oauthDelegate;

/**
 QQ授权类
 */
@property (nonatomic,strong)TencentOAuth *tenxunOauth;

/**
 构造方法，当要授权时使用此方法构造控制器并以模态的方式推入
 */
- (OauthControl *)initOauthWithType:(OauthEnum)oauthType delegate:(id<BaseOauthDelegate>)delegate;


/**
 获取单例
 */
+ (OauthControl *)shareOahtuController;

/**
 处理授权时传递的数据
 */
- (BOOL)handleOpenUrl:(NSURL *)url;




/**
 有关QQ的操作
 */
/**
 判断用户手机上是否安装QQ
 */
+ (BOOL)isInstalledQQ;

/**
 判断用户手机上是否安装QQ控件
 */
+ (BOOL)isInstalledQQZone;

/**
 获取QQ用户信息
 */
- (void)getQQUserInfo;


@end


