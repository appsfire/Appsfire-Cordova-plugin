/*!
 *  @header    AppsfireSDKConstants.h
 *  @abstract  Appsfire SDK Constants Header
 *  @version   2.1.0
 */

/*!
 *  @brief Names of notifications you can observe in Appsfire SDK
 *  @since 2.0
 */

/** @notification EngageNotification sdk is initializing */
#define kAFSDKIsInitializing                @"AFSDKisInitializing"

/** @notification EngageNotification sdk is initialized */
#define kAFSDKIsInitialized                 @"AFSDKisInitialized"

/** @notification EngageNotification notifications count was updated */
#define kAFSDKNotificationsNumberChanged    @"AFSDKNotificationsNumberChanged"

/** @notification EngageNotification dictionary (localized strings) is updated */
#define kAFSDKDictionaryUpdated             @"AFSDKdictionaryUpdated"

/** @notification EngageNotification panel (for notifications or feedback) was presented */
#define kAFSDKPanelWasPresented             @"AFSDKPanelWasPresented"

/** @notification EngageNotification panel (for notifications or feedback) was dismissed */
#define kAFSDKPanelWasDismissed             @"AFSDKPanelWasDismissed"


/*!
 *  @enum EngageEnum Enum for deciding appsfire sdk presentation style
 *
 *  @note Embedded display allows users to see your application behind.
 *  Fullscreen is like its name, users won't see your application and will be immersed into the sdk.
 *
 *  @since 2.0
 */
typedef NS_ENUM(NSUInteger, AFSDKPanelStyle) {
    /** display on part of the screen so your app is visible behind */
    AFSDKPanelStyleDefault,
    /** display on the whole screen (iPhone/iPod only) */
    AFSDKPanelStyleFullscreen
};


/*!
 *  @enum EngageEnum Enum for deciding appsfire sdk content type
 *  @since 2.0
 *
 *  @note Default displays by default the notifications, but the user can send a feedback too thanks to a button.
 *  'Feedback only' will directly display the feedback form, user won't be able to see notifications list.
 */
typedef NS_ENUM(NSUInteger, AFSDKPanelContent) {
    /** display notifications wall */
    AFSDKPanelContentDefault,
    /** display the feedback form only */
    AFSDKPanelContentFeedbackOnly
};


/*!
 *  @enum AdvertisingEnum Enum for specifying the modal type
 *  @since 2.1
 */
typedef NS_ENUM(NSUInteger, AFAdSDKModalType) {
    /**  */
    AFAdSDKModalTypeSushi = 0,
    /**  */
    AFAdSDKModalTypeUraMaki = 1
};


/*!
 *  @enum CommonEnum Enum for sdk error code.
 *  @since 2.0
 */
typedef NS_ENUM(NSUInteger, AFSDKErrorCode) {
    
    // general
    /** unknown */
    AFSDKErrorCodeUnknown,
    /** library isn't initialized yet */
    AFSDKErrorCodeLibraryNotInitialized,
    /** internet isn't reachable (and is required) */
    AFSDKErrorCodeInternetNotReachable,
    /** you need to set the application delegate to proceed */
    AFSDKErrorCodeNeedsApplicationDelegate,
    
    // advertising sdk
    /** no ad available */
    AFSDKErrorCodeAdvertisingNoAd,
    /** the request call isn't appropriate */
    AFSDKErrorCodeAdvertisingBadCall,
    /** an ad is currently displayed for this format */
    AFSDKErrorCodeAdvertisingAlreadyDisplayed,
    /** the request was canceled by the developer */
    AFSDKErrorCodeAdvertisingCanceledByDevelopper,
    
    // engage sdk
    /** the panel is already displayed */
    AFSDKErrorCodePanelAlreadyDisplayed,
    /** the notification wasn't found */
    AFSDKErrorCodeOpenNotificationNotFound
    
};
