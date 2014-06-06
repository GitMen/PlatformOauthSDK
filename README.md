PlatformOauthSDK
================

继承第三方平台授权，一键分享到新浪微博，腾讯微博，开心网，人人网，微信好友，微信朋友圈，腾讯QQ，QQ空间。 集成第三方数据读取api等操作


引用此SDK需要的配置
/**
  *依赖ASIHttoRequest.framework的配置：将所有ASI文件进行ARC编译
  */
步骤一：在Build Phases—>Compile Sources中把所有ASI开头的文件后面添加 -fno-objc-arc （包含Reachability.m文件）
步骤二：添加依赖包 libz.1.2.5.dylib 和 libzxml2.dylib
步骤三:   配置build setting——>other linker  flags. 添加 -lxml2
步骤四：配置build setting——>header search paths 下添加 ${SDK_DIR}/usr/include/libxml2

/**
  *新浪微博依赖配置
  */
步骤一：在targets—>info—>URL Types中按+号新增一个    在identifier中写入注册新浪开发者时的回掉地址，默认可以写https://api.weibo.com/oauth2/default.html     在URL Schemes中写入wb+appkey
(+号不写)
步骤二：general—>bundle identifier必须和在新浪开放平台创建应用时的boundID相同

/**
  *QQ依赖配置
  */
步骤一：添加SDK依赖的系统库文件。分别是”Security.framework”, “libiconv.dylib”，“SystemConfiguration.framework”，“CoreGraphics.Framework”、“libsqlite3.dylib”、“CoreTelephony.framework”、“libstdc++.dylib”、“libz.dylib”。

步骤二：在工程配置中的“Build Settings”一栏中找到“Linking”配置区，给“Other Linker Flags”配置项添加属性值“-fobjc-arc”。

步骤三：在XCode中，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“URL type”添加一条新的“URL scheme”，新的scheme = tencent + appid。如果您使用的是XCode3或者更低的版本，则需要在plist文件中添加。Demo中我们注册的appid是tencent1101473555 ， 在identifier中写入tencentopenapi


//简单的调用说明
需要在appDelegate中实现

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
     //处理网络请求的数据传输
     return [[OauthViewController shareOahtuController]handleOpenUrl:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //处理网络请求的数据传输
     return [[OauthViewController shareOahtuController]handleOpenUrl:url];

}

需要授权时调用
[self presentViewController:[[OauthViewController alloc] initOauthWithType:kSinaOauth delegate:self] animated:YES completion:nil];
//说明：必须是以模态试图的形式传入，
实现代理BaseOauthDelegate
实现代理方法- (void)resultWithOauthType:(OauthEnum)oauthType isOauth:(BOOL)isOk errorMsg:(NSString *)msg；
此方法为授权的结果

在OauthKey.h 中修改自己注册开发者的相关信息


OauthModel 类专门存储授权成功后的信息，并且支持归档，当授权时只需要获取单例然后进行判断是否有授权信息，如果有授权信息就不需要在授权了


使用微信接口配置说明：
在XCode中，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“URL type”添加一条新的“URL scheme”，新的scheme = （申请微信开发者成功后获取的appId） 如果您使用的是XCode3或者更低的版本，则需要在plist文件中添加= 在identifier中写入weixin
最好在appdelegate中使用接口进行注册。（详情参照接口调用文档）


第三方数据读取接口参照ThirdApi.h
授权操作参照OauthControl.h
分享操作参照ShareTool.h 

详细Demo 日后会增加

如果有不了解的地方可以发邮箱给我 443538720@qq.com
