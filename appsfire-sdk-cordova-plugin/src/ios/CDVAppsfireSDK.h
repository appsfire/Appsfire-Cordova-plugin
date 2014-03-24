
// Cordova
#import <Cordova/CDVPlugin.h>

// Appsfire SDK
#import "AppsfireSDK.h"
#import "AppsfireSDK+Additions.h"
#import "AppsfireAdSDK.h"
#import "AppsfireAdTimerView.h"

//// Base SDK
// Connection
#define AFConnectWithAPIKey         0

// Features
#define AFSetFeatures               0

// Presentation
#define AFPresentPanelContentType   0
#define AFPresentPanelStyleType     1

// Notifications
#define AFNotificationId            0

// Color customization
#define AFBackgroundColor           0
#define AFTextColor                 1

// Custom Key Values
#define AFCustomKeyValues           0

// User Email
#define AFUserEmailString           0
#define AFUserEmailModifiable       1

// Feedback Button
#define AFShowFeedBackButton        0

// Push Token
#define AFRegisterPushToken         0

// Badge Handling
#define AFBadgeHandling             0

//// Ad SDK
// Use In App Download
#define AFUseInAppDownloadWhenPossible  0

// Debug Enabled
#define AFAdDebugEnabled                0

// Request Modal
#define AFAdRequestModalType            0
#define AFAdRequestShouldUseTimer       1

// Modal Available
#define AFAdIsThereAModalAvailable      0

@interface CDVAppsfireSDK : CDVPlugin

// Base SDK
- (void)sdk_connectWithApiKey:(CDVInvokedUrlCommand *)command;
- (void)sdk_setFeatures:(CDVInvokedUrlCommand *)command;
- (void)sdk_isInitialized:(CDVInvokedUrlCommand *)command;
- (void)sdk_registerPushToken:(CDVInvokedUrlCommand *)command;
- (void)sdk_handleBadgeCountLocally:(CDVInvokedUrlCommand *)command;
- (void)sdk_handleBadgeCountLocallyAndRemotely:(CDVInvokedUrlCommand *)command;
- (void)sdk_presentPanel:(CDVInvokedUrlCommand *)command;
- (void)sdk_dismissPanel:(CDVInvokedUrlCommand *)command;
- (void)sdk_isDisplayed:(CDVInvokedUrlCommand *)command;
- (void)sdk_openSDKNotification:(CDVInvokedUrlCommand *)command;
- (void)sdk_customizeColors:(CDVInvokedUrlCommand *)command;
- (void)sdk_setCustomKeyValues:(CDVInvokedUrlCommand *)command;
- (void)sdk_setUserEmail:(CDVInvokedUrlCommand *)command;
- (void)sdk_showFeedbackButton:(CDVInvokedUrlCommand *)command;
- (void)sdk_getAFSDKVersionInfo:(CDVInvokedUrlCommand *)command;
- (void)sdk_numberOfPendingNotifications:(CDVInvokedUrlCommand *)command;
- (void)sdk_getSessionID:(CDVInvokedUrlCommand *)command;
- (void)sdk_resetCache:(CDVInvokedUrlCommand *)command;

// Ad SDK
- (void)adsdk_prepare:(CDVInvokedUrlCommand *)command;
- (void)adsdk_isInitialized:(CDVInvokedUrlCommand *)command;
- (void)adsdk_areAdsLoaded:(CDVInvokedUrlCommand *)command;
- (void)adsdk_setUseInAppDownloadWhenPossible:(CDVInvokedUrlCommand *)command;
- (void)adsdk_setDebugModeEnabled:(CDVInvokedUrlCommand *)command;
- (void)adsdk_requestModalAd:(CDVInvokedUrlCommand *)command;
- (void)adsdk_isThereAModalAdAvailable:(CDVInvokedUrlCommand *)command;
- (void)adsdk_cancelPendingAdModalRequest:(CDVInvokedUrlCommand *)command;
- (void)adsdk_isModalAdDisplayed:(CDVInvokedUrlCommand *)command;

@end
