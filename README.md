# Orlando Walking Tours for iOS [![Build Status](https://travis-ci.org/cforlando/orlando-walking-tours-ios.svg?branch=master)](https://travis-ci.org/cforlando/orlando-walking-tours-ios)[![Code Climate](https://codeclimate.com/github/cforlando/orlando-walking-tours-ios/badges/gpa.svg)](https://codeclimate.com/github/cforlando/orlando-walking-tours-ios)
-----------
## About
-----------
**Orlando Walking Tours** is an iOS app that will allow users to create customized walking tours of the various historic locations around the city of Orlando.  

**Version** 1.0 (MVP)

**Feature List** A list of features we would like finished for version 1.0 can be found [here](MVP Feature List.md).

**Data Source** The list of historic locations is currently stored [here](https://brigades.opendatanetwork.com/dataset/Orlando-Historical-Landmarks/hzkr-id6u).

**Prototype** https://invis.io/WN7KGPF6F

**Other repositories:**
- Orlando Walking Tours for Android: https://github.com/cforlando/orlando-walking-tours-android

**Project Lead:**

Keli'i Martin

slack: werureo

email: kelii.d.martin@gmail.com

## Requirements
-----------
- Xcode v7.3
- Cocoapods v0.39.0 (IMPORTANT!)

To ensure that we don't run into any kind of dependency conflicts, it is imperative that everyone is using CocoaPods v0.39.0.  There have been some strange issues using CocoaPods v1.0.x with this project.  If you have a version of CocoaPods that is newer than v0.39.0, we ask that you first uninstall CocoaPods and reinstall v0.39.0.

To uninstall CocoaPods, open your Terminal and enter `sudo gem uninstall cocoapods`, entering your password when prompted.  If you happen to have multiple version of CocoaPods installed, one of which is v0.39.0, then just uninstall the versions you don't need and leave v0.39.0.  Otherwise, uninstall all versions.  When prompted about removing the `pod` and `sandbox-pod` executables, enter `Y` and press Enter.  Then, you can install v0.39.0 by entering `sudo gem install cocoapods -v 0.39.0`.

One all that is done, you should navigate to the project directory and run `pod install`.  Make sure you open the .xcworkspace for the project.

## Want to contribute?
-----------
If you'd like to contribute, check out our [Contributing](CONTRIBUTING.md) page for more details.

## License
-----------
[The MIT License (MIT)](LICENSE.md)

## About Code for Orlando
-----------
[Code for Orlando](http://www.codefororlando.com/), a local Code for America brigade, brings the community together to improve Orlando through technology.  We are a group of "civic hackers" from various disciplines who are committed to volunteering our talents to make a difference in the local community through technology.  We unite to improve the way the community, visitors, and local government experience Orlando.
