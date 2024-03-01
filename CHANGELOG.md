# Changelog

## v1.2.0

* Refactoring: Refactoring to use the new `postRenderDelayedViewlets` interception point due to the `postLayoutRender` to accomodate for delayedViewlets and caching too


## v1.1.17

* Bug Fix: Updating the form definition input type attribute to be `control` and not `type`

## v1.1.16

* Adding dataLayer output even if the scripts are not loaded via this extension and possibly via another method built into the site
** This could be within the project code directly or via another extension e.g. Civic Cookie Control

## v1.1.14 & v1.1.15

* Refactoring to ensure the dataLayer is always in front of the GTM script + updating the CHANEGLOG file

## v1.1.13

* Bug Fix: Wrong view path set for the dataLayer data template

## v1.1.12

* Updating the interceptor to retrieve and output the DataLayer data, if any exists

## v1.1.11

* Add helper functions `publishDataForAnalytics()` and `getPublishedDataForAnalytics()`

## v1.1.10

* Output head tags directly after <title></title> element

## v1.1.9

* Remove asset building from build script

## v1.1.8

* Migrate build to GitHub Actions

## v1.1.7

* Increasing the text limit on both form fields to allow for bigger scripts

## v1.1.6

* Allow for the possibility of one or more comment tags inside the opening `<body>` tag

## v1.1.5

* Removing local asset preprocessing, not required

## v1.1.4

* Completing move to GitHub, including ensuring the build script is executable and the ChangeLog is recognised by ForgeBox

## v1.1.3

* Relocating repo to Pixl8 GitHub account

## v1.1.2

* Publishing to Forgebox, opensource

## v1.1.1

* Bug fix - missing commas

## v1.1.0

* Original build - completed

## v1.0.0

* Original build
