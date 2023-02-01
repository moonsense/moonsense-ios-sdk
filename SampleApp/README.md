# Moonsense iOS SampleApp

The `SampleApp` project demonstrates the use of the Moonsense iOS SDK within a simple application. The example in this case is quite simple and minimal and can serve as a good starting point for developers looking for a quick integration. The `SampleApp` Xcode project contains two targets, `SampleApp` and `SampleApp-Static`. The `SampleApp` target consumes the `MoonsenseSDK.xcframework` dynamically linked variant. The `SampleApp-Static` target consumes the `MoonsenseSDK-static.xcframework` target.

## Prerequisites

- Xcode 14.0+
- Swift projects must use Swift 5.0 or greater
- Deployment target of iOS 11.0 or greater

## Integration

Follow the steps from the main [`README.md`](../README.md/#integration) to install the dependencies on the Moonsense iOS SDK.

## Authentication

For the `SampleApp` to be able to communicate with the Moonsense Cloud, it will require a public token associated with your application. For more information on creating your public token, see the [Usage](../README.md/#usage) section of the main [`README.md`](../README.md).

Once you have your public token, add it to the  `publicToken` variable in `ViewController.swift`.

## Terms Of Service

The Moonsense iOS SDK and `SampleApp` are distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
