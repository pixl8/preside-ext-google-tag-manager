# Google Tag Manager for Preside

This extension is for installing the installation scripts and configuration for adding Google Tag Manager (GTM) to the HEAD and BODY sections of the required layout templates as per the instructions in GTM.


## Installation

From a commandline at the root of your application:

```
box install preside-ext-google-tag-manager
```

## Configuration

Once installed, login to the Preside admin and head to **System -> Settings -> Google Tag Manager** and enter the snippets from the instructions section in Google Tag Manager **Admin -> Container -> install Google Tag Manager** .

For Google Consent Mode v2 and other configuration parameters, you can also add your required signals for Google, see the _example_ below:

```
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() {
        dataLayer.push(arguments);
    }
    gtag("consent", "default", {
          ad_personalization: "denied"
        , ad_storage: "denied"
        , ad_user_data: "denied"
        , analytics_storage: "denied"
        , wait_for_update: 1000
    });
    gtag("set", "url_passthrough", true);
</script>

<!-- Google Tag Manager Script after -->
```

## Usage

The extension will take care of inserting the Google Tag manager "snippets" into your layout automatically for you, you won't need to do anything else. However, you can customize the layouts that are affected.

To customize the layouts, set the `settings.googleTagManager.layouts` variable in your `Config.cfc`:

```
settings.googleTagManager.layouts = [ "main", "newsletter" ]; // The default is [ "main" ]
```

### New helper methods
There are two new helper methods that can be used for pushing and exposing application data to the `DataLayer`

* `publishDataForAnalytics` - used to push data into the DataLayer
* `getPublishedDataForAnalytics` - used by the extension to construct the `DataLayer` output
** The outputting of the `DataLayer` JSON object is taken care of you automatically by the extension, if anything is set in the DataLayer using the `publishDataForAnalytics` method

### Note
If you're using the Google Analytics extension or any other method of installing your tracking scripts, please ensure they are removed OR the configuration for the tracking ID is removed in the Admin to help prevent double tags/events being fired.

## Contributing and roadmap

Pull requests, issues and ideas are all welcome :)
Please get in touch with the Preside team on our [Preside Slack](https://presidecms-slack.herokuapp.com/).