/*!
 *  @header    CDVAppsfireSDK.h
 *  @abstract  Cordova Plugin for the Appsfire iOS SDK.
 *  @version   1.0.7
 */

// Cordova
#import <Cordova/CDVPlugin.h>

// Appsfire SDK
#import "AppsfireSDK.h"
#import "AppsfireAdSDK.h"
#import "AppsfireEngageSDK.h"
#import "AppsfireEngageSDK+Additions.h"

// Connection
#define AFConnectWithParametersSDKToken     0
#define AFConnectWithParametersSecretKey    1
#define AFConnectWithParametersFeatures     2

// Presentation
#define AFPresentPanelContentType       0
#define AFPresentPanelStyleType         1

// Notifications
#define AFNotificationId                0

// Color customization
#define AFBackgroundColor               0
#define AFTextColor                     1

// Custom Key Values
#define AFCustomKeyValues               0

// User Email
#define AFUserEmailString               0
#define AFUserEmailModifiable           1

// Feedback Button
#define AFShowFeedBackButton            0

// Push Token
#define AFRegisterPushToken             0

// Badge Handling
#define AFBadgeHandling                 0

// Use In App Download
#define AFUseInAppDownloadWhenPossible  0

// Debug Enabled
#define AFAdDebugEnabled                0

// Request Modal
#define AFAdRequestModalType            0

// Modal Available
#define AFAdIsThereAModalAvailable      0

@interface CDVAppsfireSDK : CDVPlugin

#pragma mark - Appsfire SDK
- (void)afsdk_connectWithParameters:(CDVInvokedUrlCommand *)command;
- (void)afsdk_isInitialized:(CDVInvokedUrlCommand *)command;
- (void)afsdk_versionDescription:(CDVInvokedUrlCommand *)command;

#pragma mark - Appsfire Engage SDK
- (void)afengagesdk_registerPushToken:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_handleBadgeCountLocally:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_handleBadgeCountLocallyAndRemotely:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_presentPanel:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_dismissPanel:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_isDisplayed:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_openSDKNotification:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_customizeColors:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_setCustomKeyValues:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_setUserEmail:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_showFeedbackButton:(CDVInvokedUrlCommand *)command;
- (void)afengagesdk_numberOfPendingNotifications:(CDVInvokedUrlCommand *)command;

#pragma mark - Appsfire Ad SDK
- (void)afadsdk_areAdsLoaded:(CDVInvokedUrlCommand *)command;
- (void)afadsdk_setUseInAppDownloadWhenPossible:(CDVInvokedUrlCommand *)command;
- (void)afadsdk_setDebugModeEnabled:(CDVInvokedUrlCommand *)command;
- (void)afadsdk_requestModalAd:(CDVInvokedUrlCommand *)command;
- (void)afadsdk_isThereAModalAdAvailable:(CDVInvokedUrlCommand *)command;
- (void)afadsdk_cancelPendingAdModalRequest:(CDVInvokedUrlCommand *)command;
- (void)afadsdk_isModalAdDisplayed:(CDVInvokedUrlCommand *)command;

@end
