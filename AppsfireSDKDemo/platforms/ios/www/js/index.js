/*
* Licensed to the Apache Software Foundation (ASF) under one
* or more contributor license agreements.  See the NOTICE file
* distributed with this work for additional information
* regarding copyright ownership.  The ASF licenses this file
* to you under the Apache License, Version 2.0 (the
* "License"); you may not use this file except in compliance
* with the License.  You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*/

var app = {

  // Application Constructor
  initialize: function() {
    this.bind();
  },

  bind: function() {
    document.addEventListener('deviceready', this.deviceReady, false);
  },

  deviceReady: function() {
    var af = new AppsfireSDK();

    document.addEventListener('afadsdk_modalAdsRefreshedAndAvailable', function() {
      console.log('An Ad is ready to be displayed!');
    },
    false);

    // Appsfire Engage SDK Delegate events.
    document.addEventListener('afadsdk_modalAdsRefreshedAndAvailable', function() {
      console.log('afengagesdk_openNotificationDidFinishWithSuccess');
    },
    false);

    document.addEventListener('afengagesdk_openNotificationDidFinishWithFailure', function() {
      console.log('afengagesdk_openNotificationDidFinishWithFailure');
    },
    false);

    // Appsfire Ad SDK Delegate events.
    document.addEventListener('afadsdk_modalAdsRefreshedAndAvailable', function() {
      console.log('afadsdk_modalAdsRefreshedAndAvailable');

      var sushiAdUnit = document.getElementById("adunit-sushi");
      var uraMakiAdUnit = document.getElementById("adunit-uramaki");

      sushiAdUnit.style.opacity = 1;
      sushiAdUnit.style['pointer-events'] = 'auto';

      uraMakiAdUnit.style.opacity = 1;
      uraMakiAdUnit.style['pointer-events'] = 'auto';
    },
    false);

    document.addEventListener('afadsdk_modalAdsRefreshedAndNotAvailable', function() {
      console.log('afadsdk_modalAdsRefreshedAndNotAvailable');
    },
    false);

    // Appsfire Ad SDK Modal Delegate events.
    document.addEventListener('afadsdk_modalAdRequestDidFail', function() {
      console.log('afadsdk_modalAdRequestDidFail');
    },
    false);

    document.addEventListener('afadsdk_modalAdWillAppear', function() {
      console.log('afadsdk_modalAdWillAppear');
    },
    false);

    document.addEventListener('afadsdk_modalAdDidAppear', function() {
      console.log('afadsdk_modalAdDidAppear');
    },
    false);

    document.addEventListener('afadsdk_modalAdWillDisappear', function() {
      console.log('afadsdk_modalAdWillDisappear');
    },
    false);

    document.addEventListener('afadsdk_modalAdDidDisappear', function() {
      console.log('afadsdk_modalAdDidDisappear');
    },
    false);

    // Set your SDK Token.
    var sdkToken = '';
    
    // Set your Secret Key.
    var secretKey = '';

    // Connection to the API.
    af.afsdk_connectWithParameters(
      sdkToken,
      secretKey,
      ['AFSDKFeatureEngage', 'AFSDKFeatureMonetization'],
      function() {
        console.log('SDK correctly initialized.');

        // Set the following variable to `true` if you want to see test ads.
        // Remember to set to `false` in Production.
        var isDebugModeEnabled = false;

        app.enableAdvertisment(af, isDebugModeEnabled);
      },

      function() {
        console.log('SDK failed to initialize.');
      });

    // Notifications Wall
    var notificationWall = document.getElementById('notifications');
    notificationWall.addEventListener('click', function() {
      af.afengagesdk_presentPanel(
        'notifications',
        'default',
        function() {
          console.log('Notification wall presented.');
        },
        function() {
          console.log('Notification wall failed to present.');
        });
      });

    // Feedback
    var feedback = document.getElementById('feedback');
    feedback.addEventListener('click', function() {
      af.afengagesdk_presentPanel(
        'feedback',
        'default',
        function() {
          console.log('Feedback Form Presented.');
        },
        function() {
          console.log('Feedback Form NOT Presented.');
        });
      });

    // Sushi AdUnit
    var adUnitSushi = document.getElementById('adunit-sushi');
    adUnitSushi.addEventListener('click', function() {
      // Show an Ad
      af.afadsdk_requestModalAd('sushi');
    });

    // Uramaki AdUnit
    var adUnitUramaki = document.getElementById('adunit-uramaki');
    adUnitUramaki.addEventListener('click', function() {
      // Show an Ad.
      af.afadsdk_requestModalAd('uramaki');
    });

  },

  enableAdvertisment: function(af, isDebugMode) {
    if (typeof(isDebugMode) != 'boolean') isDebugMode = 'false';
      if (af === null) return;

        // If you want to see test ads, set debug mode to true.
        // Do not forget to remove on production!
        af.afadsdk_setDebugModeEnabled(isDebugMode,
          function() {
            console.log('Setting AdUnit to debug mode.');
          });
        }
      };
