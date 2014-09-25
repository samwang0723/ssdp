//
//  SSDPDeviceParser.h
//  NetworkHandler
//
//  Copyright (c) 2013 Sam Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSDPDevice.h"
#import "SSDPDeviceIcon.h"
#import "SSDPDeviceService.h"

@interface SSDPDeviceParser : NSObject<NSXMLParserDelegate> {
    SSDPDevice *device;
    
    BOOL isDeviceStart;
    BOOL isFriendlyNameStart;
    BOOL isDeviceTypeStart;
    BOOL isModelDescriptionStart;
    BOOL isModelNameStart;
    BOOL isSerialNumberStart;
    BOOL isUDNStart;
    BOOL isPresentationURLStart;
    BOOL isMimeTypeStart;
    BOOL isWidthStart;
    BOOL isHeightStart;
    BOOL isDepthStart;
    BOOL isUrlStart;
    BOOL isServiceTypeStart;
    BOOL isServiceIdStart;
    BOOL isSCPDURLStart;
    BOOL isControlProtocolStart;
    BOOL isControlPortStart;
    BOOL isControlURLStart;
    BOOL isEventSubURLStart;
    BOOL isIconStart;
    BOOL isServiceStart;
    
    NSMutableString *mFriendlyName;
    NSMutableString *mDeviceType;
    NSMutableString *mModelDescription;
    NSMutableString *mModelName;
    NSMutableString *mSerialNumber;
    NSMutableString *mUDN;
    NSMutableString *mPresentationURL;
    NSMutableString *mMimeType;
    NSMutableString *mWidth;
    NSMutableString *mHeight;
    NSMutableString *mDepth;
    NSMutableString *mUrl;
    NSMutableString *mServiceType;
    NSMutableString *mServiceId;
    NSMutableString *mSCPDURL;
    NSMutableString *mControlProtocol;
    NSMutableString *mControlPort;
    NSMutableString *mControlURL;
    NSMutableString *mEventSubURL;
    SSDPDeviceIcon *mTempIcon;
    SSDPDeviceService *mTempService;
}

@property (strong, nonatomic) SSDPDevice *device;

- (void) parseSSDPDevice:(NSString *)response;

@end
