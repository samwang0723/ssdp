//
//  SSDPDeviceIcon.h
//  NetworkHandler
//
//  Copyright (c) 2013 Sam Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ICON_LIST @"iconList"
#define ICON @"icon"
#define MIME_TYPE @"mimeType"
#define WIDTH @"width"
#define HEIGHT @"height"
#define DEPTH @"depth"
#define URL @"url"

@interface SSDPDeviceIcon : NSObject {
    NSString *mMimeType;
    NSString *mWidth;
    NSString *mHeight;
    NSString *mDepth;
    NSString *mUrl;
}

@property (strong, nonatomic) NSString *mMimeType;
@property (strong, nonatomic) NSString *mWidth;
@property (strong, nonatomic) NSString *mHeight;
@property (strong, nonatomic) NSString *mDepth;
@property (strong, nonatomic) NSString *mUrl;

@end
