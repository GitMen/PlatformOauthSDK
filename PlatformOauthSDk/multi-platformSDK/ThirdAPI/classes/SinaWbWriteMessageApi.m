//
//  SinaWbWriteMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-29.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "SinaWbWriteMessageApi.h"

@implementation SinaWbWriteMessageApi


#pragma mark 发布一条新微博
+ (void)sendStatusMessageWithAccessToken:(NSString *)accessToken statusContent:(NSString *)content latitude:(double)latitude longitude:(double)longitude successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_sendStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:content forKey:@"status"];
    [requestData setPostValue:[@(latitude)stringValue] forKey:@"lat"];
    [requestData setPostValue:[@(longitude)stringValue] forKey:@"long"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 发布一条待图片的新微博
+ (void)sendStatusImageMessageWithAccessToken:(NSString *)accessToken statusContent:(NSString *)content imageFilePath:(NSString *)filePath latitude:(double)latitude longitude:(double)longitude successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_sendImageStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:content forKey:@"status"];
    [requestData setFile:filePath forKey:@"pic"];
    [requestData setPostValue:[@(latitude)stringValue] forKey:@"lat"];
    [requestData setPostValue:[@(longitude)stringValue] forKey:@"long"];
    
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 评论一条微博
+ (void)commentStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId commentText:(NSString *)text successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_commentStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:text forKey:@"comment"];
    [requestData setPostValue:statusId forKey:@"id"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 删除一条微博
+ (void)deleteStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_deleteStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:statusId forKey:@"id"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 删除评论
+ (void)deleteCommentWithAccessToken:(NSString *)accessToken commentId:(NSString *)commentId successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_deleteComment]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:commentId forKey:@"cid"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 批量删除评论
+ (void)deleteBatchCommentWithAccessToken:(NSString *)accessToken commentIds:(NSArray *)Ids successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_deleteComments]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:[Ids componentsJoinedByString:@","] forKey:@"cids"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(array);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 回复一条评论
+ (void)replyCommentWithAccessToken:(NSString *)accessToken statudId:(NSString *)sid commentId:(NSString *)cid replyText:(NSString *)text successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_replyComment]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:cid forKey:@"cid"];
    [requestData setPostValue:sid forKey:@"id"];
    [requestData setPostValue:text forKey:@"comment"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 取消关注
+ (void)cancelAttentionWithAccessToken:(NSString *)accessToken uId:(NSString *)uid successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_cancelAttention]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:uid forKey:@"uid"];
 
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 移除当前登陆用户的某个粉丝
+ (void)removeFansWithAccessToken:(NSString *)accessToken uId:(NSString *)uid successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_removeFans]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:uid forKey:@"uid"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 添加收藏
+ (void)addFavoriteAccessToken:(NSString *)accessToken statusId:(NSString *)statusId successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_addFavorite]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:statusId forKey:@"id"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 删除收藏
+ (void)deleteFavoriteWithAccessToken:(NSString *)accessToken favorite:(NSString *)favorite successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_deleteFavorite]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:favorite forKey:@"id"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 批量删除收藏
+ (void)deleteBatchFavoriteWithAccessToken:(NSString *)accessToken favoriteIds:(NSArray *)ids successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_deleteFavorites]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:[ids componentsJoinedByString:@","] forKey:@"ids"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 指定一个图片URL地址抓取后上传并同时发布一条新微博
+ (void)sendStatusImageUrlWithAccessToken:(NSString *)accessToken content:(NSString *)content imageUrl:(NSString *)iUrl successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak  ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kSina_sendImageUrlStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:content forKey:@"status"];
    
    iUrl = [iUrl hasPrefix:@"http://"]?iUrl:[@"http://" stringByAppendingFormat:@"%@",iUrl];
    
    [requestData setPostValue:iUrl forKey:@"url"];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}
@end
