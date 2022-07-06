# Moonsense iOS SampleCoreApp

The `SampleCoreApp` project demonstrates the use of the Moonsense iOS Core SDK within a simple application. This sample app shows how to integrate a variation of the Moonsense iOS SDK called the Core SDK. For all intents and purposes the standard iOS SDK (referred to as the Cloud SDK) should suffice for a majority of use cases. In case you do need specialized use of the Moonsense SDK contact support@moonsense.io for access. Additional information regarding the Core SDK can be found here - [Advanced Usage](https://docs.moonsense.io/articles/sdk/advanced-usage).

## Prerequisites

- Xcode 13.0+
- Swift projects must use Swift 5.0 or greater
- Deployment target of iOS 11.0 or greater

## Integration

At this time, the `MoonsenseCoreSDK.xcframework.zip`, `MoonsenseCoreSDK-static.xcframework.zip` and `MoonsenseCoreSDK.doccarchive.zip` artifacts must be manually integrated into your project. You can download the latest versions from the following links:

* [`MoonsenseCoreSDK.xcframework.zip`](https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.0.0/MoonsenseCoreSDK.xcframework-1.0.0.zip)
* [`MoonsenseCoreSDK-static.xcframework.zip`](https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.0.0/MoonsenseCoreSDK-static.xcframework-1.0.0.zip)
* [`MoonsenseCoreSDK.doccarchive.zip`](https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.doccarchive/versions/1.0.0/MoonsenseCoreSDK.doccarchive-1.0.0.zip)

Once downloaded, unzip the files and drop the expanded files into your project.

*Note:* The downloads require the authorization token as outlined in the main [`README.md`](../README.md/#configuring-netrc-for-authorizing-downloads). For best results download the artifacts using `curl` with the `-n` option. For example:

```
curl -n -o MoonsenseCoreSDK.xcframework.zip https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.0.0/MoonsenseCoreSDK.xcframework-1.0.0.zip
```

## Terms Of Service

The Moonsense iOS Core SDK and `SampleCoreApp` are distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
