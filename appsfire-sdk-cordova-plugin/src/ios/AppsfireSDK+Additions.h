//
//  AppsfireSDK+Push.h
//  AppsfireSDKDemo
//
//  Created by Ali Karagoz on 30/12/2013.
//
//

#import "AppsfireSDK.h"

@interface AppsfireSDK (Additions)

/*!
 *  @brief Register the push token for APNS (Apple Push Notification Service).
 *
 *  @note You should call this method in the "application:didRegisterForRemoteNotificationsWithDeviceToken:" method in your application delegate.
 *
 *  @param deviceToken NSString representation of the push token.
 */
+ (void)registerPushTokenString:(NSString *)deviceTokenString;

@end
