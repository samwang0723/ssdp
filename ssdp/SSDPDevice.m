//
//  SSDPDevice.m
//  NetworkHandler
//
//  Copyright (c) 2013 Sam Wang. All rights reserved.
//

#import "SSDPDevice.h"

@implementation SSDPDevice

@synthesize mFriendlyName;
@synthesize mDeviceType;
@synthesize mModelDescription;
@synthesize mModelName;
@synthesize mSerialNumber;
@synthesize mPresentationURL;
@synthesize mUDN;
@synthesize mIconList;
@synthesize mServiceList;

- (id)init
{
    self = [super init];
    if (self != nil) {
        mIconList = [[NSMutableArray alloc] init];
        mServiceList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
