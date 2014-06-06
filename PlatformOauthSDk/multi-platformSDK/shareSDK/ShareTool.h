//
//  ShareView.h
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-6-4.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CShareObject.h"
#import "ThirdApi.h"
#import "OauthModel.h"
#import "OauthControl.h"
@interface ShareTool : NSObject

typedef enum{
    TEXT_TYPE = 11>>2,
    IMAGE_TYPE,
    VIDEO_TYPE,
    PAGE_TYPE
}ShareType;

/**
 工厂方法：构造实例
 参数为分享类，需要构造不同类别
 文本：CShareTextObject.
 图片：CShareImageObject.
 视频：CShareVideoObject.
 连接：CSharePageObject.
 */
+ (ShareTool *)shareWithObject:(CShareObject *)shareObject;

@property (nonatomic,strong)CShareObject *shareObject;
@property (nonatomic,assign)ShareType shareType;
/**
 分享到新浪微博
 */
- (void)shareToSianWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 分享到腾讯微博
 */
- (void)shareToTencentWBWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 分享到腾讯QQ好友
 */
- (void)shareToTencentQQFirend;

/**
 分享到腾讯QZone
 */
- (void)shareToTencentZone;

/**
 分享到微信好友
 */
- (void)shareToWechatFirend;

/**
 分享到微信朋友圈
 */
- (void)shareToWechatFirendCircle;

/**
 分享到人人网
 */
- (void)shareToRenrenWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 分享到开心网
 */
- (void)shareToKaixinWithSuccess:(void(^)())success fail:(void(^)())fail;
@end



