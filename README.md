# Moonsense iOS SDK

## Introduction

This repository hosts the releases of the Moonsense iOS SDK. Two variants of the Moonsense iOS SDK are available, a dynamically linked `.xcframework` and a statically linked `.xcframework`. This repository also holds sample applications that demonstrate the use of the Moonsense SDK for iOS.

### `MoonsenseSDK.xcframework`

The `MoonsenseSDK.xcframework` contains the dynamically linked variant of the Moonsense iOS SDK. When using the dynamically linked variant of the SDK, you must embed the framework within your target so the OS can load it at runtime. This approach works fine if you are building an application that directly consumes the SDK or are building your own framework that is being used internally. If you are building a framework that you are providing to another party and you don't wish for them to see that your framework depends on the Moonsense iOS SDK, see the `MoonsenseSDK-static.xcframework` section below.

### `MoonsenseSDK-static.xcframework`

The `MoonsenseSDK-static.xcframework` contains the statically linked variant of the Moonsense iOS SDK. When using the statically linked variant of the SDK, the linker will embed the necessary code from the SDK into your target. The `Moonsense-static.xcframework` should **NOT** be embedded into your target. If you are building a framework that you are providing to another party, they will only see your public API and not the Moonsense iOS SDK public API.

## TLDR

- Clone this repository.
- Download the `MoonsenseSDK.xcframework.zip` and `MoonsenseSDK-static.xcframework.zip` release assets from the [Github Releases page](https://github.com/moonsense/moonsense-ios-sdk/releases). Unzip the `*.xcframework.zip` artifacts and drag them into the `<CLONE_DIR>/SampleApp` folder using the Finder application.
- Create a public token on the [Moonsense Console](https://console.moonsense.cloud/) for your application.
- Add the public token to the `publicToken` variable in `ViewController.swift` in the `SampleApp`.
- Run the `SampleApp` on your iOS device.

## Features

The current latest release of the SDK is `0.1.0-alpha2`. The purpose of this release in a nutshell is to introduce the public API for the iOS SDK. The release also serves as a good starting point to test out a very early integration of the SDK into applications and libraries. 

The full feature list for this release includes:
- The ability to authenticate with the SDK using the public token provided by the [Moonsense Console](https://console.moonsense.cloud/).
- Start a session to collect accelerometer data from the device.
- Publish the accelerometer data to the Moonsense Cloud.
- Stop all or individual sessions.

## Prerequisites

- Xcode 13.0+
- Swift projects must use Swift 5.0 or greater
- Deployment target of iOS 11.0 or greater

## Integration

This repository is currently invite only and thus it is a Private GitHub repository. There is an issue with Swift Package Manager where it cannot download artifacts from Release artifacts in private Github repositories. We are investigating other solutions for storing the release artifacts but until that is resolved, the SDK must be installed manually.

Download the `MoonsenseSDK.xcframework.zip` and `MoonsenseSDK-static.xcframework.zip` artifacts from the `0.1.0-alpha2` release. Unzip the files and drop the file into the `<CLONE_DIR>/SampleApp` folder using the Finder application.

In the near future, once the artifact is being stored outside of the Github release, Swift Package Manager will be supported.

## Usage

The SDK needs to be initialized before it can be used. Call the `Moonsense.initialize(publicToken:delegate:)` method prior to recording. The `initialize(publicToken:delegate:)` method requires a `publicToken` that can be generated using the [Moonsense Console](https://console.moonsense.cloud/). In order to obtain a token you need to:

- Have a valid Moonsense account.
- Set up a project for the SDK to use. The default can be used in case you do not want to create one.
- Configure an application for the SDK to record to.
- Once the app is set up, use the `Create token` button to obtain the secret and public token to use. The SDK requires the public token as a part of the `initialize(publicToken:delegate:)` invocation. You can hold on to the secret token to read from the Moonsense Cloud later.

The `initialize(publicToken:delegate:)` method also accepts an optional `MoonsenseDelegate` to receive events from the SDK.

Once initialized you can use the `startSession()` and `stopAllSessions()` methods to start and stop recording sessions respectively. If you need finer control over stopping individual sessions, the `startSession()` call returns a `Session` object that includes a `stopSession()` method.

This repo includes a sample app that demonstrates the SDK usage.

## Sample App

The included `SampleApp` Xcode project contains two targets, `SampleApp` and `SampleApp-Static`. The `SampleApp` target consumes the `MoonsenseSDK.xcframework` dynamically linked variant. The `SampleApp-Static` target consumes the `MoonsneseSDK-static.xcframework` target.

## Terms Of Service

This SDK is distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
