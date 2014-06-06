//
//  OauthModel.m
//  OauthDemo
//
//  Created by 张鼎辉 on 14-5-26.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "OauthModel.h"
static OauthModel *oauthMoedl;
@implementation OauthModel

+ (OauthModel *)shareOauthModel{
    if(!oauthMoedl){
        oauthMoedl = [[OauthModel alloc]init];
    }
    
    //从本地获取当归对象
    NSData *data = [NSData dataWithContentsOfFile:[OauthModel getPath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    OauthModel *oauth  = [unarchiver decodeObjectForKey:@"OauthModelKey"];
    oauth.tencentQQ.isLogin = oauthMoedl.tencentQQ.isLogin;
    [unarchiver finishDecoding];
    if(oauth){
        return oauthMoedl = oauth;
    }
    
    return oauthMoedl;
}


+ (void)enCodeModel{
    NSMutableData *mutableData = [NSMutableData dataWithCapacity:42];
     NSKeyedArchiver *arch =  [[NSKeyedArchiver alloc]initForWritingWithMutableData:mutableData];
    [arch encodeObject:oauthMoedl forKey:@"OauthModelKey"];
    [arch finishEncoding];
    [mutableData writeToFile:[OauthModel getPath] atomically:YES];
    
}

+ (NSString *)getPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:kOauthModelFiel];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(!oauthMoedl){
        oauthMoedl = [[OauthModel alloc]init];
    }
    oauthMoedl.sina = [aDecoder decodeObjectForKey:@"SinaKey"];
    oauthMoedl.renren = [aDecoder decodeObjectForKey:@"RenRenKey"];
    oauthMoedl.kaixin = [aDecoder decodeObjectForKey:@"KaixinKey"];
    oauthMoedl.tencentQQ = [aDecoder decodeObjectForKey:@"TencentQQKey"];
    oauthMoedl.tencentWB = [aDecoder decodeObjectForKey:@"TencentWBKey"];
    return oauthMoedl;
}

#pragma mark 归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.sina forKey:@"SinaKey"];
    [aCoder encodeObject:self.renren forKey:@"RenRenKey"];
    [aCoder encodeObject:self.kaixin forKey:@"KaixinKey"];
    [aCoder encodeObject:self.tencentWB forKey:@"TencentWBKey"];
    [aCoder encodeObject:self.tencentQQ forKey:@"TencentQQKey"];
}



@end


@implementation SinaOauth

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.accessToken = [aDecoder decodeObjectForKey:@"Sina_accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"Sina_uid"];
        self.expiresInDate = [aDecoder decodeObjectForKey:@"Sina_expiresIn"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"Sina_accessToken"];
    [aCoder encodeObject:self.uid forKey:@"Sina_uid"];
    [aCoder encodeObject:self.expiresInDate forKey:@"Sina_expiresIn"];
}
@end

@implementation TenxunWB
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.accessToken = [aDecoder decodeObjectForKey:@"txWB_accessToken"];
        self.openID = [aDecoder decodeObjectForKey:@"txWB_openID"];
        self.openKey = [aDecoder decodeObjectForKey:@"txWB_openKey"];
        self.refreshToken = [aDecoder decodeObjectForKey:@"txWB_refreshToken"];
        self.expiresIn = [aDecoder decodeObjectForKey:@"txWB_expiresIn"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"txWB_accessToken"];
    [aCoder encodeObject:self.openID forKey:@"txWB_openID"];
    [aCoder encodeObject:self.openKey forKey:@"txWB_openKey"];
    [aCoder encodeObject:self.refreshToken forKey:@"txWB_refreshToken"];
    [aCoder encodeObject:self.expiresIn forKey:@"txWB_expiresIn"];
}
@end

@implementation TenxunQQ
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.accessToken = [aDecoder decodeObjectForKey:@"txQQ_accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"txQQ_uid"];
        self.expirationDate = [aDecoder decodeObjectForKey:@"txQQ_date"];
        self.isLogin = oauthMoedl.tencentQQ.isLogin;
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"txQQ_accessToken"];
    [aCoder encodeObject:self.uid forKey:@"txQQ_uid"];
    [aCoder encodeObject:self.expirationDate forKey:@"txQQ_date"];
}


@end
@implementation Kaixin
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.accessToken = [aDecoder decodeObjectForKey:@"kaiXin_accessToken"];
        self.refreshToken = [aDecoder decodeObjectForKey:@"kaiXin_refreshToken"];
        self.expiresIn = [aDecoder decodeObjectForKey:@"kaiXin_expiresIn"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"kaiXin_accessToken"];
    [aCoder encodeObject:self.refreshToken forKey:@"kaiXin_refreshToken"];
    [aCoder encodeObject:self.expiresIn forKey:@"kaiXin_expiresIn"];
}

@end
@implementation RenRen
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.accessToken = [aDecoder decodeObjectForKey:@"renren_accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"renren_uid"];
        self.refreshToken = [aDecoder decodeObjectForKey:@"renren_refreshToken"];
        self.expiresIn = [aDecoder decodeObjectForKey:@"renren_expiresIn"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"renren_accessToken"];
    [aCoder encodeObject:self.refreshToken forKey:@"renren_refreshToken"];
    [aCoder encodeObject:self.expiresIn forKey:@"renren_expiresIn"];
    [aCoder encodeObject:self.uid forKey:@"renren_uid"];
}

@end
