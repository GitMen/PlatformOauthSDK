//
//  OauthModel.h
//  OauthDemo
//
//  Created by 张鼎辉 on 14-5-26.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kOauthModelFiel @"oauthFile.data"


@class SinaOauth,TenxunWB,TenxunQQ,Kaixin,RenRen;
@interface OauthModel : NSObject<NSCoding>

+ (OauthModel *)shareOauthModel;

///存档
+ (void)enCodeModel;


///新浪模型
@property (nonatomic,strong)SinaOauth *sina;
///腾讯微博模型
@property (nonatomic,strong)TenxunWB *tencentWB;
///腾讯QQ模型
@property (nonatomic,strong)TenxunQQ *tencentQQ;
///开心网模型
@property (nonatomic,strong)Kaixin *kaixin;
///人人网模型
@property (nonatomic,strong)RenRen *renren;

@end



//新浪
@interface SinaOauth : NSObject<NSCoding>

///令牌
@property (nonatomic,copy)NSString *accessToken;
///用户id
@property (nonatomic,copy)NSString *uid;
///access_token 过期时间
@property (nonatomic,strong)NSDate *expiresInDate;

@end


/**
 *腾讯微博
 */
@interface TenxunWB : NSObject<NSCoding>

///用户id
@property (nonatomic,copy)NSString *openID;
///用户id对应的key
@property (nonatomic,copy)NSString *openKey;
///令牌
@property (nonatomic,copy)NSString *accessToken;
///刷新access_token
@property (nonatomic,copy)NSString *refreshToken;
///过期时间
@property (nonatomic,copy)NSString *expiresIn;

@end


/**
 *腾讯QQ
 */
@interface TenxunQQ : NSObject<NSCoding>

///uid
@property (nonatomic,copy)NSString *uid;
///令牌
@property (nonatomic,copy)NSString *accessToken;
///过去时间
@property (nonatomic,strong)NSDate *expirationDate;
///是否在进行分享或者其他操作前登陆过QQ
@property (nonatomic,assign)BOOL isLogin;

@end

/**
 *开心网
 */
@interface Kaixin : NSObject<NSCoding>

///用于刷新Access Token 的 Refresh Token
@property (nonatomic,copy)NSString *refreshToken;
///令牌
@property (nonatomic,copy)NSString *accessToken;
///Access Token的有效期
@property (nonatomic,strong)NSString *expiresIn;

@end

/**
 *人人网
 */
@interface RenRen : NSObject<NSCoding>

///用于刷新Access Token 的 Refresh Token
///令牌
@property (nonatomic,copy)NSString *accessToken;
///uid
@property (nonatomic,strong)NSString *uid;
///Access Token的有效期
@property (nonatomic,strong)NSString *expiresIn;
///用于刷新Access Token 的 Refresh Token
@property (nonatomic,copy)NSString *refreshToken;
@end

