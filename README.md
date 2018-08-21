# registryUtil
__registryUtil__ is intended to be a user-friendly RSG utility for debugging (or whatever else) which can enumerate the current registry sections under a particular developer ID (either the dev ID with which it was packaged, or if sideloaded, the dev ID currently logged in on the Roku device), and give the user the option to delete all or some of them via a dialog node.

## Use
Sideload registryUtil onto your Roku device and run it. It will display a list of roRegistrySection instances currently saved on the Roku device. Select any of these and press OK to delete it, or select "all" to clear the entire registry associated with the developer ID currently on the device.

In order to access registry sections associated with a different developer ID, either log into that ID on the Roku device or package registryUtil with the new ID, and then run the package.
