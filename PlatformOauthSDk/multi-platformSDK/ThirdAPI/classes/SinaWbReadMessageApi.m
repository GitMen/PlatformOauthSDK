//
//  SinaWbApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-27.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "SinaWbReadMessageApi.h"
#import "ThirdMarc.h"
@implementation SinaWbReadMessageApi

#pragma mark 获取公共微博信息
+ (void)publicStatusInfoWithAccessToken:(NSString *)accessToken count:(NSString *)count accessed:(void (^)(NSArray *))access fail:(void (^)())fail{
    //拼接url
    NSString *newUrl = [kSina_PublicStatus stringByAppendingFormat:@"?access_token=%@&count=%@",accessToken,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"statuses"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取用户信息
+ (void)userInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid accessed:(void (^)(NSDictionary *))access fail:(void (^)())fail{
    //拼接url
    NSString *newUrl = [kSina_UserInfo stringByAppendingFormat:@"?access_token=%@&uid=%@",accessToken,uid];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取用户发表的微博
+ (void)userSendStatusWithAccess_token:(NSString *)accessToken uid:(NSString *)uid sinceId:(NSString *)sinceID maxId:(NSString *)maxId page:(int)page count:(int)count feature:(int)feature accessed:(void (^)(NSArray *))access fail:(void (^)())fail{    //拼接url
    NSString *newUrl = [kSina_UserSendStatus stringByAppendingFormat:@"?access_token=%@&uid=%@&since_id=%@&max_id=%@&page=%d&count=%d&feature=%d",accessToken,uid,sinceID,maxId,page,count,feature];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"statuses"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取某条微博的评论列表
+ (void)statusCommentListWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void (^)(NSArray *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_StatusCommentList stringByAppendingFormat:@"?access_token=%@&id=%@&since_id=%@&max_id=%@&page=%d&count=%d",accessToken,statusId,sinceId,maxId,page,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"comments"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();   
    }];
}

#pragma mark 获取@我的评论
+ (void)touchMyCommentWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void (^)(NSArray *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_TouchMyCommentList stringByAppendingFormat:@"?access_token=%@&since_id=%@&max_id=%@&page=%d&count=%d",accessToken,sinceId,maxId,page,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"comments"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取用户的关注列表
+ (void)userAttentionListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid count:(int)count cursor:(int)cursor accessed:(void (^)(NSArray *, long, long))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_AttentionList stringByAppendingFormat:@"?access_token=%@&uid=%@&count=%d&cursor=%d",accessToken,uid,count,cursor];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"users"],[dict[@"next_cursor"] longValue],[dict[@"previous_cursor"] longValue]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取互相关注列表
+ (void)togetherAttentionListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid count:(int)count page:(int)page accessed:(void (^)(NSArray *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_TogetherAttentionList stringByAppendingFormat:@"?access_token=%@&uid=%@&count=%d&page=%d&",accessToken,uid,count,page];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"users"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取粉丝列表
+ (void)fansListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid count:(int)count cursor:(int)cursor accessed:(void (^)(NSArray *, long, long))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_FansList stringByAppendingFormat:@"?access_token=%@&uid=%@&count=%d&cursor=%d",accessToken,uid,count,cursor];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"users"],[dict[@"next_cursor"] longValue],[dict[@"previous_cursor"] longValue]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取用户收藏列表
+ (void)userFavoriteListWithAccessToken:(NSString *)accessToken page:(int)page count:(int)count accessed:(void (^)(NSArray *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_CollectList stringByAppendingFormat:@"?access_token=%@&page=%d&count=%d",accessToken,page,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"favorites"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取单条收藏信息
+ (void)favoriteInfoWithAccessToken:(NSString *)accessToken collectId:(NSString *)collectId accessed:(void (^)(NSDictionary *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_CollectInfo stringByAppendingFormat:@"?access_token=%@&id=%@",accessToken,collectId];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取@我的微博列表
+ (void)touchUserStatusListWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void (^)(NSArray *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_TouchMyStatusList stringByAppendingFormat:@"?access_token=%@&since_id=%@&max_id=%@&page=%d&count=%d",accessToken,sinceId,maxId,page,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"statuses"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取微博详情
+ (void)checkStatusInfoWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId accessed:(void (^)(NSDictionary *))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_StatusInfo stringByAppendingFormat:@"?access_token=%@&id=%@",accessToken,statusId];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取我发出的评论
+ (void)commentByMeWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void (^)(NSArray *, int, int))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_commentByMe stringByAppendingFormat:@"?access_token=%@&since_id=%@&max_id=%@&page=%d&count=%d",accessToken,sinceId,maxId,page,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"comments"],[dict[@"next_cursor"] intValue],[dict[@"previous_cursor"] intValue]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 获取我收到的评论
+ (void)commentToMeWithAccessToken:(NSString *)accessToken sinceId:(NSString *)sinceId maxId:(NSString *)maxId page:(int)page count:(int)count accessed:(void (^)(NSArray *, int, int))access fail:(void (^)())fail{
    NSString *newUrl = [kSina_commentToMe stringByAppendingFormat:@"?access_token=%@&since_id=%@&max_id=%@&page=%d&count=%d&filter_by_source=1",accessToken,sinceId,maxId,page,count];
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        access(dict[@"comments"],[dict[@"next_cursor"] intValue],[dict[@"previous_cursor"] intValue]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}
@end
