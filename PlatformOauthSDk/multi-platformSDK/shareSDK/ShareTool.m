//
//  ShareView.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-6-4.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "ShareTool.h"
#import "MBProgressHUD+Show.h"
@interface ShareTool(){
}

@end

@implementation ShareTool

+ (ShareTool *)shareWithObject:(CShareObject *)shareObject{
    ShareTool *tool = [[ShareTool alloc]init];
    tool.shareObject = shareObject;
    
    if([shareObject isKindOfClass:[CShareTextObject class]]){
        tool.shareType = TEXT_TYPE;
    }
    if([shareObject isKindOfClass:[CShareImageObject class]]){
        tool.shareType = IMAGE_TYPE;
    }
    if([shareObject isKindOfClass:[CShareVideoObject class]]){
        tool.shareType = VIDEO_TYPE;
    }
    return tool;
}


#pragma mark 分享到新浪
- (void)shareToSianWithSuccess:(void (^)())success fail:(void (^)())fail{
    
    SinaOauth *sina = [OauthModel shareOauthModel].sina;
    //判断分享类别
    switch (self.shareType) {
     case TEXT_TYPE:
        {
            NSString *content = [NSString stringWithFormat:@"%@    原文：%@",self.shareObject.title,self.shareObject.description];
            [SinaWbWriteMessageApi sendStatusMessageWithAccessToken:sina.accessToken statusContent:content latitude:0 longitude:0 successed:^(NSDictionary *newStatus) {
                success();
            } fail:^{
                fail();
            }];
        }
            break;
     case IMAGE_TYPE:{
            NSString *content = [NSString stringWithFormat:@"%@    原文：%@",self.shareObject.title,self.shareObject.description];
            [SinaWbWriteMessageApi sendStatusImageUrlWithAccessToken:sina.accessToken content:content imageUrl:self.shareObject.imageUrl successed:^(NSDictionary *status) {
                success();
            } fail:^{
                fail();
            }];
            
            
    }
            break;
        case VIDEO_TYPE:{
            fail();
        }
            break;
            
        default:
            break;
    }
}
    


#pragma mark 分享到腾讯微博
- (void)shareToTencentWBWithSuccess:(void (^)())success fail:(void (^)())fail{
    TenxunWB *wb = [OauthModel shareOauthModel].tencentWB;
    //判断分享类别
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            NSString *content = [NSString stringWithFormat:@"%@  ：%@",self.shareObject.title,self.shareObject.description];
            [TencentWbWriteMessageApi sendStatusWithAccessToken:wb.accessToken openId:wb.openID format:kFormat_JSON content:content clientip:[DeviceIp getDeviceIp] scuuessed:^(NSString *statusId) {
                success();
            } fail:^{
                fail();
            }];
        }
            break;
        case IMAGE_TYPE:{
            NSString *content = [NSString stringWithFormat:@"%@   ：%@",self.shareObject.title,self.shareObject.description];
            if(!self.shareObject.imageData){
                [TencentWbWriteMessageApi uploadImageWithAccessToken:wb.accessToken openId:wb.openID openKey:wb.openKey format:kFormat_JSON imageFilePath:@"" picUrl:self.shareObject.imageUrl scuuessed:^(NSString *imageUrl) {
                    [TencentWbWriteMessageApi sendImageUrlStatusWithAccessToken:wb.accessToken openId:wb.openID format:kFormat_JSON content:content clientip:[DeviceIp getDeviceIp] imageUrl:imageUrl scuuessed:^(NSString *statusId) {
                        success();
                    } fail:^{
                        fail();
                    }];
                } fail:^{
                    fail();
                }];
            }else{
                
                [self.shareObject.imageData writeToFile:[self getFilePath:@"tencentWBImage.jpg"] atomically:YES];
                [TencentWbWriteMessageApi sendImageStatusWithAccessToken:wb.accessToken openId:wb.openID format:kFormat_JSON content:self.shareObject.description clientip:[DeviceIp getDeviceIp] imageFilePath:[self getFilePath:@"tencentWBImage.jpg"] scuuessed:^(NSString *statusId) {
                    success();
                } fail:^{
                    fail();
                }];
            }
       }
            break;
        case VIDEO_TYPE:{
            NSString *content = [NSString stringWithFormat:@"%@   ：%@",self.shareObject.title,self.shareObject.description];
            
            [TencentWbWriteMessageApi sendVideoStatusWithAccessToken:wb.accessToken openId:wb.openID format:kFormat_JSON content:content clientip:[DeviceIp getDeviceIp] videoUrl:self.shareObject.videoUrl scuuessed:^(NSString *statusId) {
                success();
            } fail:^{
                fail();
            }];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark 分享到腾讯QQ
- (void)shareToTencentQQFirend{
    //判断分享类别
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            NSString *content = [NSString stringWithFormat:@"%@  ：%@",self.shareObject.title,self.shareObject.description];
            [TencentQQWriteMessageApi sendTextMessage:content];
        }
            break;
        case IMAGE_TYPE:{
            [TencentQQWriteMessageApi sendImageMessage:[UIImage imageWithData:self.shareObject.imageData] title:self.shareObject.title description:self.shareObject.description];
        }
            break;
        case VIDEO_TYPE:{
            [TencentQQWriteMessageApi sendVideoUrl:self.shareObject.videoUrl title:self.shareObject.title description:self.shareObject.description previewImage:nil prviewImageUrl:self.shareObject.iconUrl];
        }
            break;
        case PAGE_TYPE:{
             [TencentQQWriteMessageApi sendUrlMessage:self.shareObject.imageUrl title:self.shareObject.title description:self.shareObject.description previewImage:nil previewUrl:self.shareObject.imageUrl urlTargetType:QQApiURLTargetTypeNews];
        }
        default:
            break;
    }

}

#pragma mark 分享到腾讯空间
- (void)shareToTencentZone{
    
    TencentOAuth *oauth = [OauthControl shareOahtuController].tenxunOauth;
    
    
    //判断分享类别
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            NSMutableDictionary *data = [[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"说点什么吧", @"description",
                                          self.shareObject.description, @"summary",
                                          self.shareObject.title, @"title",
                                          @"肚兜云社交框架", @"source",
                                          @"打开官网", @"act",
                                          @"www.doodoll.com", @"url",
                                          nil] mutableCopy];
            
            [oauth sendStory:data friendList:nil];

        }
            break;
        case IMAGE_TYPE:{
             NSMutableDictionary *data = [[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"说点什么吧", @"description",
                                          self.shareObject.description, @"summary",
                                          self.shareObject.imageUrl, @"pics",
                                          self.shareObject.title, @"title",
                                          @"肚兜云社交框架", @"source",
                                          @"打开官网", @"act",
                                          @"www.doodoll.com", @"url",
                                          nil] mutableCopy];
            
            [oauth sendStory:data friendList:nil];
        }
            break;
        case VIDEO_TYPE:{
            NSMutableDictionary *data = [[NSDictionary dictionaryWithObjectsAndKeys:
                                           @"说点什么吧", @"description",
                                           self.shareObject.description, @"summary",
                                           self.shareObject.iconUrl, @"pics",
                                           self.shareObject.title, @"title",
                                           @"肚兜云社交框架", @"source",
                                           @"打开官网", @"act",
                                           @"www.doodoll.com", @"url",
                                            self.shareObject.videoUrl, @"shareurl",
                                           nil] mutableCopy];

            [oauth sendStory:data friendList:nil];
        }
            
            break;
        case PAGE_TYPE:{
            NSMutableDictionary *data = [[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"说点什么吧", @"description",
                                          self.shareObject.description, @"summary",
                                          self.shareObject.iconUrl, @"pics",
                                          self.shareObject.title, @"title",
                                          @"肚兜云社交框架", @"source",
                                          @"打开官网", @"act",
                                          @"www.doodoll.com", @"url",
                                          self.shareObject.pageUrl, @"shareurl",
                                          nil] mutableCopy];
            
            [oauth sendStory:data friendList:nil];

        }
        default:
            break;
    }

}





#pragma mark 分享到微信好友
- (void)shareToWechatFirend{
    //判断分享类别
    NSString *content = [NSString stringWithFormat:@"%@ : %@",self.shareObject.title,self.shareObject.description];

    [WechatWriteMessageApi registerWechatWithAppId:kWeixin_AppId withDescription:@"张鼎辉的demo"];
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            [WechatWriteMessageApi sendTextMessage:content withSection:FIREND_TYPE];
        }
                break;
        case IMAGE_TYPE:{
           
            [WechatWriteMessageApi sendImage:[UIImage imageWithData:self.shareObject.imageData] withSection:FIREND_TYPE];
          
        }
        case VIDEO_TYPE:{
          
            [WechatWriteMessageApi sendVideouUrl:self.shareObject.videoUrl icon:[UIImage imageWithData:self.shareObject.iconData] title:self.shareObject.title desciption:self.shareObject.description withSection:FIREND_TYPE];
          
            
        }
        case PAGE_TYPE:{
            
            [WechatWriteMessageApi sendPage:self.shareObject.pageUrl icon:[UIImage imageWithData:self.shareObject.imageData] title:self.shareObject.title desciption:self.shareObject.description withSection:FIREND_TYPE];
       

        }
            default:
            break;
    }
}

#pragma mark 分享到微信朋友圈
- (void)shareToWechatFirendCircle{
    [WechatWriteMessageApi registerWechatWithAppId:kWeixin_AppId withDescription:@"张鼎辉的demo"];
    //判断分享类别
    NSString *content = [NSString stringWithFormat:@"%@ : %@",self.shareObject.title,self.shareObject.description];
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            [WechatWriteMessageApi sendTextMessage:content withSection:CIRCLE_TYPE];
        }
            break;
        case IMAGE_TYPE:{
            
            [WechatWriteMessageApi sendImage:[UIImage imageWithData:self.shareObject.imageData] withSection:CIRCLE_TYPE];
        }
            break;
        case VIDEO_TYPE:{
            
            [WechatWriteMessageApi sendVideouUrl:self.shareObject.videoUrl icon:[UIImage imageWithData:self.shareObject.iconData] title:self.shareObject.title desciption:self.shareObject.description withSection:CIRCLE_TYPE];
        }
            
            break;
        case PAGE_TYPE:{
            [WechatWriteMessageApi sendPage:self.shareObject.pageUrl icon:[UIImage imageWithData:self.shareObject.iconData] title:self.shareObject.title desciption:self.shareObject.description withSection:CIRCLE_TYPE];
        }
        default:
            break;
    }

}

#pragma mark 分享到人人网
- (void)shareToRenrenWithSuccess:(void (^)())success fail:(void (^)())fail{
    
    RenRen *renren = [OauthModel shareOauthModel].renren;
    NSString *content = [NSString stringWithFormat:@"标题：%@  内容：%@",self.shareObject.title,self.shareObject.description];
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            [RenRenWriteMessageApi sendFeedWithAccessToken:renren.accessToken message:self.shareObject.title title:self.shareObject.title imageUrl:@"" description:self.shareObject.description subtitle:@"" targetUrl:@"http://www.doodoll.com" successed:^(NSDictionary *newFeed) {
                success();
            } fail:^{
                fail();
            }];
        }
            break;
        case IMAGE_TYPE:{
            if(([self.shareObject.imageUrl isEqualToString:@""]||!self.shareObject.imageUrl) && self.shareObject.imageData.length !=0){
                
                [self.shareObject.imageData writeToFile:[self getFilePath:@"renrenImage.jpg"] atomically:YES];
                //上传图片
                [RenRenWriteMessageApi uploadImageWithAccessToken:renren.accessToken  imageFielPath:[self getFilePath:@"renrenImage.jpg"] successed:^(NSString *imageUrl) {
                    [RenRenWriteMessageApi sendFeedWithAccessToken:renren.accessToken message:self.shareObject.title title:self.shareObject.title imageUrl:imageUrl description:self.shareObject.description subtitle:@"" targetUrl:imageUrl successed:^(NSDictionary *newFeed) {
                        success();
                    } fail:^{
                        fail();
                    }];
                } fail:^{
                    fail();
                }];
            }else{
                [RenRenWriteMessageApi sendFeedWithAccessToken:renren.accessToken message:self.shareObject.title title:self.shareObject.title imageUrl:self.shareObject.imageUrl description:self.shareObject.description subtitle:@"" targetUrl:self.shareObject.imageUrl successed:^(NSDictionary *newFeed) {
                    success();
                } fail:^{
                    fail();
                }];

            }
            
        }
            break;
        case VIDEO_TYPE:{
            
            if(([self.shareObject.iconUrl isEqualToString:@""] ||
                !self.shareObject.iconUrl) && self.shareObject.imageData.length !=0){
                
                [self.shareObject.iconData writeToFile:[self getFilePath:@"renrenIcon.jpg"] atomically:YES];
                //上传图片
                [RenRenWriteMessageApi uploadImageWithAccessToken:renren.accessToken imageFielPath:[self getFilePath:@"renrenIcon.jpg"] successed:^(NSString *imageUrl) {
                    [RenRenWriteMessageApi shareToRenRenWithAccessToken:renren.accessToken shareContent:content shareUrl:self.shareObject.videoUrl successed:^{
                        success();
                    } fail:^{
                        fail();
                    }];
                } fail:^{
                    fail();
                }];
            }else{
                [RenRenWriteMessageApi shareToRenRenWithAccessToken:renren.accessToken shareContent:content shareUrl:self.shareObject.videoUrl successed:^{
                    success();
                } fail:^{
                    fail();
                }];
            }
            
            
        }
            
            break;
        case PAGE_TYPE:{
            [RenRenWriteMessageApi shareToRenRenWithAccessToken:renren.accessToken shareContent:content shareUrl:self.shareObject.pageUrl successed:^{
                success();
            } fail:^{
                fail();
            }];
        }
        default:
            break;
    }

}

#pragma mark 分享到开心网
- (void)shareToKaixinWithSuccess:(void (^)())success fail:(void (^)())fail{
    Kaixin *kaixin = [OauthModel shareOauthModel].kaixin;
    
    NSString *content = [NSString stringWithFormat:@"标题：%@  内容：%@",self.shareObject.title,self.shareObject.description];
    switch (self.shareType) {
        case TEXT_TYPE:
        {
            [KaixinWriteMessageApi sendImageStatusWithAccessToken:kaixin.accessToken content:content imageFilePath:@"" imageUrl:@"" successed:^(NSDictionary *newStatus) {
                success();
            } fail:^{
                fail();
            }];
        }
            break;
        case IMAGE_TYPE:{
           
        }
            break;
        case VIDEO_TYPE:{
           
        }
            
            break;
        case PAGE_TYPE:{
            
        }
        default:
            break;
    }

}


- (NSString *)getFilePath:(NSString *)fileName{
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:fileName];
}


@end
