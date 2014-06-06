//
//  RenRenWriteMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-6-3.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "RenRenWriteMessageApi.h"

@implementation RenRenWriteMessageApi

#pragma mark 用户发表点评
+ (void)commentStatusWithAccessToken:(NSString *)accessToken statusId:(NSString *)sId statusOwnerId:(NSString *)owerId content:(NSString *)content successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRenRen_comment]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:@"STATUS" forKey:@"commentType"];
    [requestData setPostValue:sId forKey:@"entryId"];
    [requestData setPostValue:owerId forKey:@"entryOwnerId"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 分享
+ (void)shareToRenRenWithAccessToken:(NSString *)accessToken shareContent:(NSString *)content shareUrl:(NSString *)url successed:(void (^)())success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRenRen_shareToRenRen]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:url forKey:@"url"];
    [requestData setPostValue:content forKey:@"comment"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark  赞人人内部资源，相册、照片、日志、分享、视频等。
+ (void)likeFeedWithAccessToken:(NSString *)accessToken statusId:(NSString *)sId statusOwnerId:(NSString *)owerId successed:(void (^)())success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRenRen_likeFeed]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:@"TYPE_STATUS" forKey:@"likeUGCType"];
    [requestData setPostValue:sId forKey:@"ugcId"];
    [requestData setPostValue:owerId forKey:@"ugcOwnerId"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"response"] isEqualToString:@"1"]){
            success();
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 取消对站内资源的赞。
+ (void)cancelLikeFeedWithAccessToken:(NSString *)accessToken statusId:(NSString *)sId statusOwnerId:(NSString *)owerId successed:(void (^)())success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRenRen_cancelLikeFeed]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:@"TYPE_STATUS" forKey:@"likeUGCType"];
    [requestData setPostValue:sId forKey:@"ugcId"];
    [requestData setPostValue:owerId forKey:@"ugcOwnerId"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"response"] isEqualToString:@"1"]){
            success();
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

+ (void)sendFeedWithAccessToken:(NSString *)accessToken message:(NSString *)message title:(NSString *)title imageUrl:(NSString *)url description:(NSString *)desc subtitle:(NSString *)subtitle targetUrl:(NSString *)tUrl successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRenRen_sendFeed]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:message forKey:@"message"];
    [requestData setPostValue:title forKey:@"title"];
    [requestData setPostValue:url forKey:@"imageUrl"];
    [requestData setPostValue:desc forKey:@"description"];
    [requestData setPostValue:subtitle forKey:@"subtitle"];
    [requestData setPostValue:tUrl forKey:@"targetUrl"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 上传本地照片
+ (void)uploadImageWithAccessToken:(NSString *)accessToken imageFielPath:(NSString *)imagePath successed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRenRen_uploadImage]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setFile:imagePath forKey:@"file"];
   
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        NSString *url = dict[@"response"][@"images"][0][@"url"];
        success(url);
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}
@end
