/*!
 *  @header    AppsfireAdSDK.h
 *  @abstract  Appsfire Advertising SDK Header
 *  @version   2.1.0
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppsfireSDKConstants.h"

/*!
 *  Advertising SDK protocol. Provides various events about library life and ads.
 */
@protocol AppsfireAdSDKDelegate <NSObject>

@optional

/*!
 *  @brief Called when the library is initialized.
 */
- (void)adUnitDidInitialize;

/*!
 *  @brief Called when there is a modal ad available,
 *  even if there are some pending requests (before handling the requests queue).
 */
- (void)modalAdIsReadyForRequest;

/*!
 *  @brief Called when a modal ad is going to be presented on the screen.
 *  Depending the state of your application, you may want to cancel the display of the ad.
 *
 *  @return `YES` if you authorize the ad to display, `NO` if the ad shouldn't display.
 *  If this method isn't implemented, the default value is `YES`.
 *  If you return `NO`, the request will be canceled and an error will be fired through `modalAdRequestDidFailWithError:`
 */
- (BOOL)shouldDisplayModalAd;

/*!
 *  @brief Called when a modal ad failed to present.
 *  You can use the code in the NSError to analyze precisely what went wrong.
 *
 *  @param error The error object filled with the appropriate 'code' and 'localizedDescription'.
 */
- (void)modalAdRequestDidFailWithError:(NSError *)error;

/*!
 *  @brief Called when the modal ad is going to be presented.
 */
- (void)modalAdWillAppear;

/*!
 *  @brief Called when the modal ad was presented.
 */
- (void)modalAdDidAppear;

/*!
 *  @brief Called when the modal ad is going to be dismissed.
 *
 *  @note In case of in-app download, the method is called when the last modal disappears.
 */
- (void)modalAdWillDisappear;

/*!
 *  @brief Called when the modal ad was dismissed.
 */
- (void)modalAdDidDisappear;

@end


/*!
 *  Advertising SDK top-level class.
 */
@interface AppsfireAdSDK : NSObject

/** @name Library life
 *  Methods about the general life of the library.
 */

/*!
 *  @brief Green light so the library can prepare itself.
 *
 *  @note If not already done, this method is automatically called at during a modal ad request.
 */
+ (void)prepare;

/*!
 *  @brief Ask if Ad SDK is initialized
 *
 *  @note There are various checks like waiting for Appboster SDK initialization, internet connection ...
 *  Usually the library is quickly initialized ( < 1s ).
 *
 *  @return `YES` if the library is initialized, `NO` if the library isn't yet.
 */
+ (BOOL)isInitialized;

/*!
 *  @brief Ask if ads are loaded from the web service
 *
 *  @note This doesn't necessarily means that an ad is available.
 *  But it's always good to know if you want to debug the implementation and check that the web service responded correctly.
 *
 *  @return `YES` if ads are loaded from the web service.
 */
+ (BOOL)areAdsLoaded;


/** @name Options
 *  Methods for general options of the library.
 */

/*!
 *  @brief Specify the delegate to handle various interactions with the library.
 *
 *  @param delegate The pointer to the class that will handle the library events, or `nil` if none.
 */
+ (void)setDelegate:(id<AppsfireAdSDKDelegate>)delegate;

/*!
 *  @brief Specify if the library should use the in-app overlay when possible.
 *
 *  @note If the client does not have iOS6+, it will be redirected to the App Store app.
 *
 *  @param use A boolean to specify the choice.
 */
+ (void)setUseInAppDownloadWhenPossible:(BOOL)use;

/*!
 *  @brief Specify if the library should be used in debug mode.
 *
 *  @note Whenever this mode is enabled, the web service will return a fake ad.
 *  By default, this mode is disabled. You must decide if you want to enable the debug mode before any prepare/request.
 *
 *  @param use A boolean to specify if the debug mode should be enabled.
 */
+ (void)setDebugModeEnabled:(BOOL)use;


/** @name Modal Ad
 *  Methods for managing Modal Ad.
 */

/*!
 *  @brief Request a modal ad.
 *
 *  @note If the library isn't initialized, or if the ads aren't loaded yet, then the request will be added to a queue and treated as soon as possible.
 *  You cannot request two ad modals at the same time. In the case where you already have a modal request in the queue, the previous one will be canceled.
 *
 *  @param modalType The kind of modal you want to request.
 *  @param controller A controller that will be used to display the various components. We recommend you specify the root controller or your application.
 *  If you don't specify a controller, the request will be aborted.
 */
+ (void)requestModalAd:(AFAdSDKModalType)modalType withController:(UIViewController *)controller;

/*!
 *  @brief Ask if ads are loaded and if there is at least one modal ad available
 *
 *  @note If ads aren't downloaded yet, then the method will return `NO`.
 *  To test the library, and then have a positive response, please use the "debug" mode.
 *
 *  @param modalType The kind of modal you want to check.
 *  Note that most of ads should be available for both formats.
 *
 *  @return `YES` if ads are loaded and if there is at least one modal ad available, `NO` otherwise.
 */
+ (BOOL)isThereAModalAdAvailable:(AFAdSDKModalType)modalType;

/*!
 *  @brief Cancel any pending ad modal request you have made in the past.
 *
 *  @return `YES` if a modal ad was canceled, `NO` otherwise.
 *  If `YES` is returned, you'll get an delegate event via 'modalAdRequestDidFailWithError:'.
 */
+ (BOOL)cancelPendingAdModalRequest;

/*!
 *  @brief Check if there is any modal ad being displayed right now by the library.
 *
 *  @return `YES` if a modal ad is being displayed, `NO` otherwise
 */
+ (BOOL)isModalAdDisplayed;



/** @name Deprecated
 *  Methods that you should stop using, and that will be removed in future release
 */

+ (NSString *)getAdUnitVersion __deprecated_msg("Since the merge with AppsfireSDK, we suggest you to use 'getAFSDKVersionInfo' of AppsfireSDK.");

+ (void)requestModalAdWithController:(UIViewController *)controller __deprecated_msg("You can now specify the modal type. Please check 'requestModalAd:withController:' method.");

+ (BOOL)isThereAModalAdAvailable __deprecated_msg("You can now specify the modal type. Please check 'isThereAModalAdAvailable:' method.");

@end
