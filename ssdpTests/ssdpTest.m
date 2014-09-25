//
//  ssdpTest.m
//  ssdp
//
//  Created by Sam Wang on 9/25/14.
//  Copyright (c) 2014 Sam Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SSDPSocket.h"

@interface ssdpTest : XCTestCase {
    SSDPSocket *mSSDPSock;
    BOOL hasReceived;
}

@end

@implementation ssdpTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    hasReceived = NO;
    
    mSSDPSock = [[SSDPSocket alloc] init];
    mSSDPSock.delegate = self;
    [mSSDPSock initSSDPSocket];
    [mSSDPSock sendSearchRequest];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    if(mSSDPSock != nil){
        [mSSDPSock closeSSDPSocket];
        mSSDPSock = nil;
    }
    
    [super tearDown];
}

- (void)testExecute {
    sleep(20);
    XCTAssert(hasReceived, @"Receive SSDP packets!");
}

#pragma mark SSDP parts
- (void) didReceiveDeviceInfoUrl: (NSString *)url
{
    NSLog(@"didReceiveDeviceInfoUrl: \"%@\"", url);
    hasReceived = YES;
}

@end
