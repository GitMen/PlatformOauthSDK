//
//  WechatWriteMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-29.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "WechatWriteMessageApi.h"

@implementation WechatWriteMessageApi


#pragma mark 判断用户是否安装微信
+ (BOOL)userIsHaveWX{
    return [WXApi isWXAppInstalled];
}

#pragma mark 向微信注册
+ (void)registerWechatWithAppId:(NSString *)appId withDescription:(NSString *)desc{
    [WXApi registerApp:appId withDescription:desc];
}

#pragma mark 发送文本消息
+ (void)sendTextMessage:(NSString *)content withSection:(WechatSectionType)sectionType{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = content;
    req.bText = YES;
    req.scene = sectionType;
    [WXApi sendReq:req];
}

#pragma mark 发送图片加文本到微信
+ (void)sendImage:(UIImage *)image withSection:(WechatSectionType)sectionType{
    
    image = [UIImage compressWithImageName:image];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.005);

    WXMediaMessage *message = [WXMediaMessage message];
    
    [message setThumbImage:[UIImage imageWithData:imageData]];
  
    WXImageObject *ext = [WXImageObject object];
    
    ext.imageData = UIImagePNGRepresentation(image);
    
    UIImage* images = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(images);
    
    
    message.mediaObject = ext;
   
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = sectionType;
    
    [WXApi sendReq:req];
}

#pragma mark 发送媒体连接到微信
+ (void)sendPage:(NSString *)url icon:(UIImage *)icon title:(NSString *)title desciption:(NSString *)desc withSection:(WechatSectionType)sectionType{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    
    icon = [UIImage compressWithImageName:icon];
    NSData *data = UIImageJPEGRepresentation(icon, 0.5);
    [message setThumbImage:[UIImage imageWithData:data]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = sectionType;
    
    [WXApi sendReq:req];

}
#pragma mark 发送媒体视频到微信
+ (void)sendVideouUrl:(NSString *)url icon:(UIImage *)icon title:(NSString *)title desciption:(NSString *)desc withSection:(WechatSectionType)sectionType{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    icon = [UIImage compressWithImageName:icon];
    NSData *data = UIImageJPEGRepresentation(icon, 0.2);
    [message setThumbImage:[UIImage imageWithData:data]];
    
    
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = sectionType;
    
    [WXApi sendReq:req];
}



@end
