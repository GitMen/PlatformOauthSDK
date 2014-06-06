//
//  UIImage+Compress.m
//  ThirdPartyPlatformDemo
//
//  Created by 张鼎辉 on 14-5-30.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "UIImage+Compress.h"

#define MAX_IMAGEPIX 200          // max pix 200.0px
#define MAX_IMAGEDATA_LEN 100     // max data length 5K
@implementation UIImage (Compress)

+ (UIImage *)compressWithImageName:(UIImage *)imageIcon{
    UIImage *image = imageIcon;
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return image;
    }
    if (width == 0 || height == 0) {
        // void zero exception
        return image;
    }
    UIImage *newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
