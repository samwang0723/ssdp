//
//  SSDPDevice.h
//  NetworkHandler
//
//  Copyright (c) 2013 Sam Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEVICE @"device"
#define DEVICE_TYPE @"deviceType"
#define FRIENDLY_NAME @"friendlyName"
#define MANUFACTURER @"manufacturer"
#define MANUFACTURER_URL @"manufacturerURL"
#define MODEL_DESCRIPTION @"modelDescription"
#define MODEL_NAME @"modelName"
#define MODEL_NUMBER @"modelNumber"
#define MODEL_URL @"modelURL"
#define SERIAL_NUMBER @"serialNumber"
#define UDN @"UDN"
#define PRESENTATION_URL @"presentationURL"

@interface SSDPDevice : NSObject {
    NSString *mFriendlyName;
    NSString *mDeviceType;
    NSString *mModelDescription;
    NSString *mModelName;
    NSString *mSerialNumber;
    NSString *mUDN;
    NSString *mPresentationURL;
    NSMutableArray *mIconList;
    NSMutableArray *mServiceList;
}

@property (strong, nonatomic) NSString *mFriendlyName;
@property (strong, nonatomic) NSString *mDeviceType;
@property (strong, nonatomic) NSString *mModelDescription;
@property (strong, nonatomic) NSString *mModelName;
@property (strong, nonatomic) NSString *mSerialNumber;
@property (strong, nonatomic) NSString *mUDN;
@property (strong, nonatomic) NSString *mPresentationURL;
@property (strong, nonatomic) NSMutableArray *mIconList;
@property (strong, nonatomic) NSMutableArray *mServiceList;

@end
