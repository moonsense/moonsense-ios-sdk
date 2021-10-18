# Moonsense iOS SamplePaymentSDK

The `SamplePaymentSDK` demonstrates how the Moonsense iOS SDK can be integrated into a Third Party `.xcframework` for developers looking to release their own `.xcframework` that includes the Moonsense functionality. The `SamplePaymentSDK` consumes the `MoonsenseSDK-static.xcframework` statically linked variant of the Moonsense iOS SDK. When using this approach, a Third Party developer does not need to also ship the `MoonsenseSDK.xcframework` dynamically linked variant along side their `.xcframework` as the Moonsense iOS SDK is statically linked within their `.xcframework`.

The `SamplePaymentSDK` provides an example Swipe to Buy experience which is recorded in a Moonsense Session.

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

The `SamplePaymentSDK` exposes the `Payment` class. The `SamplePaymentSDK` must be initialized before being used by calling the `Payment.initialize()` method. Once the SDK is initialized, the Swipe to Buy experience can be displayed by calling `Payment.capturePayment(price:, completion:)`.

See the [`SamplePaymentApp`](../SamplePaymentApp) for a sample application that consumes this SDK.

## Terms Of Service

The Moonsense iOS SDK and `SamplePaymentSDK` are distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
