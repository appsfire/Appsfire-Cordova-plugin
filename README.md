Appsire iOS SDK Cordova Plugin
================
This document describes the installation and usage of the Cordova plugin for the Appsfire iOS SDK.

## Requirements
- Appsfire SDK >= 2.7.0
- Cordova CLI >= 3.0

## Introduction
The Cordova plugin of Appsfire SDK currently works only for iOS. However its integration shouldn't affect the build on any other platform.

This documentation is a brief introduction to Appsfire SDK for Cordova. We recommend you to take a look on the general documentation that you can find in your dashboard. Most of methods were implemented in Cordova. If you have a problem during the integration, don't hesitate to contact our team at <a href="mailto:support@appsfire.com">support@appsfire.com</a>.

We recommend you to read the integration reference documentation that you find at this [URL](http://docs.appsfire.com/).

## Getting Started with Appsfire
The Appsfire SDK is the cornerstone of the Appsfire network.

It provides the functionalities for monetizing your mobile application: it facilitates inserting native mobile ads into you application using native APIs.
You can choose one of our ad units (Sushi, Uramaki).

It also helps you engage with your users by sending push and in-app notifications.

- Please visit our [website](http://appsfire.com) to learn more about our ad units and products.<br />
- Please visit our [iOS online documentation](http://docs.appsfire.com/sdk/ios/integration-reference/Introduction) to learn how to integrate our SDK into your iOS app.<br />
- Check out the full [iOS API specification](http://docs.appsfire.com/sdk/ios/api-reference/) to have a detailed understanding of our iOS SDK.

In order to get started, please be sure you've done the following:

1. Registered on [Appsfire website](http://www.appsfire.com/) and accepted our Terms Of Use
2. Registered your app on our [Dashboard](http://dashboard.appsfire.com/) and generated an SDK key for your app
3. Grabbed our latest version of the SDK and Cordova plugin from our [Dashboard](http://dashboard.appsfire.com/app/doc)

## Installation

```bash
cordova plugin add PATH/appsfire-sdk-cordova-plugin
cordova prepare
```

## Example of Usage

You will first need to initialize the Appsfire SDK with your SDK Token and the features you need.

```js
var af = new AppsfireSDK();

// Set your SDK Token.
var sdkToken = '';

// Set your Secret Key.
var sdkToken = '';

// Connection to the API.
af.afsdk_connectWithParameters(
  sdkToken,
  secretKey,
  ['AFSDKFeatureEngage', 'AFSDKFeatureMonetization'],
  function() {
    console.log('SDK correctly initialized.');
  },

  function() {
    console.log('SDK failed to initialize.');
  });
```

Now that you've correctly initialized the SDK you can:
  - Show interstitial Ads:

  ```js
  // First we need to check if we have a sushi modal (interstitial).
  af.afadsdk_isThereAModalAdAvailable('sushi', function(isThereAModalAdAvailable) {

    // If we have one, then we can request to show one.
    if (isThereAModalAdAvailable) {
      af.afadsdk_requestModalAd('sushi');
    }

  });
  ```

  - Present the panel of Notifications or Feedback:

  ```js
  af.afengagesdk_presentPanel('notifications', 'fullscreen',
      function() {
          console.log('Presented');
      },
      function() {
          console.log('No Presented');
      });
  ```

In order to get test ads, you can also set the DEBUG mode:

```js
af.afadsdk_setDebugModeEnabled(true);
```

**It is important to make sure to remove this line in Production builds.**

For a full list of the available methods you'll need to check the [`appsfire.js`](/appsfire-sdk-cordova-plugin/www/appsfire.js) file.
