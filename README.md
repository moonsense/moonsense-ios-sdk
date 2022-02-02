# Moonsense iOS SDK

## Introduction

This repository hosts the `Package.swift` Swift Package Manager file for the Moonsense iOS SDK. The Moonsense iOS SDK is available as two variants: a dynamically linked `.xcframework` and a statically linked `.xcframework`. This repository also hosts sample applications that demonstrate the use of the Moonsense iOS SDK.

### `MoonsenseSDK.xcframework`

The `MoonsenseSDK.xcframework` contains the dynamically linked variant of the Moonsense iOS SDK. When using the dynamically linked variant of the SDK, you must embed the framework within your target so the OS can load it at runtime. This approach works fine if you are building an application that directly consumes the SDK or are building your own framework that is being used internally. If you are building a framework that you are providing to another party and you don't wish for them to see that your framework depends on the Moonsense iOS SDK, see the `MoonsenseSDK-static.xcframework` section below.

### `MoonsenseSDK-static.xcframework`

The `MoonsenseSDK-static.xcframework` contains the statically linked variant of the Moonsense iOS SDK. When using the statically linked variant of the SDK, the linker will embed the necessary code from the SDK into your target. The `Moonsense-static.xcframework` should **NOT** be embedded into your target. If you are building a framework that you are providing to another party, they will only see your public API and not the Moonsense iOS SDK public API.

## TLDR

- Clone this repository.
- Configure your `.netrc` file with your `REPO_ACCESS_TOKEN`.
- Open the `MoonsenseSamples.xcworkspace` Xcode workspace in Xcode.
- Create a public token on the [Moonsense Console](https://console.moonsense.cloud/) for your application.
- Add the public token to the `publicToken` variable in `ViewController.swift` in the `SampleApp`.
- Run the `SampleApp` on your iOS device.

## Version History

The latest release of the SDK is `0.2.0`. Details about the current and past releases can be found [here](https://github.com/moonsense/moonsense-ios-sdk/releases/).

## Prerequisites

- Xcode 13.0+
- Swift projects must use Swift 5.0 or greater
- Deployment target of iOS 11.0 or greater

## Integrating the SDK

### Configuring `.netrc` for Authorizing Downloads

Downloading the Moonsense iOS SDK artifacts requires a `REPO_ACCESS_TOKEN` for `dl.moonsense.io`. This token is associated to your Moonsense Account and should have been provided to you. In case you do not have one contact [support@moonsense.io](mailto:support@moonsense.io). Add the following to your `~/.netrc` file:

```
machine dl.moonsense.io
  login token
  password <REPO_ACCESS_TOKEN>
  protocol https

```

### Swift Package Manager

The Moonsense iOS SDK is available as a Swift Package. Simply use the the link to the [`moonsense-ios-sdk`](https://github.com/moonsense/moonsense-ios-sdk) repo, https://github.com/moonsense/moonsense-ios-sdk, as the Package URL when adding the Swift Package to your project.

### Cocoapods

Cocoapods distribution is not currently available but will be supported in an upcoming release.

### Manual Integration

The `MoonsenseSDK.xcframework.zip`, `MoonsenseSDK-static.xcframework.zip` and `MoonsenseSDK.doccarchive.zip` artifacts can also be manually integrated into your project. You can download the latest versions from the following links:

* [`MoonsenseSDK.xcframework.zip`](https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.2.0/MoonsenseSDK.xcframework-0.2.0.zip)
* [`MoonsenseSDK-static.xcframework.zip`](https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/0.2.0/MoonsenseSDK-static.xcframework-0.2.0.zip)
* [`MoonsenseSDK.doccarchive.zip`](https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.doccarchive/versions/0.2.0/MoonsenseSDK.doccarchive-0.2.0.zip)

Once downloaded, unzip the files and drop the expanded files into your project.

*Note:* The downloads require the authorization token as outlined above. For best results download the artifacts using `curl` with the `-n` option. For example:

```
curl -n -o MoonsenseSDK.xcframework.zip https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.2.0/MoonsenseSDK.xcframework-0.2.0.zip
```

## Usage

The SDK requires some configuration information to be setup and associate correctly with your app. To continue, you will need to create a `publicToken` for you app on the [Moonsense Console](https://console.moonsense.cloud/).

In order to obtain a token you need to:

- Have a valid Moonsense account.
- Set up a project for the SDK to use. The default can be used in case you do not want to create one.
- Configure an application for the SDK to record to.
- Once the app is set up, use the `Create token` button to obtain the secret and public token to use. The SDK requires the public token as a part of the [`initialize(publicToken:delegate:)`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsense/initialize(publictoken:delegate:)) invocation. You can hold on to the secret token to read from the Moonsense Cloud later.

### Initialization

The SDK needs to be initialized before it can be used. Call the [`Moonsense.initialize(publicToken:delegate:)`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsense/initialize(publictoken:delegate:)) method prior to recording. The [`initialize(publicToken:delegate:)`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsense/initialize(publictoken:delegate:)) method also accepts an optional [`MoonsenseDelegate`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsensedelegate) to receive events from the SDK. For example:

```
import MoonsenseSDK

class ViewController: UIViewController {

    let publicToken = "<YOUR_TOKEN_HERE>"

    ...

    override func viewDidLoad() {
      super.viewDidLoad()

      ...

      Moonsense.initialize(publicToken: publicToken, delegate: self)
    }
}
```

```
extension ViewController: MoonsenseDelegate {
    func didStartSession(_ session: Session) {
        // Called each time a session has started
    }

    func didStopSession(_ session: Session) {
        // Called each time a session has stopped
    }

    func errorDidOccur(error: MoonsenseError) {
        // Called each time the Moonsense SDK experiences an error
        print("Moonsense Error occurred: \(error.localizedDescription)")
    }
}
```

### Recording

The SDK records in `Session`s. A [`Session`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/session) is defined as a single start and stop point in time. Once the SDK initialized you can use the [`startSession()`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsense/startsession(duration:labels:clientsessiongroupid:)) and [`stopAllSessions()`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsense/stopallsessions()) methods to start and stop recording sessions respectively. If you need finer control over stopping individual sessions, the [`startSession()`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/moonsense/startsession(duration:labels:clientsessiongroupid:)) call returns a [`Session`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/session) object that includes a [`stopSession()`](https://ios.sdk-docs.moonsense.io/documentation/moonsensesdk/session/stopsession()) method. For example:

```
import MoonsenseSDK

class ViewController: UIViewController {

   var session: Session?

  ...

    @IBAction func startSession(_ sender: Any) {
        session = try? Moonsense.startSession(duration: 30, labels: ["SampleApp"])
    }

    @IBAction func stopAllSessions(_ sender: Any) {
        Moonsense.stopAllSessions()
    }

    @IBAction func stopLastSession(_ sender: Any) {
      if let session = session {
        session.stopSession()
        session = nil
      }
    }
}
```

## Sample Applications

The [`moonsense-ios-sdk`](https://github.com/moonsense/moonsense-ios-sdk) GitHub repository contains sample applications and a sample SDK that demonstrate the integration and use of the Moonsense iOS SDK. To get started, open the `MoonsenseSamples.xcworkspace` Xcode Workspace.

- [`SampleApp`](https://github.com/moonsense/moonsense-ios-sdk/tree/main/SampleApp) - This sample app demonstrates the use of the Moonsense iOS SDK within a simple application. The example in this case is quite simple and minimal and can serve as a good starting point for developers looking for a quick integration. The `SampleApp` Xcode project contains two targets, `SampleApp` and `SampleApp-Static`. The `SampleApp` target consumes the `MoonsenseSDK.xcframework` dynamically linked variant. The `SampleApp-Static` target consumes the `MoonsenseSDK-static.xcframework` target.
- [`SamplePaymentApp`](https://github.com/moonsense/moonsense-ios-sdk/tree/main/SamplePaymentApp) - This sample app demonstrates the library usage of the Moonsense iOS SDK. Note that the `SamplePaymentApp` does not directly depend on the Moonsense iOS SDK. Instead it includes a dependency to the [`SamplePaymentSDK`](https://github.com/moonsense/moonsense-ios-sdk/tree/main/SamplePaymentSDK) which consumes the Moonsense iOS SDK statically linked variant. The app developer here does not have any visibility into the Moonsense iOS SDK as they only interface with the `SamplePaymentSDK`. The example is useful for SDK/library developers looking to integrate the Moonsense iOS SDK.

## Terms Of Service

The Moonsense iOS SDK is distributed under the [Moonsense Terms Of Service](https://www.moonsense.io/terms-of-service).

## Support

Feel free to raise an [Issue](https://github.com/moonsense/moonsense-ios-sdk/issues) around bugs, usage, concerns or feedback.
