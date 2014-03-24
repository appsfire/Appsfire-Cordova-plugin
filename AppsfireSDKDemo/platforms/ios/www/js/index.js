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

    // When we receive the signal that an Ad is ready to be displayed, we
    // try to show it.
    document.addEventListener(
      'adsdk_modalAdIsReadyForRequest',
      function() {
        console.log('An Ad is ready to be displayed!');
        var sushiAdUnit = document.getElementById("adunit-sushi");
        var uraMakiAdUnit = document.getElementById("adunit-uramaki");
        sushiAdUnit.style['opacity'] = 1;
        sushiAdUnit.style['pointer-events'] = 'auto';
        uraMakiAdUnit.style['opacity'] = 1;
        uraMakiAdUnit.style['pointer-events'] = 'auto';
      },
      false);

    // Set the features you need.
    af.sdk_setFeatures(['AFSDKFeatureEngage', 'AFSDKFeatureMonetization']);
    
    // Set your API key below.
    var apiKey = 'YOUR_API_KEY';
      
    // Connection to the API.
    af.sdk_connectWithApiKey(
      apiKey,
      function() {
        console.log('Connected to the API.');

        // Set the following variable to `true` if you want to see test ads.
        // Remember to set to `false` in Production!
        var isDebugModeEnabled = true;
        app.enableAdvertisment(af, isDebugModeEnabled);
      },
      function() {
        console.log('Not connected to the API.');
      });

    // Notifications Wall
    var notificationWall = document.getElementById('notifications');
    notificationWall.addEventListener('click', function() {
      af.sdk_presentPanel(
        'notifications',
        'default',
        function() {
          console.log('Notification Wall Presented.');
        },
        function() {
          console.log('Notification Wall NOT Presented.');
        });
    });

    // Feedback
    var feedback = document.getElementById('feedback');
    feedback.addEventListener('click', function() {
      af.sdk_presentPanel(
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
      af.adsdk_requestModalAd('sushi', false);
    });

    // Uramaki AdUnit
    var adUnitUramaki = document.getElementById('adunit-uramaki');
    adUnitUramaki.addEventListener('click', function() {
      // Show an Ad
      af.adsdk_requestModalAd('uramaki', true);
    });

  },
  enableAdvertisment: function(af, isDebugMode) {
    if (typeof(isDebugMode) != 'boolean') isDebugMode = 'false';
    if (af === null) return;

    // If you want to see test ads, set debug mode to true.
    // Do not forget to remove on production!
    af.adsdk_setDebugModeEnabled(isDebugMode,
      function() {
        console.log('Setting AdUnit to debug mode.');
      });

    // Preparing the Ad SDK
    af.adsdk_prepare();
  }
};