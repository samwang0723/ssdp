//
//  SSDPDeviceService.h
//  NetworkHandler
//
//  Copyright (c) 2013 Sam Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVICE_LIST @"serviceList"
#define SERVICE @"service"
#define SERVICE_TYPE @"serviceType"
#define SERVICE_ID @"serviceId"
#define SCPDURL @"SCPDURL"
#define CONTROL_PROTOCOL @"controlProtocol"
#define CONTROL_PORT @"controlPort"
#define CONTROL_URL @"controlURL"
#define EVENT_SUB_URL @"eventSubURL"

@interface SSDPDeviceService : NSObject {
    NSString *mServiceType;
    NSString *mServiceId;
    NSString *mSCPDURL;
    NSString *mControlProtocol;
    NSString *mControlPort;
    NSString *mControlURL;
    NSString *mEventSubURL;
}

@property (strong, nonatomic) NSString *mServiceType;
@property (strong, nonatomic) NSString *mServiceId;
@property (strong, nonatomic) NSString *mSCPDURL;
@property (strong, nonatomic) NSString *mControlProtocol;
@property (strong, nonatomic) NSString *mControlPort;
@property (strong, nonatomic) NSString *mControlURL;
@property (strong, nonatomic) NSString *mEventSubURL;

@end
