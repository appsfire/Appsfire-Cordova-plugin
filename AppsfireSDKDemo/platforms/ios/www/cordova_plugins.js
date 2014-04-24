cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/org.apache.cordova.console/www/console-via-logger.js",
        "id": "org.apache.cordova.console.console",
        "clobbers": [
            "console"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.console/www/logger.js",
        "id": "org.apache.cordova.console.logger",
        "clobbers": [
            "cordova.logger"
        ]
    },
    {
        "file": "plugins/com.appsfire.appsfiresdk-plugin/www/appsfire.js",
        "id": "com.appsfire.appsfiresdk-plugin.AppsfireSDK",
        "clobbers": [
            "AppsfireSDK"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "org.apache.cordova.console": "0.2.5",
    "com.appsfire.appsfiresdk-plugin": "1.0.4"
}
// BOTTOM OF METADATA
});