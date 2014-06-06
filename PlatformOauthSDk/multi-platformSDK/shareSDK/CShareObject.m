//
//  CShareObject.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-6-4.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "CShareObject.h"

@implementation CShareObject

@end


//文本
@implementation CShareTextObject

+ (id)shareTextTitle:(NSString *)title description:(NSString *)desc{
    CShareTextObject *textObject = [[CShareTextObject alloc]init];
    textObject.title = title;
    textObject.description = desc;
    return textObject;
}

@end

//图片
@implementation CShareImageObject

+ (id)shareImagesTitle:(NSString *)title description:(NSString *)desc imageData:(NSData *)iData{
    
    CShareImageObject *imageObject = [[CShareImageObject alloc]init];
    imageObject.imageData = iData;
    imageObject.title = title;
    imageObject.description = desc;
    return imageObject;
    
}

+ (id)shareImagesTitle:(NSString *)title description:(NSString *)desc imageUrls:(NSArray *)iUrls{
    CShareImageObject *imageObject = [[CShareImageObject alloc]init];
    imageObject.imageUrls = iUrls;
    imageObject.title = title;
    imageObject.description = desc;
    return imageObject;
}

+(id)shareImageTitle:(NSString *)title description:(NSString *)desc imageUrl:(NSString *)iUrl{
    CShareImageObject *imageObject = [[CShareImageObject alloc]init];
    imageObject.imageUrl = iUrl;
    imageObject.title = title;
    imageObject.description = desc;
    return imageObject;
}
@end

//视频
@implementation CShareVideoObject

+ (id)shareVideoTitle:(NSString *)title description:(NSString *)desc videoUrl:(NSString *)iUrl iconUrl:(NSString *)iconUrl iconData:(NSData *)data{
    CShareVideoObject *videoObject = [[CShareVideoObject alloc]init];
    videoObject.videoUrl = iUrl;
    videoObject.title = title;
    videoObject.description = desc;
    videoObject.iconUrl = iconUrl;
    videoObject.iconData = data;
    return videoObject;
}

@end

//连接
@implementation CSharePageObject

+ (id)sharePageTitle:(NSString *)title description:(NSString *)desc pageUrl:(NSString *)pUrl iconUrl:(NSString *)iconUrl iconData:(NSData *)data{
    CSharePageObject *pageObject = [[CSharePageObject alloc]init];
    pageObject.pageUrl = pUrl;
    pageObject.title = title;
    pageObject.description = desc;
    pageObject.iconUrl = iconUrl;
    pageObject.iconData = data;
    return pageObject;
}

@end



