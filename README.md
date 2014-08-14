#Appsire SDK Cordova Plugin
This document describes the installation and usage of the Cordova plugin for the Appsfire SDK.

##Requirements
- Appsfire SDK >= 2.4.0
- Cordova CLI >= 3.0

## Installation

### Using the local folder
```
cordova plugin add PATH/appsfire-sdk-cordova-plugin
cordova prepare
```

## Example of Usage

You will first need to initialize the Appsfire SDK with your SDK Token and the features you need.

```js
var af = new AppsfireSDK();

// Set your SDK Token.
var sdkToken = '';

// Connection to the API.
af.afsdk_connectWithParameters(
  sdkToken,
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
