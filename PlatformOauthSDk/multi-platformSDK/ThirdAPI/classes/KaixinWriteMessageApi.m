//
//  KaixinWriteMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-6-3.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "KaixinWriteMessageApi.h"

@implementation KaixinWriteMessageApi


#pragma mark 发表
+ (void)sendImageStatusWithAccessToken:(NSString *)accessToken content:(NSString *)content imageFilePath:(NSString *)filePath imageUrl:(NSString *)iUrl successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_sendStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    
    if(![filePath isEqualToString:@""] && filePath){
        [requestData setPostValue:filePath forKey:@"pic"];
    }
    if(![iUrl isEqualToString:@""] && iUrl){
        [requestData setPostValue:iUrl forKey:@"picurl"];
    }
    
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 删除记录
+ (void)deleteStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)sid successed:(void (^)())success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_deleteStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:sid forKey:@"rid"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 添加对某一资源的评论
+ (void)commentStatusWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid content:(NSString *)content successed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_commentStatus]];
    [requestData setPostValue:sid forKey:@"objid"];
    [requestData setPostValue:oid forKey:@"ouid"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:@"records" forKey:@"objtype"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"thread_cid"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 回复评论
+ (void)replyCommentWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid commentOwnerId:(NSString *)coid commentId:(NSString *)cid content:(NSString *)content successed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_replyComment]];
    [requestData setPostValue:sid forKey:@"objid"];
    [requestData setPostValue:oid forKey:@"owner"];
    
    [requestData setPostValue:coid forKey:@"ouid"];
    [requestData setPostValue:cid forKey:@"thread_cid"];
    
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:@"records" forKey:@"objtype"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"cid"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 删除评论
+ (void)deleteCommentWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid commentId:(NSString *)cid successed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_deleteComment]];
    
    [requestData setPostValue:oid forKey:@"owner"];
    [requestData setPostValue:cid forKey:@"thread_cid"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"cid"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 表达对某一资源的赞
+ (void)likeStatusWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid successed:(void (^)())success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_likeStatus]];
    
    [requestData setPostValue:oid forKey:@"ouid"];
    [requestData setPostValue:sid forKey:@"objid"];
    [requestData setPostValue:@"records" forKey:@"objtype"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"cid"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}
#pragma mark 取消对某一资源的赞
+ (void)cancelLikeStatusWithAccessToken:(NSString *)accessToken statusOwnerId:(NSString *)oid statusId:(NSString *)sid successed:(void (^)())success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kKaixin_cancelLikeStatus]];
    
    [requestData setPostValue:oid forKey:@"ouid"];
    [requestData setPostValue:sid forKey:@"objid"];
    [requestData setPostValue:@"records" forKey:@"objtype"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"cid"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}
@end
