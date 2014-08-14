cordova.define("com.appsfire.appsfiresdk-plugin.AppsfireSDK", function(require, exports, module) { var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');

var AppsfireSDK = function() {
    this.serviceName = "AppsfireSDK";
};


// Appsfire SDK

/**
 * Initialize the Appsfire SDK.
 *
 * @method afsdk_connectWithParameters
 * @param {String} sdkToken SDK Token.
 * @param {Object} features The array containing the features. The available features are `AFSDKFeatureEngage` and `AFSDKFeatureMonetization`.
 * @param {Callback(void)} successCallback Callback indicating that the SDK did initialize.
 * @param {Callback(void)} failureCallback Callback indicating that the SDK did not initialize.
 */
AppsfireSDK.prototype.afsdk_connectWithParameters = function(sdkToken, features, successCallback, failureCallback) {
    if (typeof(sdkToken) != 'string') sdkToken = '';
    if (typeof(features) != 'object') features = ['AFSDKFeatureEngage', 'AFSDKFeatureMonetization'];
    exec(successCallback, failureCallback, this.serviceName, 'afsdk_connectWithParameters', [sdkToken, features]);
};

/**
 * SDK Initialization status.
 *
 * @param {Callback(isInitializedBoolean)} callback Callback giving the status of the initialization.
 */
AppsfireSDK.prototype.afsdk_isInitialized = function(callback) {
    exec(callback, null, this.serviceName, 'afsdk_isInitialized', []);
};

/**
 * Version description of the Appsfire SDK.
 *
 * @param {Callback(versionString)} callBack Callback giving the version description string.
 */
AppsfireSDK.prototype.afsdk_versionDescription = function(callback) {
    exec(callback, null, this.serviceName, 'afsdk_versionDescription', []);
};

// Appsfire Engage SDK

/**
 * Register the push token for APNS (Apple Push Notification Service).
 *
 * @param {String} pushToken String representation of the push token.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afengagesdk_registerPushToken = function(pushToken, successCallback, failureCallback) {
    if (typeof(pushToken) != 'string') pushToken = 0;
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_registerPushToken', [pushToken]);
};

/**
 * Handle the badge count for this app locally (only on the device and only while the app is alive).
 *
 * @param {Boolean} locally Boolean value to determine if the badge count should be handled locally.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afengagesdk_handleBadgeCountLocally = function(locally, successCallback, failureCallback) {
    if (typeof(locally) != 'boolean') locally = 0;
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_handleBadgeCountLocally', [locally]);
};

/**
 * Handle the badge count for this app remotely (Appsfire Engage SDK will update the icon at all times, locally and remotely, even when app is closed).
 *
 * @param {Boolean} locallyAndRemotely Boolean value to determine if the badge count should be handled locally and remotely.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afengagesdk_handleBadgeCountLocallyAndRemotely = function(locallyAndRemotely, successCallback, failureCallback) {
    if (typeof(locallyAndRemotely) != 'boolean') locallyAndRemotely = 0;
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_handleBadgeCountLocallyAndRemotely', [locallyAndRemotely]);
};

/**
 * Handle the badge count for this app remotely (Appsfire Engage SDK will update the icon at all times, locally and remotely, even when app is closed).
 *
 * @param {String} contentType String value corresponding to the type of the content displayed. Values can be `notifications` or `feedback`.
 * @param {String} styleType String value corresponding to the display type style of the content. Values can be `default` or `fullscreen`.
 * @param {Callback(void)} successCallback Callback indicating that the panel presented successfully.
 * @param {Callback(void)} failureCallback Callback indicating that the panel failed to present.
 */
AppsfireSDK.prototype.afengagesdk_presentPanel = function(contentType, styleType, successCallback, failureCallback) {
    if (typeof(contentType) != 'string') contentType = 'notifications';
    if (typeof(styleType) != 'string') styleType = 'default';
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_presentPanel', [contentType, styleType]);
};

/**
 * Closes the Notification Wall and/or Feedback Form
 */
AppsfireSDK.prototype.afengagesdk_dismissPanel = function() {
    exec(null, null, this.serviceName, 'afengagesdk_dismissPanel', []);
};

/**
 * Gives the display status of the panel.
 *
 * @param {Callback(isDisplayedBoolean)} callback Callback giving the display status of the panel.
 */
AppsfireSDK.prototype.afengagesdk_isDisplayed = function(callback) {
    exec(callback, null, this.serviceName, 'afengagesdk_isDisplayed', []);
};

/**
 * Opens the SDK to a specific notification ID.
 *
 * @param {Number} notificationId Number corresponding to the notification to be presented.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afengagesdk_openSDKNotification = function(notificationId, successCallback, failureCallback) {
    if (typeof(notificationId) != 'number') notificationId = 0;
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_openSDKNotification', [notificationId]);
};

/**
 * Opens the SDK to a specific notification ID.
 *
 * @param {Object} backgroundColor Hash object representation of the color applied to the background.
 * @param {Object} textColor Hash object representation of the color applied to the text.
 *
 * @brief The Hash objects should look like this:
 *    var backgroundColor = {
 *      'r': '144', // value between 0 and 255
 *      'g': '89',  // value between 0 and 255
 *      'b': '55',  // value between 0 and 255
 *      'a': '1.0'  // value between 0 and 1
 *    }
 */
AppsfireSDK.prototype.afengagesdk_customizeColors = function(backgroundColor, textColor) {
    if (typeof(backgroundColor) != 'object') backgroundColor = '{}';
    if (typeof(textColor) != 'object') textColor = '{}';
    exec(null, null, this.serviceName, 'afengagesdk_customizeColors', [backgroundColor, textColor]);
};

/**
 * Send data to SDK in key/value pairs. Strings matching any of your [KEYS] will be replaced by the respective value you send.
 *
 * @param {Number} customKeyValues Number Hash object representation of the custom values sent to the API.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 *
 * @brief The Hash objects should look like this:
 *    var customKeyValues = {
 *      "FIRSTNAME": "John",
 *      "LASTNAME": "Doe",
 *      "AGE": "42"
 *    }
 */
AppsfireSDK.prototype.afengagesdk_setCustomKeyValues = function(customKeyValues, successCallback, failureCallback) {
    if (typeof(customKeyValues) != 'object') customKeyValues = '{}';
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_setCustomKeyValues', [customKeyValues]);
};

/**
 * Preset user email.
 *
 * @param {String} email String corresponding to the email of the user.
 * @param {Boolean} isModifiable Boolean wether the email can be modified by the user.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameters are valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameters are not valid.
 */
AppsfireSDK.prototype.afengagesdk_setUserEmail = function(email, isModifiable, successCallback, failureCallback) {
    if (typeof(email) != 'string') email = '';
    if (typeof(isModifiable) != 'boolean') isModifiable = true;
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_setUserEmail', [email, isModifiable]);
};

/**
 * Allow you to display or hide feedback button.
 *
 * @param {Boolean} showButton Boolean to tell if feedback button should be displayed or not. Default value is `true`.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afengagesdk_showFeedbackButton = function(showButton, successCallback, failureCallback) {
    if (typeof(showButton) != 'boolean') showButton = 'true';
    exec(successCallback, failureCallback, this.serviceName, 'afengagesdk_showFeedbackButton', [showButton]);
};

/**
 * Methods to get various information from the library.
 *
 * @param {Callback(numberOfNotifications)} callback Callback giving the number of notifications.
 */
AppsfireSDK.prototype.afengagesdk_numberOfPendingNotifications = function(callback) {
    exec(callback, null, this.serviceName, 'afengagesdk_numberOfPendingNotifications', []);
};

// Appsfire Ad SDK

/**
 * Ask if ads are loaded from the web service.
 *
 * @param {Callback(areAdsLoadedBoolean)} callback Callback giving the status of ads.
 */
AppsfireSDK.prototype.afadsdk_areAdsLoaded = function(callback) {
    exec(callback, null, this.serviceName, 'afadsdk_areAdsLoaded', []);
};

/**
 * Specify if the library should use the in-app overlay when possible.
 *
 * @param {Boolean} userInAppDownloadWhenPossible Boolean to tell if in-app overlay should be used. Default value is `true`.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afadsdk_setUseInAppDownloadWhenPossible = function(userInAppDownloadWhenPossible, successCallback, failureCallback) {
    if (typeof(userInAppDownloadWhenPossible) != 'boolean') userInAppDownloadWhenPossible = 'true';
    exec(successCallback, failureCallback, this.serviceName, 'afadsdk_setUseInAppDownloadWhenPossible', [userInAppDownloadWhenPossible]);
};

/**
 * Specify if the library should be used in debug mode.
 *
 * @param {Boolean} debugModeEnabled to specify if the debug mode should be enabled. Default value is `false`.
 * @param {Callback(void)} successCallback Callback indicating that the provided parameter is valid.
 * @param {Callback(void)} failureCallback Callback indicating that the provided parameter is not valid.
 */
AppsfireSDK.prototype.afadsdk_setDebugModeEnabled = function(debugModeEnabled, successCallback, failureCallback) {
    if (typeof(debugModeEnabled) != 'boolean') debugModeEnabled = 'true';
    exec(successCallback, failureCallback, this.serviceName, 'afadsdk_setDebugModeEnabled', [debugModeEnabled]);
};

/**
 * Specify if the library should be used in debug mode.
 *
 * @param {Strong} modalType String corresponding to the type of the modal to be used when displaying the interstitial. Values can be `sushi` or `uramaki`.
 */
AppsfireSDK.prototype.afadsdk_requestModalAd = function(modalType) {
    if (typeof(modalType) != 'string') modalType = 'sushi';
    exec(null, null, this.serviceName, 'afadsdk_requestModalAd', [modalType]);
};

/**
 * Ask if ads are loaded and if there is at least one modal ad available.
 *
 * @param {String} modalType String corresponding to the type of modal that needs to be checked.
 * @param {Callback(isThereAModalAdAvailableBoolean)} callback Callback giving the status of the modal ad availability.
 */
AppsfireSDK.prototype.afadsdk_isThereAModalAdAvailable = function(modalType, callback) {
    if (typeof(modalType) != 'string') modalType = 'sushi';
    exec(callback, null, this.serviceName, 'afadsdk_isThereAModalAdAvailable', [modalType]);
};

/**
 * Cancel any pending notification.
 */
AppsfireSDK.prototype.afadsdk_cancelPendingAdModalRequest = function() {
    exec(null, null, this.serviceName, 'afadsdk_cancelPendingAdModalRequest', []);
};

/**
 * Check if there is any modal ad being displayed right now by the library.
 *
 * @param {Callback(isModalAdDisplayedBoolean)} callback Callback giving the status of the modal visibility.
 */
AppsfireSDK.prototype.afadsdk_isModalAdDisplayed = function(callback) {
    exec(callback, null, this.serviceName, 'afadsdk_isModalAdDisplayed', []);
};

module.exports = AppsfireSDK;

});
