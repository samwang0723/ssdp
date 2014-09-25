//
//  SSDPDeviceParser.m
//  NetworkHandler
//
//  Copyright (c) 2013 Sam Wang. All rights reserved.
//

#import "SSDPDeviceParser.h"

@implementation SSDPDeviceParser

@synthesize device;

- (void) parseSSDPDevice:(NSString *)response
{
    if(device != nil){
        NSData *xmlData = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSXMLParser *parse = [[NSXMLParser alloc] initWithData:xmlData];
        [parse setDelegate:self];
        [parse parse];
    }else{
        NSLog(@"Please init SSDPDevice first !");
    }
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if ([elementName isEqualToString:DEVICE]) {
        isDeviceStart = YES;
    }else if (isDeviceStart && [elementName isEqualToString:FRIENDLY_NAME]) {
        isFriendlyNameStart = YES;
        mFriendlyName = [[NSMutableString alloc] init];
    }else if (isDeviceStart && [elementName isEqualToString:DEVICE_TYPE]) {
        isDeviceTypeStart = YES;
        mDeviceType = [[NSMutableString alloc] init];
    }else if (isDeviceStart && [elementName isEqualToString:MODEL_DESCRIPTION]) {
        isModelDescriptionStart = YES;
        mModelDescription = [[NSMutableString alloc] init];
    }else if (isDeviceStart && [elementName isEqualToString:MODEL_NAME]) {
        isModelNameStart = YES;
        mModelName = [[NSMutableString alloc] init];
    }else if (isDeviceStart && [elementName isEqualToString:SERIAL_NUMBER]) {
        isSerialNumberStart = YES;
        mSerialNumber = [[NSMutableString alloc] init];
    }else if (isDeviceStart && [elementName isEqualToString:UDN]) {
        isUDNStart = YES;
        mUDN = [[NSMutableString alloc] init];
    }else if (isDeviceStart && [elementName isEqualToString:PRESENTATION_URL]) {
        isPresentationURLStart = YES;
        mPresentationURL = [[NSMutableString alloc] init];
    }else if(isDeviceStart && [elementName isEqualToString:ICON]){ // Icon part
        isIconStart = YES;
        mTempIcon = [[SSDPDeviceIcon alloc] init];
    }else if(isDeviceStart && isIconStart && [elementName isEqualToString:MIME_TYPE]){
        isMimeTypeStart = YES;
        if(mTempIcon != nil){
            mMimeType = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isIconStart && [elementName isEqualToString:WIDTH]){
        isWidthStart = YES;
        if(mTempIcon != nil){
            mWidth = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isIconStart && [elementName isEqualToString:HEIGHT]){
        isHeightStart = YES;
        if(mTempIcon != nil){
            mHeight = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isIconStart && [elementName isEqualToString:URL]){
        isUrlStart = YES;
        if(mTempIcon != nil){
            mUrl = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && [elementName isEqualToString:SERVICE]){ // Service part
        isServiceStart = YES;
        mTempService = [[SSDPDeviceService alloc] init];
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:SERVICE_TYPE]){
        isServiceTypeStart = YES;
        if(mTempService != nil){
            mServiceType = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:SERVICE_ID]){
        isServiceIdStart = YES;
        if(mTempService != nil){
            mServiceId = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:SCPDURL]){
        isSCPDURLStart = YES;
        if(mTempService != nil){
            mSCPDURL = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:CONTROL_PROTOCOL]){
        isControlProtocolStart = YES;
        if(mTempService != nil){
            mControlProtocol = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:CONTROL_PORT]){
        isControlPortStart = YES;
        if(mTempService != nil){
            mControlPort = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:CONTROL_URL]){
        isControlURLStart = YES;
        if(mTempService != nil){
            mControlURL = [[NSMutableString alloc] init];
        }
    }else if(isDeviceStart && isServiceStart && [elementName isEqualToString:EVENT_SUB_URL]){
        isEventSubURLStart = YES;
        if(mTempService != nil){
            mEventSubURL = [[NSMutableString alloc] init];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(isFriendlyNameStart){
        [mFriendlyName appendString:string];
    }else if(isDeviceTypeStart){
        [mDeviceType appendString:string];
    }else if(isModelDescriptionStart){
        [mModelDescription appendString:string];
    }else if(isModelNameStart){
        [mModelName appendString:string];
    }else if(isSerialNumberStart){
        [mSerialNumber appendString:string];
    }else if(isUDNStart){
        [mUDN appendString:string];
    }else if(isPresentationURLStart){
        [mPresentationURL appendString:string];
    }else if(isMimeTypeStart){
        [mMimeType appendString:string];
    }else if(isWidthStart){
        [mWidth appendString:string];
    }else if(isHeightStart){
        [mHeight appendString:string];
    }else if(isUrlStart){
        [mUrl appendString:string];
    }else if(isServiceTypeStart){
        [mServiceType appendString:string];
    }else if(isServiceIdStart){
        [mServiceId appendString:string];
    }else if(isSCPDURLStart){
        [mSCPDURL appendString:string];
    }else if(isControlProtocolStart){
        [mControlProtocol appendString:string];
    }else if(isControlPortStart){
        [mControlPort appendString:string];
    }else if(isControlURLStart){
        [mControlURL appendString:string];
    }else if(isEventSubURLStart){
        [mEventSubURL appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{    
    if ([elementName isEqualToString:DEVICE] && isDeviceStart == YES) {
        isDeviceStart = NO;
    }else if ([elementName isEqualToString:FRIENDLY_NAME] && isDeviceStart == YES && isFriendlyNameStart) {
        isFriendlyNameStart = NO;
        [device setMFriendlyName:mFriendlyName];
    }else if ([elementName isEqualToString:DEVICE_TYPE] && isDeviceStart == YES && isDeviceTypeStart) {
        isDeviceTypeStart = NO;
        [device setMDeviceType:mDeviceType];
    }else if ([elementName isEqualToString:MODEL_DESCRIPTION] && isDeviceStart == YES && isModelDescriptionStart) {
        isModelDescriptionStart = NO;
        [device setMModelDescription:mModelDescription];
    }else if ([elementName isEqualToString:MODEL_NAME] && isDeviceStart == YES && isModelNameStart) {
        isModelNameStart = NO;
        [device setMModelName:mModelName];
    }else if ([elementName isEqualToString:SERIAL_NUMBER] && isDeviceStart == YES && isSerialNumberStart) {
        isSerialNumberStart = NO;
        [device setMSerialNumber:mSerialNumber];
    }else if ([elementName isEqualToString:UDN] && isDeviceStart == YES && isUDNStart) {
        isUDNStart = NO;
        [device setMUDN:mUDN];
    }else if ([elementName isEqualToString:PRESENTATION_URL] && isDeviceStart == YES && isPresentationURLStart) {
        isPresentationURLStart = NO;
        [device setMPresentationURL:mPresentationURL];
    }else if([elementName isEqualToString:MIME_TYPE] && isDeviceStart == YES && isMimeTypeStart){
        isMimeTypeStart = NO;
        if(mTempIcon != nil){
            [mTempIcon setMMimeType:mMimeType];
        }
    }else if([elementName isEqualToString:WIDTH] && isDeviceStart == YES && isWidthStart){
        isWidthStart = NO;
        if(mTempIcon != nil){
            [mTempIcon setMWidth:mWidth];
        }
    }else if([elementName isEqualToString:HEIGHT] && isDeviceStart == YES && isHeightStart){
        isHeightStart = NO;
        if(mTempIcon != nil){
            [mTempIcon setMHeight:mHeight];
        }
    }else if([elementName isEqualToString:URL] && isDeviceStart == YES && isUrlStart){
        isUrlStart = NO;
        if(mTempIcon != nil){
            [mTempIcon setMUrl:mUrl];
        }
    }else if([elementName isEqualToString:ICON] && isDeviceStart == YES && isIconStart){
        isIconStart = NO;
        if(mTempIcon != nil && [device mIconList] != nil){
            [[device mIconList] addObject:mTempIcon];
        }
    }else if([elementName isEqualToString:SERVICE] && isDeviceStart == YES && isServiceStart){
        isServiceStart = NO;
        if(mTempService != nil && [device mServiceList] != nil){
            [[device mServiceList] addObject:mTempService];
        }
    }else if([elementName isEqualToString:SERVICE_TYPE] && isDeviceStart == YES && isServiceTypeStart){
        isServiceTypeStart = NO;
        if(mTempService != nil){
            [mTempService setMServiceType:mServiceType];
        }
    }else if([elementName isEqualToString:SERVICE_ID] && isDeviceStart == YES && isServiceIdStart){
        isServiceIdStart = NO;
        if(mTempService != nil){
            [mTempService setMServiceId:mServiceId];
        }
    }else if([elementName isEqualToString:SCPDURL] && isDeviceStart == YES && isSCPDURLStart){
        isSCPDURLStart = NO;
        if(mTempService != nil){
            [mTempService setMSCPDURL:mSCPDURL];
        }
    }else if([elementName isEqualToString:CONTROL_PROTOCOL] && isDeviceStart == YES && isControlProtocolStart){
        isControlProtocolStart = NO;
        if(mTempService != nil){
            [mTempService setMControlProtocol:mControlProtocol];
        }
    }else if([elementName isEqualToString:CONTROL_PORT] && isDeviceStart == YES && isControlPortStart){
        isControlPortStart = NO;
        if(mTempService != nil){
            [mTempService setMControlPort:mControlPort];
        }
    }else if([elementName isEqualToString:CONTROL_URL] && isDeviceStart == YES && isControlURLStart){
        isControlURLStart = NO;
        if(mTempService != nil){
            [mTempService setMControlURL:mControlURL];
        }
    }else if([elementName isEqualToString:EVENT_SUB_URL] && isDeviceStart == YES && isEventSubURLStart){
        isEventSubURLStart = NO;
        if(mTempService != nil){
            [mTempService setMEventSubURL:mEventSubURL];
        }
    }
} 

@end
