/*!
 *  @header    AppsfireEngageSDK+Additions.h
 *  @abstract  Appsfire Engage SDK Additions Header
 *  @version   2.5.1
 */

#import "AppsfireEngageSDK.h"

@interface AppsfireEngageSDK (Additions)

/*!
 *  @brief Register the push token for APNS (Apple Push Notification Service).
 *
 *  @note You should call this method in the "application:didRegisterForRemoteNotificationsWithDeviceToken:" method in your application delegate.
 *
 *  @param deviceToken NSString representation of the push token.
 */
+ (void)registerPushTokenString:(NSString *)deviceTokenString;

@end
