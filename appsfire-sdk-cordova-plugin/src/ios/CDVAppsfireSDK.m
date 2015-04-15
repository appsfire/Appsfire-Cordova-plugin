/*!
 *  @header    CDVAppsfireSDK.m
 *  @abstract  Cordova Plugin for the Appsfire iOS SDK.
 *  @version   1.0.10
 */

#import "CDVAppsfireSDK.h"

static NSString *const kOpenNotificationDidFinishCallbackId = @"kOpenNotificationDidFinishCallbackId";

@interface CDVAppsfireSDK () <AppsfireEngageSDKDelegate, AppsfireAdSDKDelegate, AFAdSDKModalDelegate>

- (UIColor *)colorWithRGBADictionary:(NSDictionary *)dict;

@end

@implementation CDVAppsfireSDK

- (void)pluginInitialize {
    [super pluginInitialize];
    
    [AppsfireEngageSDK setDelegate:self];
    [AppsfireAdSDK setDelegate:self];
}

#pragma mark - Appsfire SDK

- (void)afsdk_connectWithParameters:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray *arguments = command.arguments;
    
    // SDK Token
    NSString *sdkToken = [arguments objectAtIndex:AFConnectWithParametersSDKToken];
    if (![sdkToken isKindOfClass:NSString.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    // Secret Key
    NSString *secretKey = [arguments objectAtIndex:AFConnectWithParametersSecretKey];
    if (![secretKey isKindOfClass:NSString.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    // Features
    NSArray *features = [arguments objectAtIndex:AFConnectWithParametersFeatures];
    
    AFSDKFeature activeFeatures = (AFSDKFeatureEngage|AFSDKFeatureMonetization);
    BOOL isEngageEnabled = NO;
    BOOL isMonetizeEnabled = NO;
    
    if (![features isKindOfClass:NSArray.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    for (NSString *feature in features) {
        if (![feature respondsToSelector:@selector(isEqualToString:)]) {
            continue;
        }
        
        // Check if engage is enabled.
        if ([feature isEqualToString:@"AFSDKFeatureEngage"]) {
            isEngageEnabled = YES;
        }
        
        // Check if monetize is enabled.
        if ([feature isEqualToString:@"AFSDKFeatureMonetization"]) {
            isMonetizeEnabled = YES;
        }
        
    }
    
    if (!isEngageEnabled) {
        activeFeatures ^= AFSDKFeatureEngage;
    }
    
    if (!isMonetizeEnabled) {
        activeFeatures ^= AFSDKFeatureMonetization;
    }
    
    // Intialization
    NSError *error = [AppsfireSDK connectWithSDKToken:sdkToken secretKey:secretKey features:activeFeatures parameters:nil];
    if (error) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    // Everything went fine.
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afsdk_isInitialized:(CDVInvokedUrlCommand *)command {
    BOOL isInitialized = [AppsfireSDK isInitialized];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isInitialized];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afsdk_versionDescription:(CDVInvokedUrlCommand *)command {
    NSString *versionDescription = [AppsfireSDK versionDescription];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:versionDescription];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark - Appsfire Engage SDK

- (void)afengagesdk_registerPushToken:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSString *pushToken = [arguments objectAtIndex:AFRegisterPushToken];
    
    if (![pushToken isKindOfClass:NSString.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireEngageSDK registerPushTokenString:pushToken];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_handleBadgeCountLocally:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *handleBadgeCountLocally = [arguments objectAtIndex:AFRegisterPushToken];
    
    if (![handleBadgeCountLocally respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireEngageSDK handleBadgeCountLocally:[handleBadgeCountLocally boolValue]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    return;
}

- (void)afengagesdk_handleBadgeCountLocallyAndRemotely:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *handleBadgeCountLocallyAndRemotely = [arguments objectAtIndex:AFRegisterPushToken];
    
    if (![handleBadgeCountLocallyAndRemotely respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireEngageSDK handleBadgeCountLocallyAndRemotely:[handleBadgeCountLocallyAndRemotely boolValue]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    return;
}

- (void)afengagesdk_presentPanel:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray *arguments = command.arguments;
    
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
    
    NSError *error = [AppsfireEngageSDK presentPanelForContent:contentType withStyle:styleType];
    CDVCommandStatus commandStatus = error ? CDVCommandStatus_ERROR : CDVCommandStatus_OK;
    
    pluginResult = [CDVPluginResult resultWithStatus:commandStatus];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_dismissPanel:(CDVInvokedUrlCommand *)command {
    if ([AppsfireEngageSDK isDisplayed]) {
        [AppsfireEngageSDK dismissPanel];
    }
}

- (void)afengagesdk_isDisplayed:(CDVInvokedUrlCommand *)command {
    BOOL isDisplayed = [AppsfireEngageSDK isDisplayed];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isDisplayed];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_openSDKNotification:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray *arguments = command.arguments;
    
    // Arguments
    NSNumber *notificationId = [arguments objectAtIndex:AFNotificationId];
    
    if (![notificationId isKindOfClass:NSNumber.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireEngageSDK openSDKNotificationID:notificationId.intValue];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_customizeColors:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    
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
    
    [AppsfireEngageSDK setBackgroundColor:bgColor textColor:textColor];
}

- (void)afengagesdk_setCustomKeyValues:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSDictionary *customKeyValues = [arguments objectAtIndex:AFCustomKeyValues];
    
    if (![customKeyValues isKindOfClass:NSDictionary.class]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireEngageSDK setCustomKeysValues:customKeyValues];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_setUserEmail:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
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
    
    BOOL isUserEmailSet = [AppsfireEngageSDK setUserEmail:userEmail isModifiable:[isModifiable boolValue]];
    CDVCommandStatus commandStatus = isUserEmailSet ? CDVCommandStatus_OK : CDVCommandStatus_ERROR;
    
    pluginResult = [CDVPluginResult resultWithStatus:commandStatus];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_showFeedbackButton:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult;
    
    // Arguments
    NSNumber *showFeedBackButton = [arguments objectAtIndex:AFShowFeedBackButton];
    
    if (![showFeedBackButton respondsToSelector:@selector(boolValue)]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return;
    }
    
    [AppsfireEngageSDK setShowFeedbackButton:[showFeedBackButton boolValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afengagesdk_numberOfPendingNotifications:(CDVInvokedUrlCommand *)command {
    int numberOfPendingNotifications = (int)[AppsfireEngageSDK numberOfPendingNotifications];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:numberOfPendingNotifications];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark - Appsfire Ad SDK

- (void)afadsdk_areAdsLoaded:(CDVInvokedUrlCommand *)command {
    BOOL areAdsLoaded = [AppsfireAdSDK areAdsLoaded];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:areAdsLoaded];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)afadsdk_setUseInAppDownloadWhenPossible:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
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

- (void)afadsdk_setDebugModeEnabled:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
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

- (void)afadsdk_requestModalAd:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    
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
    
    [AppsfireAdSDK requestModalAd:modalType withController:self.viewController withDelegate:self];
}

- (void)afadsdk_isThereAModalAdAvailable:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    
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

- (void)afadsdk_cancelPendingAdModalRequest:(CDVInvokedUrlCommand *)command {
    [AppsfireAdSDK cancelPendingAdModalRequest];
}

- (void)afadsdk_isModalAdDisplayed:(CDVInvokedUrlCommand *)command {
    BOOL isModalAdDisplayed = [AppsfireAdSDK isModalAdDisplayed];
    NSString *callbackId = command.callbackId;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isModalAdDisplayed];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark - AppsfireEngageSDKDelegate

- (void)openNotificationDidFinish:(BOOL)succeeded withError:(NSError *)error {
    if (succeeded) {
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afengagesdk_openNotificationDidFinishWithSuccess');"];
    } else {
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afengagesdk_openNotificationDidFinishWithFailure');"];
    }
}

#pragma mark - AppsfireAdSDKDelegate

- (void)modalAdsRefreshedAndAvailable {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdsRefreshedAndAvailable');"];
}

- (void)modalAdsRefreshedAndNotAvailable {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdsRefreshedAndNotAvailable');"];
}

#pragma mark - AFAdSDKModalDelegate

- (void)modalAdRequestDidFailWithError:(NSError *)error {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdRequestDidFail');"];
}

- (void)modalAdWillAppear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdWillAppear');"];
}

- (void)modalAdDidAppear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdDidAppear');"];
}

- (void)modalAdWillDisappear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdWillDisappear');"];
}

- (void)modalAdDidDisappear {
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('afadsdk_modalAdDidDisappear');"];
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
