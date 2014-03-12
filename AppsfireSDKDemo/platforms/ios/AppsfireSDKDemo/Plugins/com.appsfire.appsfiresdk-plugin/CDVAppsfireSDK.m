
/*
 Copyright 2010-2013 Appsfire SAS. All rights reserved.
 
 Redistribution and use in source and binary forms, without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.
 
 THIS SOFTWARE IS PROVIDED BY APPSFIRE SAS ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL APPSFIRE SAS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CDVAppsfireSDK.h"

static NSString *const kOpenNotificationDidFinishCallbackId = @"kOpenNotificationDidFinishCallbackId";

@interface CDVAppsfireSDK () <AppsfireSDKDelegate, AppsfireAdSDKDelegate>

- (UIColor *)colorWithRGBADictionary:(NSDictionary *)dict;

@end

@implementation CDVAppsfireSDK

- (void)pluginInitialize {
    [super pluginInitialize];
    
    [AppsfireSDK setDelegate:self];
    [AppsfireAdSDK setDelegate:self];
}

#pragma mark -
#pragma mark - Base SDK

- (void)sdk_connectWithApiKey:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray* arguments = command.arguments;
    
    // Arguments
    NSString *apiKey = [arguments objectAtIndex:AFConnectWithAPIKey];
    
    if ([apiKey isKindOfClass:NSString.class]) {
        if ([AppsfireSDK connectWithAPIKey:apiKey]) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
            return;
        }
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_isInitialized:(CDVInvokedUrlCommand *)command {
    BOOL isInitialized = [AppsfireSDK isInitialized];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isInitialized];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_registerPushToken:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSString *pushToken = [arguments objectAtIndex:AFRegisterPushToken];
    
    if (![pushToken isKindOfClass:NSString.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireSDK registerPushTokenString:pushToken];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_handleBadgeCountLocally:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *handleBadgeCountLocally = [arguments objectAtIndex:AFRegisterPushToken];
    
    if (![handleBadgeCountLocally respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireSDK handleBadgeCountLocally:[handleBadgeCountLocally boolValue]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    return;
}

- (void)sdk_handleBadgeCountLocallyAndRemotely:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *handleBadgeCountLocallyAndRemotely = [arguments objectAtIndex:AFRegisterPushToken];
    
    if (![handleBadgeCountLocallyAndRemotely respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireSDK handleBadgeCountLocallyAndRemotely:[handleBadgeCountLocallyAndRemotely boolValue]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    return;
}

- (void)sdk_presentPanel:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray* arguments = command.arguments;
    
    // Arguments
    NSString *contentTypeString = [arguments objectAtIndex:AFPresentPanelContentType];
    NSString *styleTypeString = [arguments objectAtIndex:AFPresentPanelStyleType];
    
    if (![contentTypeString isKindOfClass:NSString.class] || ![styleTypeString isKindOfClass:NSString.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    NSUInteger contentType = 0;
    NSUInteger styleType = 0;
    
    // Content Type
    if ([contentTypeString isEqualToString:@"notifications"]) {
        contentType = AFSDKPanelContentDefault;
    }
    
    else if ([contentTypeString isEqualToString:@"feedback"]) {
        contentType = AFSDKPanelContentFeedbackOnly;
    }
    
    // Style Type
    if ([styleTypeString isEqualToString:@"default"]) {
        styleType = AFSDKPanelStyleDefault;
    }
    
    else if ([styleTypeString isEqualToString:@"fullscreen"]) {
        styleType = AFSDKPanelStyleFullscreen;
    }
    
    NSError *error = [AppsfireSDK presentPanelForContent:contentType withStyle:styleType];
    CDVCommandStatus commandStatus = error ? CDVCommandStatus_ERROR : CDVCommandStatus_OK;
    
    pluginResult = [CDVPluginResult resultWithStatus:commandStatus];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_dismissPanel:(CDVInvokedUrlCommand *)command {
    if ([AppsfireSDK isDisplayed]) {
        [AppsfireSDK dismissPanel];
    }
}

- (void)sdk_isDisplayed:(CDVInvokedUrlCommand *)command {
    BOOL isDisplayed = [AppsfireSDK isDisplayed];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isDisplayed];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_openSDKNotification:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray* arguments = command.arguments;
    
    // Arguments
    NSNumber *notificationId = [arguments objectAtIndex:AFNotificationId];
    
    if (![notificationId isKindOfClass:NSNumber.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireSDK openSDKNotificationID:notificationId.intValue];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_customizeColors:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    
    // Arguments
    NSDictionary *bgColorDic = [arguments objectAtIndex:AFBackgroundColor];
    NSDictionary *textColorDic = [arguments objectAtIndex:AFTextColor];
    
    UIColor *bgColor = [[UIColor alloc] init];
    if ([bgColorDic isKindOfClass:NSDictionary.class]) {
        bgColor = [self colorWithRGBADictionary:bgColorDic];
    }
    
    UIColor *textColor = [[UIColor alloc] init];
    if ([textColorDic isKindOfClass:NSDictionary.class]) {
        textColor = [self colorWithRGBADictionary:textColorDic];
    }
    
    [AppsfireSDK setBackgroundColor:bgColor textColor:textColor];
}

- (void)sdk_setCustomKeyValues:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSDictionary *customKeyValues = [arguments objectAtIndex:AFCustomKeyValues];
    
    if (![customKeyValues isKindOfClass:NSDictionary.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireSDK setCustomKeysValues:customKeyValues];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_setUserEmail:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSString *userEmail = [arguments objectAtIndex:AFUserEmailString];
    NSNumber *isModifiable = [arguments objectAtIndex:AFUserEmailModifiable];
    
    if (![userEmail isKindOfClass:NSString.class] || ![isModifiable respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    BOOL isUserEmailSet = [AppsfireSDK setUserEmail:userEmail isModifiable:[isModifiable boolValue]];
    CDVCommandStatus commandStatus = isUserEmailSet ? CDVCommandStatus_OK : CDVCommandStatus_ERROR;
    
    pluginResult = [CDVPluginResult resultWithStatus:commandStatus];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_showFeedbackButton:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *showFeedBackButton = [arguments objectAtIndex:AFShowFeedBackButton];
    
    if (![showFeedBackButton respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireSDK setShowFeedbackButton:[showFeedBackButton boolValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_getAFSDKVersionInfo:(CDVInvokedUrlCommand *)command {
    NSString *sdkVersion = [AppsfireSDK getAFSDKVersionInfo];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:sdkVersion];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_numberOfPendingNotifications:(CDVInvokedUrlCommand *)command {
    NSInteger numberOfPendingNotifications = [AppsfireSDK numberOfPendingNotifications];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:numberOfPendingNotifications];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_getSessionID:(CDVInvokedUrlCommand *)command {
    NSString *sessionID = [AppsfireSDK getSessionID];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:sessionID];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)sdk_resetCache:(CDVInvokedUrlCommand *)command {
    [AppsfireSDK resetCache];
}

#pragma mark - AppsfireSDKDelegate

- (void)openNotificationDidFinish:(BOOL)succeeded withError:(NSError *)error {
    if (succeeded) {
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_openNotificationDidFinishWithSuccess');"];
    }
    
    else {
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_openNotificationDidFinishWithFailure');"];
    }
}


#pragma mark -
#pragma mark - Ad SDK

- (void)adsdk_prepare:(CDVInvokedUrlCommand *)command {
    [AppsfireAdSDK prepare];
}

- (void)adsdk_isInitialized:(CDVInvokedUrlCommand *)command {
    BOOL isInitialized = [AppsfireAdSDK isInitialized];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isInitialized];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)adsdk_areAdsLoaded:(CDVInvokedUrlCommand *)command {
    BOOL areAdsLoaded = [AppsfireAdSDK areAdsLoaded];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:areAdsLoaded];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)adsdk_setUseInAppDownloadWhenPossible:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *useInAppDownload = [arguments objectAtIndex:AFUseInAppDownloadWhenPossible];
    
    if (![useInAppDownload respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireAdSDK setUseInAppDownloadWhenPossible:[useInAppDownload boolValue]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)adsdk_setDebugModeEnabled:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *debugModeEnabled = [arguments objectAtIndex:AFAdDebugEnabled];
    
    if (![debugModeEnabled respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireAdSDK setDebugModeEnabled:[debugModeEnabled boolValue]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)adsdk_requestModalAd:(CDVInvokedUrlCommand *)command {
    NSArray* arguments = command.arguments;
    
    AFAdSDKModalType modalType = AFAdSDKModalTypeSushi;
    
    // Arguments
    NSString *modalTypeString = [arguments objectAtIndex:AFAdRequestModalType];
    NSNumber *shouldUseTimer = [arguments objectAtIndex:AFAdRequestShouldUseTimer];
    
    // Modal type
    if ([modalTypeString isKindOfClass:NSString.class]) {
        if ([modalTypeString isEqualToString:@"sushi"]) {
            modalType = AFAdSDKModalTypeSushi;
        }
        
        else if ([modalTypeString isEqualToString:@"uramaki"]) {
            modalType = AFAdSDKModalTypeUraMaki;
        }
    }
    
    // Should use timer.
    if (![shouldUseTimer isKindOfClass:NSNumber.class]) {
        shouldUseTimer = @(0);
    }
    
    // Showing a timer befor presenting the Ad.
    if ([shouldUseTimer boolValue]) {
        [[[AppsfireAdTimerView alloc] initWithCountdownStart:3] presentWithCompletion:^(BOOL accepted) {
            if (accepted) {
                [AppsfireAdSDK requestModalAd:modalType withController:self.viewController];
            }
        }];
    }
    
    // Simply showing the Ad.
    else {
        [AppsfireAdSDK requestModalAd:modalType withController:self.viewController];
    }
}

- (void)adsdk_isThereAModalAdAvailable:(CDVInvokedUrlCommand *)command {
    
    NSArray* arguments = command.arguments;
    
    AFAdSDKModalType modalType = AFAdSDKModalTypeSushi;
    
    // Arguments
    NSString *modalTypeString = [arguments objectAtIndex:AFAdRequestModalType];
    
    // Modal type
    if ([modalTypeString isKindOfClass:NSString.class]) {
        if ([modalTypeString isEqualToString:@"sushi"]) {
            modalType = AFAdSDKModalTypeSushi;
        }
        
        else if ([modalTypeString isEqualToString:@"uramaki"]) {
            modalType = AFAdSDKModalTypeUraMaki;
        }
    }
    
    AFAdSDKAdAvailability availability = [AppsfireAdSDK isThereAModalAdAvailableForType:modalType];
    BOOL isModalAvailable = (availability == AFAdSDKAdAvailabilityYes);
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isModalAvailable];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)adsdk_cancelPendingAdModalRequest:(CDVInvokedUrlCommand *)command {
    [AppsfireAdSDK cancelPendingAdModalRequest];
}

- (void)adsdk_isModalAdDisplayed:(CDVInvokedUrlCommand *)command {
    BOOL isModalAdDisplayed = [AppsfireAdSDK isModalAdDisplayed];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isModalAdDisplayed];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark - AppsfireAdSDKDelegate

- (void)adUnitDidInitialize {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_adUnitDidInitialize');"];
}

- (void)modalAdIsReadyForRequest {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_modalAdIsReadyForRequest');"];
}

- (void)modalAdRequestDidFailWithError:(NSError *)error {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_modalAdRequestDidFail');"];
}

- (void)modalAdWillAppear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_modalAdWillAppear');"];
}

- (void)modalAdDidAppear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_modalAdDidAppear');"];
}

- (void)modalAdWillDisappear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_modalAdWillDisappear');"];
}

- (void)modalAdDidDisappear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('adsdk_modalAdDidDisappear');"];
}

#pragma mark - UIColor

- (UIColor *)colorWithRGBADictionary:(NSDictionary *)dict {
    
    NSNumber *redNum = dict[@"r"];
    CGFloat red = 0.0;
    if ([redNum respondsToSelector:@selector(floatValue)]) {
        red = [redNum floatValue] / 255.0;
    }
    
    NSNumber *greenNum = dict[@"g"];
    CGFloat green = 0.0;
    if ([greenNum respondsToSelector:@selector(floatValue)]) {
        green = [greenNum floatValue] / 255.0;
    }
    
    NSNumber *blueNum = dict[@"b"];
    CGFloat blue = 0.0;
    if ([blueNum respondsToSelector:@selector(floatValue)]) {
        blue = [blueNum floatValue] / 255.0;
    }
    
    NSNumber *alphaNum = dict[@"a"];
    CGFloat alpha = 0;
    if ([alphaNum respondsToSelector:@selector(floatValue)]) {
        alpha = [alphaNum floatValue];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
