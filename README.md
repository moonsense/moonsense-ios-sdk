# Moonsense iOS SDK

## Introduction

This repository includes a sample app that demonstrates the use of the Moonsense SDK for iOS.

## TLDR

- Clone this repository.
- Create a public token on the [Moonsense Console](https://console.moonsense.cloud/) for your application.
- Add the public token to the `ViewController` in the `SampleApp`.
- Run the `SampleApp` on your iOS device.

## Features

The current latest release of the SDK is `0.1.0-alpha1`. The purpose of this release in a nutshell is to introduce the public API for the iOS SDK. The release also serves as a good starting point to test out a very early integration of the SDK into applications and libraries. 

The full feature list for this release includes:
- The ability to authenticate with the SDK using the public token provided by the [Moonsense Console](https://console.moonsense.cloud/).
- Start a session to collect accelerometer data from the device.
- Publish the accelerometer data to the Moonsense Cloud.
- Stop all or individual sessions.

## Integration



## Usage

The SDK needs to be initialized before it can be used. Call the `Moonsense.initialize(publicToken:delegate:)` method prior to recording. The `initialize(publicToken:delegate:)` method requires a `publicToken` that can be generated using the [Moonsense Console](https://console.moonsense.cloud/). In order to obtain a token you need to:

- Have a valid Moonsense account.
- Set up a project for the SDK to use. The default can be used in case you do not want to create one.
- Configure an application for the SDK to record to.
- Once the app is set up, use the `Create token` button to obtain the secret and public token to use. The SDK requires the public token as a part of the `initialize(publicToken:delegate:)` invocation. You can hold on to the secret token to read from the Moonsense Cloud later.

The `initialize(publicToken:delegate:)` method also accepts an optional `MoonsenseDelegate` to receive events from the SDK.

Once initialized you can use the `startSession()` and `stopAllSessions()` methods to start and stop recording sessions respectively. If you need finer control over stopping individual sessions, the `startSession()` call returns a `Session` object that includes a `stopSession()` method.

This repo includes a sample app that demonstrates the SDK usage.

## Terms Of Service

This SDK is distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
