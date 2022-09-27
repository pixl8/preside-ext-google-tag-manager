# Google Tag Manager for Preside

This extension is for installing configuration for adding Google Tag Manager (GTM) scripts to the HEAD and BODY sections of the required layout templates as per the instructions in GTM.


## Installation

From a commandline at the root of your application:

```
box install preside-ext-google-tag-manager
```

## Configuration

Once installed, login to the Preside admin and head to **System -> Settings -> Google Tag Manager** and enter the snippets from the instructions section in Google Tag Manager **Admin -> Container -> install Google Tag Manager** .

## Usage

The extension will take care of inserting the Google Tag manager "snippets" into your layout automatically for you, you won't need to do anything else. However, you can customize the layouts that are effected.

To customize the layouts, set the `settings.googleTagManager.layouts` variable in your `Config.cfc`:

```
settings.googleTagManager.layouts = [ "main", "newsletter" ]; // default is [ "main" ]
```

### New helper methods
There are two new helper methods that can be used for pushing and exposing application data to the `DataLayer`

* `publishDataForAnalytics` - used to push data into the DataLayer
* `getPublishedDataForAnalytics` - used by the extension to construct the `DataLayer` output
** The outputting of the `DataLayer` JSON object is taken care of you automatically by the extension, if anything is set in the DataLayer using the `publishDataForAnalytics` method


### Note
If you're using the Google Analytics extension, please ensure this is removed or the configuration for the tracking ID is removed to help prevent double tags/events being fired.

## Contributing and roadmap

Pull requests, issues and ideas are all welcome :)
Please get in touch with the Preside team on our [Preside Slack](https://presidecms-slack.herokuapp.com/).