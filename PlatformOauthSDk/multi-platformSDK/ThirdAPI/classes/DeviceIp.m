//
//  DeviceIp.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-30.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "DeviceIp.h"
#import <ifaddrs.h>

#import <arpa/inet.h>

#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>

@implementation DeviceIp

+ (NSString *)getDeviceIp{
    NSString *address = @"error";
    
    struct ifaddrs *interfaces = NULL;
    
    struct ifaddrs *temp_addr = NULL;
    
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        // Loop through linked list of interfaces
        
        temp_addr = interfaces;
        
        while(temp_addr != NULL) {
            
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    // Get NSString from C String
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
            
        }
        
    }
    freeifaddrs(interfaces);
    
    return  address;

}



@end
