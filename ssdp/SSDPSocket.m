//
//  SSDPSocket.m
//  SSDPScoket
//
//  Created by Mike on 1/11/13.
//  Copyright (c) 2013 Mike. All rights reserved.
//

#import "SSDPSocket.h"

@implementation SSDPSocket

@synthesize delegate;

- (void)initSSDPSocket
{    
	udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
	NSError *error = nil;

    [udpSocket enableBroadcast:TRUE error:nil];
	if (![udpSocket bindToPort:SSDP_BROADCAST_PORT error:&error]){
		NSLog(@"Error binding: %@", error);
		return;
	}
	if (![udpSocket beginReceiving:&error]){
		NSLog(@"Error receiving: %@", error);
		return;
	}
    if (![udpSocket joinMulticastGroup:SSDP_BROADCAST_ADDRESS error:&error]){
        NSLog(@"Error joinMulticastGroup: %@", [error localizedDescription]);
		return;
    }
    NSLog(@"SSDP init Ready !!!");
}

-(void) closeSSDPSocket
{
    [udpSocket close];
}

-(void)sendSearchRequest
{
    NSString *search = @"M-SEARCH * HTTP/1.1\r\nHost:239.255.255.250:1900\r\nMan: \"ssdp:discover\"\r\nST:urn:schemas-upnp-org:service:NetworkHandler:1\r\nMX:3\r\n\r\n";
    [udpSocket sendData:[search dataUsingEncoding:NSUTF8StringEncoding]
                      toHost: SSDP_BROADCAST_ADDRESS port: SSDP_BROADCAST_PORT withTimeout:-1 tag:1];
    [udpSocket joinMulticastGroup:SSDP_BROADCAST_ADDRESS error:nil];
    [udpSocket bindToPort:SSDP_BROADCAST_PORT error:nil];
    [udpSocket beginReceiving:nil];
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
        fromAddress:(NSData *)address
        withFilterContext:(id)filterContext
{
	NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	if (msg){
        if(mParsedString == nil){
            mParsedString = [[NSMutableString alloc] init];
        }
        //NSLog(@"(((msg)))= %@", msg);
        if([msg rangeOfString:NOTIFY].location != NSNotFound
           && [msg rangeOfString:SSDP_ALIVE].location != NSNotFound){
            NSArray *info = [msg componentsSeparatedByString:@"\r\n"];
            NSString *url = nil;
            for(NSString *detail in info){
                if([detail rangeOfString:LOCATION].location != NSNotFound){
                    url = [[detail componentsSeparatedByString:LOCATION] objectAtIndex:1];
                    break;
                }else if([detail rangeOfString:LOCATION_2].location != NSNotFound){
                    url = [[detail componentsSeparatedByString:LOCATION_2] objectAtIndex:1];
                    break;
                }
            }
            
            if(url != nil && [mParsedString rangeOfString:[NSString stringWithFormat:@"%@;", url]].location == NSNotFound){
                [mParsedString appendString:[NSString stringWithFormat:@"%@;", url]];
                NSLog(@"(((url)))=%@", url);
                
                // call delegate to notify device url being parsed
                if(self.delegate != nil){
                    [self.delegate didReceiveDeviceInfoUrl:url];
                }
            }
        }
	}else{
		NSString *host = nil;
		uint16_t port = 0;
		[GCDAsyncUdpSocket getHost:&host port:&port fromAddress:address];
		
		NSLog(@"RECV: Unknown message from: %@:%hu", host, port);
	}
}

- (SSDPDevice *) retrieveDeviceInfo:(NSString *)responseData
{
    if(responseData == nil){
        return nil;
    }
    
    SSDPDevice *device = [[SSDPDevice alloc] init];
    SSDPDeviceParser *parser = [[SSDPDeviceParser alloc] init];
    [parser setDevice:device];
    [parser parseSSDPDevice:responseData];
    
    return device;
}

@end
