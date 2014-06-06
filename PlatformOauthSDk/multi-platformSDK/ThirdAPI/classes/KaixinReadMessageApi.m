

#import "KaixinReadMessageApi.h"

@implementation KaixinReadMessageApi


#pragma mark 获取当前登陆用户的基本信息
+ (void)currentUserInfoWithAccessToken:(NSString *)accessToken successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_currentUserInfo stringByAppendingFormat:@"?access_token=%@",accessToken];

    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
}

#pragma mark 根据uid获取用户详细信息
+ (void)userDetailInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    
    NSString *fields = @"uid,name,gender,hometown,city,status,logo120,logo50,birthday,blood,interest,intro,schooltype,school,career,company,dept";
    
    NSString *newUrl = [kKaixin_userDetailInfo stringByAppendingFormat:@"?access_token=%@&uids=%@&fields=%@",accessToken,uid,fields];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"users"][0]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];
}

#pragma mark 获取用户的信息列表
+ (void)userStatusListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid start:(int)start num:(int)num category:(StatusType)type successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    int statusType = 0;
    if(type == kStatusOriginalType)statusType = 1;
    if(type == kStatusForwordType)statusType = 2;
    
    NSString *newUrl = [kKaixin_userStatusList stringByAppendingFormat:@"?access_token=%@&uid=%@&start=%d&num=%d&category=%d",accessToken,uid,start,num,statusType];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];

    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"info"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];

}

#pragma mark 获取某一资源的所有评论
+ (void)statusAllCommentsWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId uid:(NSString *)uid startIndex:(int)index num:(int)num successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_statusComments stringByAppendingFormat:@"?access_token=%@objid=%@&ouid=%@&start=%d&num=%d&objtype=records",accessToken,statusId,uid,index,num];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"info"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];
}

#pragma mark 获取公共的记录
+ (void)publicStatusListWithAccessToken:(NSString *)accessToken start:(int)start num:(int)num successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_publicStatusList stringByAppendingFormat:@"?access_token=%@&start=%d&num=%d",accessToken,start,num];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"data"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];

}

#pragma mark 获取别人给我的评论
+ (void)commentsToMeWithAccessToken:(NSString *)accessToken startIndex:(int)index num:(int)num successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_commentToMe stringByAppendingFormat:@"?access_token=%@&start=%d&num=%d",accessToken,index,num];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"data"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];

}

#pragma mark 获取我给别人给评论或者回复
+ (void)commentOrReplyByMeAccessToken:(NSString *)accessToken startIndex:(int)index num:(int)num successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_commentOrReplyByMe stringByAppendingFormat:@"?access_token=%@&start=%d&num=%d",accessToken,index,num];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"data"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];
}

#pragma mark 获取某一资源的所有转发
+ (void)statusAllForwardAccessToken:(NSString *)accessToken statusId:(NSString *)statusId uid:(NSString *)uid startIndex:(int)index num:(int)num successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_forwardList stringByAppendingFormat:@"?access_token=%@&objid=%@&ouid=%@&start=%d&num=%d&objtype=records",accessToken,statusId,uid,index,num];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"data"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];
}

#pragma mark   获取对某一资源赞过的用户列表
+ (void)statusUserLikeListWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId uid:(NSString *)uid startIndex:(int)index num:(int)num successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSString *newUrl = [kKaixin_likeUserList stringByAppendingFormat:@"?access_token=%@&objid=%@&ouid=%@&start=%d&num=%d&objtype=records",accessToken,statusId,uid,index,num];
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"data"]);
    }];
    
    [requestData setFailedBlock:^{
        NSLog(@"%@",[requestData error]);
    }];

}




@end
