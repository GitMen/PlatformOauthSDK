//
//  TencentQQWriteMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-30.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "TencentQQWriteMessageApi.h"

@implementation TencentQQWriteMessageApi


+ (BOOL)sendTextMessage:(NSString *)message{
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:[QQApiTextObject objectWithText:message]];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:req];
    
    return code == EQQAPISENDSUCESS;
}


+ (BOOL)sendImageMessage:(UIImage *)image title:(NSString *)title description:(NSString *)desc{
    
    NSData *data = UIImagePNGRepresentation(image);
    
    QQApiImageObject *object = [QQApiImageObject objectWithData:data previewImageData:data title:title description:desc];
    
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:object];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:req];
    
    return code == EQQAPISENDSUCESS;
}

+ (BOOL)sendVideoUrl:(NSString *)url title:(NSString *)title description:(NSString *)desc previewImage:(UIImage *)previewImage prviewImageUrl:(NSString *)pUrl{
    NSData *data = UIImagePNGRepresentation(previewImage);
    
    QQApiVideoObject *video = nil;
    if(!previewImage){
        video = [QQApiVideoObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageData:data];
    }else{
        video = [QQApiVideoObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageURL:[NSURL URLWithString:pUrl]];
    }
    
    
    
  
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:video];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:req];
    
    return code == EQQAPISENDSUCESS;
}

+ (BOOL)sendUrlMessage:(NSString *)url title:(NSString *)title description:(NSString *)desc previewImage:(UIImage *)previewImage previewUrl:(NSString *)pUrl urlTargetType:(QQApiURLTargetType)type{
    
    
    NSData *data = UIImageJPEGRepresentation([UIImage compressWithImageName:previewImage], 0.5);
    
    QQApiURLObject *urlObject;
    
    if((!previewImage || data.length == 0) && (!pUrl || [pUrl isEqualToString:@""])){
        return NO;
    }
    
    if(pUrl && ![pUrl isEqualToString:@""]){
        urlObject = [QQApiURLObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageURL:[NSURL URLWithString:pUrl] targetContentType:type];
    }
    
    if(previewImage && data.length != 0){
        urlObject = [QQApiURLObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageData:data targetContentType:type];
        
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObject];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:req];
    
    return code == EQQAPISENDSUCESS;
}
@end
