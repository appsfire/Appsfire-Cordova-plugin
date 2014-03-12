
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
