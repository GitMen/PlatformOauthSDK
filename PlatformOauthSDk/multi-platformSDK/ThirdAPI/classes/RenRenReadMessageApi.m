//
//  RenRenReadMessageApi.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-28.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "RenRenReadMessageApi.h"

@implementation RenRenReadMessageApi

+ (void)statusByLocationWithAccessToken:(NSString *)accessToken page:(int)page count:(int)count radius:(int)radius longitude:(double)longitude latitude:(double)latitude feedType:(LocationFeedType)feedType successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:42];
    NSString *type = NULL;
    switch (feedType) {
        case TYPE_ALL:
            type = @"TYPE_ALL";
            [array addObject:type];
            break;
        case TYPE_CHECKIN:
            type = @"TYPE_CHECKIN";
            [array addObject:type];
             break;
            
        case TYPE_IMAGE:
            type = @"TYPE_IMAGE";
            [array addObject:type];
             break;
        case TYPE_POINT:
            type = @"TYPE_POINT";
            [array addObject:type];
             break;
        case TYPE_STATUS:
            type = @"TYPE_STATUS";
            [array addObject:type];
             break;
        default:
            break;
    }
    
    NSString *newUrl = [NSString stringWithFormat:@"?access_token=%@&pageSize=%d&pageNumber=%d&locationFeedType=%@&radius=%d&longitude=%f&latitude=%f",accessToken,page,count,[array componentsJoinedByString:@","],radius,longitude,latitude];
    newUrl = [kRenRen_StatusByLocation stringByAppendingFormat:@"%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 根据经纬度获取地点
+ (void)locationSiteWithAccessToken:(NSString *)accessToken longitude:(double)longitude latitude:(double)latitude successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    NSString *newUrl = [NSString stringWithFormat:@"?access_token=%@&longitude=%f&latitude=%f&deflection=0",accessToken,longitude,latitude];
    newUrl = [kRenRen_LocationSit stringByAppendingFormat:@"%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark   以分页的方式获取某个用户的分享列表
+ (void)shareListWithAccessToken:(NSString *)accessToken ownerId:(NSString *)ownerId page:(int)page count:(int)count successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    NSString *newUrl = [NSString stringWithFormat:@"?access_token=%@&ownerId=%@&pageSize=%d&pageNumber=%d",accessToken,ownerId,page,count];
    newUrl = [kRenRen_shareList stringByAppendingFormat:@"%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 获取站内资源被赞的次数。
+ (void)statusFavourCountWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId likeType:(LikeUGCType)type successed:(void (^)(int))success fail:(void (^)())fail{
    
    NSString *likeType = NULL;
    switch (type) {
        case LIKE_TYPE_PHOTO:
            likeType = @"TYPE_PHOTO";
            break;
        case LIKE_TYPE_SHARE:
            likeType = @"TYPE_SHARE";
            break;
                case LIKE_TYPE_VIDEO:
            likeType = @"TYPE_VIDEO";
            break;
        default:
            break;
    }
    
    
    
    
    NSString *newUrl = [NSString stringWithFormat:@"?access_token=%@&ugcId=%@&likeUGCType=%@&withLikeUsers=0&limit=50",accessToken,statusId,likeType];
    newUrl = [kRenRen_FavourCount stringByAppendingFormat:@"%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success([dict[@"response"][@"likeCount"] intValue]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 以分页的方式获取某个UGC的评论
+ (void)statusCommentsWithAccessToken:(NSString *)accessToken statusId:(NSString *)statusId statusOwnerId:(NSString *)statusOwnerId page:(int)page count:(int)count successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    NSString *newUrl = [NSString stringWithFormat:@"?access_token=%@&entryId=%@&entryOwnerId=%@&commentType=STATUS&pageSize=%d&pageNumber=%d",accessToken,statusId,statusOwnerId,page,count];
    newUrl = [kRenRen_StatusComments stringByAppendingFormat:@"%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 根据新鲜事类型获取新鲜事列表
+ (void)publicFeedListWithAccessToken:(NSString *)accessToken uid:(NSString *)uid feedType:(StatusType)type page:(int)page count:(int)count successed:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    NSString *feedType = NULL;
    switch (type) {
        case kStatusVideoType:
            feedType = @"SHARE_VIDEO";
            break;
        case kStatusPhotoType:
            feedType = @"SHARE_PHOTO";
            break;
        case kStatusNormalType:
            feedType = @"ALL";
            break;
        case kStatusPageType:
            feedType = @"SHARE_LINK";
            break;
        default:
            feedType = @"ALL";
            break;
    }
    
    NSString *newUrl = [NSString stringWithFormat:@"access_token=%@&uid=%@&pageNumber=%d&pageSize=%d&feedType=%@",accessToken,uid,page,count,feedType];
    newUrl = [kRenRen_publicFeedList stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];

}

#pragma mark 获取用户信息
+ (void)userInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid successed:(void (^)(NSDictionary *))success fail:(void (^)())fail{
    NSString *newUrl = [NSString stringWithFormat:@"access_token=%@&userId=%@",accessToken,uid];
    newUrl = [kRenRen_userInfo stringByAppendingFormat:@"?%@",[newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    __weak ASIHTTPRequest *requestData = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [requestData startAsynchronous];
    
    [requestData setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableContainers error:nil];
        success(dict[@"response"]);
    }];
    
    [requestData setFailedBlock:^{
        fail();
    }];
}

#pragma mark 上传照片

@end










