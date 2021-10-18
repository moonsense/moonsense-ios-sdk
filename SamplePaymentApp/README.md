# Moonsense iOS SamplePaymentApp

The `SamplePaymentApp` demonstrates how a Third Party `.xcframework` which includes the Moonsense iOS SDK can be consumed and used in an application. This application consumes the [`SamplePaymentSDK`](../SamplePaymentSDK) and simulates a purchase of cookies from the fictional online cookie shop.

## Prerequisites

- Xcode 13.0+
- Swift projects must use Swift 5.0 or greater
- Deployment target of iOS 11.0 or greater

## Integration

Follow the steps from the main [`README.md`](../README.md/#integration)` to install the dependencies on the Moonsense iOS SDK.

## Authentication

For the `SamplePaymentSDK` to be able to communicate with the Moonsense Cloud, it will require a public token associated with your application. For more information on creating your public token, see the [Usage](../README.md/#usage) section of the main [`README.md`](../README.md).

Once you have your public token, add it to the  `moonsensePublicToken` variable in `Payment.swift`.

## Usage

Run the `SamplePaymentApp` and tap the Buy button to display the Swipe to Buy experience.

## Terms Of Service

The Moonsense iOS SDK and `SamplePaymentSDK` are distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
