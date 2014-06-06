//
//  TencentWbReadMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-27.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "TencentWbReadMessageApi.h"

@implementation TencentWbReadMessageApi

+ (void)fansListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex sex:(SexType)sexType successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    int sex = 0;
    if(sexType == kSex_Male)sex=1;
    if(sexType == kSex_Woman)sex=2;
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&reqnum=%d&startindex=%d&mode=0&sex=%d&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",reqnum,startindex,sex,accessToken,openId];
    newUrl = [kTencentWB_fansListUrl stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
         fail();
    }];
}

+ (void)userFansListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId fopenId:(NSString *)fopenId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex sex:(SexType)sexType successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    int sex = 0;
    if(sexType == kSex_Male)sex=1;
    if(sexType == kSex_Woman)sex=2;
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&fopenid=%@&reqnum=%d&startindex=%d&mode=0&sex=%d&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",fopenId,reqnum,startindex,sex,accessToken,openId];
    newUrl = [kTencentWB_userFansList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark  获取其他用户的特别收听列表
+ (void)userSpeciallistWithAccessToken:(NSString *)accessToken openId:(NSString *)openId fopenId:(NSString *)fopenId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex successed:(void (^)(NSArray *))success fail:(void (^)())fail{
 
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&fopenid=%@&reqnum=%d&startindex=%d&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",fopenId,reqnum,startindex,accessToken,openId];
    newUrl = [kTencentWB_SpecialListenerList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}
#pragma mark  获取我的特别收听列表
+ (void)mySpeciallistWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format reqnum:(int)reqnum startindex:(int)startindex successed:(void (^)(NSArray *))success fail:(void (^)())fail{

    
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&reqnum=%d&startindex=%d&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",reqnum,startindex,accessToken,openId];
    newUrl = [kTencentWB_mySpecialListenerList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取公共微博
+ (void)publicStatusListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pos:(int)pos reqnum:(int)reqnum successed:(void (^)(NSArray *,int))success fail:(void (^)())fail{
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&access_token=%@&openid=%@&pos=%d&reqnum=%d",format == kFormat_JSON?@"json":@"xml",accessToken,openId,pos,reqnum];
    newUrl = [kTencentWB_PublicStatusList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"],[dict[@"pos"]intValue]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取微博的评论或转发列表
+ (void)forwordOrCommentListWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format listType:(ListTpe)type rootid:(NSString *)rootid pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum twitterid:(NSString *)twitterid successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    int flag = 0;
    if(type == kForwordList)flag=0;
    if(type == kCommentList)flag=1;
    
    int page = 0;
    if(pageType == kNextPage)page=1;
    if(pageType == kPreviousPage)page=2;
    
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&flag=%d&rootid=%@&pageflag=%d&pagetime=%@&access_token=%@&openid=%@&reqnum=%d&twitterid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",flag,rootid,page,pagetime,accessToken,openId,reqnum,twitterid];
    newUrl = [kTencentWB_ForwardOrCommentList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 查看微博详情
+ (void)statusInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format statusId:(NSString *)statusId successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{

    NSString *newUrl = [NSString stringWithFormat:@"format=%@&id=%@&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",statusId,accessToken,openId];
    newUrl = [kTencentWB_StatusInfo stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 根据链接地址获取视频信息
+ (void)analysisVideoInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format videoUrl:(NSString *)url successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_AnalysisVideoInfo]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"open_id"];
    [requestData setPostValue:format == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:url forKey:@"video_url"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 微博的收藏列表
+ (void)favoritesListAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum lastid:(NSString *)lastid successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    int page = 0;
    if(pageType == kNextPage)page=1;
    if(pageType == kPreviousPage)page=2;
    
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&pageflag=%d&pagetime=%@&access_token=%@&openid=%@&reqnum=%d&lastid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",page,pagetime,accessToken,openId,reqnum,lastid];
    newUrl = [kTencentWB_favoritesList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取私信首页会话列表
+ (void)privateMessageGroupAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum lastid:(NSString *)lastid successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    int page = 0;
    if(pageType == kNextPage)page=1;
    if(pageType == kPreviousPage)page=2;
    
 
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&pageflag=%d&pagetime=%@&reqnum=%d&lastid=%@&listtype=0&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",page,pagetime,reqnum,lastid,accessToken,openId];
    newUrl = [kTencentWB_PrivateMessageGroupList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取与某人的私信会话列表
+ (void)privateMessageInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId otherOpenId:(NSString *)fopenId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)reqnum lastid:(NSString *)lastid successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    int page = 0;
    if(pageType == kNextPage)page=1;
    if(pageType == kPreviousPage)page=2;
    
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&pageflag=%d&pagetime=%@&reqnum=%d&lastid=%@&name=wbapihelper&fopenid=%@&access_token=%@&openid=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",page,pagetime,reqnum,lastid,fopenId,accessToken,openId];
    newUrl = [kTencentWB_PrivateMessageInfoList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取身边最新的微博
+ (void)statusLBSWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format longitude:(float)longitude latitude:(float)latitude pageinfo:(NSString *)pageinfo pagesize:(int)pagesize successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_LBSStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"open_id"];
    [requestData setPostValue:format == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:[@(longitude)stringValue] forKey:@"longitude"];
    [requestData setPostValue:[@(latitude)stringValue] forKey:@"latitude"];
    [requestData setPostValue:pageinfo forKey:@"pageinfo"];
    [requestData setPostValue:[@(pagesize)stringValue] forKey:@"pagesize"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 获取当前用户发表的最新微博
+ (void)userNewStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format pageflag:(PageType)pageType pagetime:(NSString *)pagetime reqnum:(int)count lastid:(NSString *)lastid statusType:(StatusType)stype successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    int page = 0;
    if(pageType == kNextPage)page=1;
    if(pageType == kPreviousPage)page=2;
    
    int statusType = 0;
    if(stype == kStatusTextType)statusType = 0x80;
    if(stype == kStatusPageType)statusType = 2;
    if(stype == kStatusPhotoType)statusType = 4;
    if(stype == kStatusVideoType)statusType = 8;
    
    
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&pageflag=%d&pagetime=%@&reqnum=%d&lastid=%@&access_token=%@&openid=%@&contenttype=%d&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",page,pagetime,count,lastid,accessToken,openId,statusType];
    newUrl = [kTencentWB_userNewStatus stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 查询某人是否赞过某条微博
+(void)userIsLikeStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format statusId:(NSString *)sid fopenid:(NSString *)fid successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&access_token=%@&openid=%@&id=%@&fopenids=%@&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",accessToken,openId,sid,fid];
    newUrl = [kTencentWB_userIslikeStatus stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 获取身边最新的微博
+ (void)nearbyStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)format longitude:(double)lon latitude:(double)lat pageinfo:(int)page pagesize:(int)count successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [NSString stringWithFormat:@"format=%@&access_token=%@&openid=%@&longitude=%f&latitude=%f&pageinfo=%d&pagesize=%d&oauth_version=2.a",format == kFormat_JSON?@"json":@"xml",accessToken,openId,lon,lat,page,count];
    newUrl = [kTencentWB_userIslikeStatus stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"info"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}


@end
