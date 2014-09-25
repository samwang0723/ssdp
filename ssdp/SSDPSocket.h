//
//  SSDPSocket.h
//  SSDPScoket
//
//  Created by Mike on 1/11/13.
//  Copyright (c) 2013 Mike. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "SSDPDevice.h"
#import "SSDPDeviceParser.h"

#define SSDP_BROADCAST_ADDRESS @"239.255.255.250"
#define SSDP_BROADCAST_PORT    1900

#define NOTIFY @"NOTIFY"
#define SSDP_ALIVE @"ssdp:alive"
#define LOCATION @"LOCATION: "
#define LOCATION_2 @"Location:"

@protocol SSDPDelegate
- (void) didReceiveDeviceInfoUrl: (NSString *)url;
@end

@interface SSDPSocket : NSObject{
    GCDAsyncUdpSocket *udpSocket;
    NSMutableString *mParsedString;
    id<SSDPDelegate> delegate;
}

@property (retain, nonatomic) id<SSDPDelegate> delegate;

-(void) initSSDPSocket;
-(void) sendSearchRequest;
-(void) closeSSDPSocket;
- (SSDPDevice *) retrieveDeviceInfo:(NSString *)responseData;

@end
