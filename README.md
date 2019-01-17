# registryUtil
__registryUtil__ is intended to be a user-friendly RSG utility for debugging (or whatever else) which can enumerate the current registry sections under a particular developer ID (either the dev ID with which it was packaged, or if sideloaded, the dev ID currently logged in on the Roku device), and give the user the option to delete all or some of them via a dialog node.

## Package
You can install the prepackaged "private channel" version here: https://my.roku.com/add/registryutil

## Use
Deploy/sideload __registryUtil__ onto your Roku device and run it. It will display a list of `roRegistrySection` instances currently saved on the Roku device. Select any of these and press OK to delete it, or select "all" to clear the entire registry associated with the developer ID currently on the device.

In order to access registry sections associated with a different developer ID, log into that developer ID on your Roku device by "rekeying" it: assuming developer mode is enabled on the device, access the device control panel from your web browser, select `Utilities`, upload a channel previously packaged with the desired dev ID, enter its password, and click `rekey`. You can then sideload and run __registryUtil__ immediately, or package it under that dev ID in order to permanently have a version with access to the associated registry.
