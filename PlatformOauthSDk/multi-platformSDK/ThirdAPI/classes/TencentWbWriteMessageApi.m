//
//  TencentWbWriteMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-30.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "TencentWbWriteMessageApi.h"
#import "OauthKey.h"
@implementation TencentWbWriteMessageApi

+ (void)sendStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    
    
    
    
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_SendStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:clientip forKey:@"clientip"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 发表一条带图片的微博
+ (void)sendImageStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip imageFilePath:(NSString *)pic scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_SendImageStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:clientip forKey:@"clientip"];
    [requestData setFile:pic forKey:@"pic"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark  用图片URL发表带图片的微博
+ (void)sendImageUrlStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip imageUrl:(NSString *)picUrl scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_SendImageUrlStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:clientip forKey:@"clientip"];
    [requestData setPostValue:picUrl forKey:@"pic_url"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 发表带视频内容的微博
+ (void)sendVideoStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType content:(NSString *)content clientip:(NSString *)clientip videoUrl:(NSString *)url scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_SendVideoStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:clientip forKey:@"clientip"];
    [requestData setPostValue:url forKey:@"video_url"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 上传一张图片(有问题)
+ (void)uploadImageWithAccessToken:(NSString *)accessToken openId:(NSString *)openId openKey:(NSString *)openKey format:(FormatType)formatType imageFilePath:(NSString *)pic picUrl:(NSString *)picUrl scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_UploadImage]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:openKey forKey:@"openkey"];
    [requestData setPostValue:@"801509380" forKey:@"appkey"];
    [requestData setPostValue:@"ee738d7f3bc3f230f0e46643317d2600" forKey:@"appsecret"];
    
    if(![pic isEqualToString:@""] && pic){
        [requestData setPostValue:@"2" forKey:@"pic_type"];
        [requestData setFile:pic forKey:@"pic"];
    }else{
       
        [requestData setPostValue:@"1" forKey:@"pic_type"];
        [requestData setPostValue:picUrl forKey:@"pic_url"];
    }
    
    
    
    
    [requestData startAsynchronous];
    
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"imgurl"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 删除一条微博
+ (void)deleteStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_deleteStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:sid  forKey:@"id"];
    
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

#pragma mark 回复一条微博
+ (void)replyStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType replyContent:(NSString *)content clientip:(NSString *)ip statusId:(NSString *)sid scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_replyStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:ip forKey:@"clientip"];
    [requestData setPostValue:sid  forKey:@"reid"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 评论微博
+ (void)commentStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType replyContent:(NSString *)content clientip:(NSString *)ip statusId:(NSString *)sid scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_commentStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:content forKey:@"content"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:ip forKey:@"clientip"];
    [requestData setPostValue:sid  forKey:@"reid"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 赞一条微博
+ (void)likeStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_likeStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:sid  forKey:@"id"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark  取消对一条微博的赞
+ (void)cancelLikeStatusAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid favoriteId:(NSString *)fid scuuessed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_cancelLikeStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:sid  forKey:@"id"];
    [requestData setPostValue:fid  forKey:@"favoriteId"];
    
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

#pragma mark 收藏微博
+ (void)favoriteStatusWithAccessToken:(NSString *)accessToken openId:(NSString *)openId format:(FormatType)formatType statusId:(NSString *)sid scuuessed:(void (^)(NSString *))success fail:(void (^)())fail{
    __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kTencentWB_favoriteStatus]];
    [requestData setPostValue:accessToken forKey:@"access_token"];
    [requestData setPostValue:openId forKey:@"openid"];
    [requestData setPostValue:formatType == kFormat_JSON?@"json":@"xml" forKey:@"format"];
    [requestData setPostValue:sid  forKey:@"id"];
    
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        if([dict[@"msg"] isEqualToString:@"ok"]){
            success(dict[@"data"][@"id"]);
        }else{
            fail();
        }
        
    }];
    [requestData setFailedBlock:^{
        fail();
    }];

}
@end








