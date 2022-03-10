# TripiMyfreshKit

## Overview
- iOS 11+
- Xcode: 12
- Swift 5.0

## Installation

**Config pod**

To run the example project, clone the repo, and run `pod install` from the Example directory first.
To install it, simply add the following line to your Podfile:

```swift
pod 'TripiMyfreshKit', :git => 'https://bitbucket.org/chodulich/ios-myfresh-sdk.git', :tag => '1.2.1'   
```

**Config Info.plist**

Your app must request permission to use Location, Camera, PhotoLibrary services. 
Add the NSLocationWhenInUseUsageDescription, NSCameraUsageDescription, NSPhotoLibraryAddUsageDescription, NSPhotoLibraryUsageDescription key to your Info.plist file.
To define the string informing the user why you need the services. 

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Ứng dụng sử dụng vị trí hiện tại của bạn để tìm nhà hàng gần bạn phù hợp nhất. Hãy cho phép truy cập vị trí của bạn.</string>
<key>NSCameraUsageDescription</key>
<string>Ứng dụng sử dụng máy ảnh của bạn để chụp. Hãy cho phép truy cập máy ảnh của bạn.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Ứng dụng lưu ảnh đã chụp vào thư viện ảnh của bạn. Hãy cho phép truy cập thư viện ảnh của bạn.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Ứng dụng sử dụng ảnh trong thư viện ảnh của bạn. Hãy cho phép truy cập thư viện ảnh của bạn.</string>
```

## How To Use

```swift
import TripiMyfreshKit
```

## Example

- Ex: Set up Environment

```swift
TripiMyfresh.shared.setEnvironment(env: TripiMyfresh.TripiMyfreshServer.dev)
```

- Ex: Open SDK
```swift
TripiMyfresh.shared.openSDK(appId: "mytour-food-ios",
                            secretKey: "kasdhasdhakdjkad",
                            token: "bj67mfojmdizdwxzn8v7-571e49dd-f8f5-4b5e-ba0d-bbe1580f4f2f",
                            caid: 17, 
                            fullName: "Dieu Dieu",
                            phone: "0344355127",
                            email: "dieudieu127@gmail.com",
                            locationJson: stringLocation,
                            isAccessLocation: false)
```

- Explain param:
    - appId: Require
    - secretKey: Require
    - caid: Require
    - fullName, phone, email: Require when payment get from mainApp
    - locationJson: If SDK has location from mainApp, you must send location string json into SDK in order use
    - isAccessLocation: Is Bool variable, used to handle displaying the default location on the home screen


- Ex: Open orderList
```swift
TripiMyfresh.shared.configSDK(appId: "mytour-food-ios",
                            secretKey: "kasdhasdhakdjkad",
                            token: "uzkr8avw21fp66rxiu9f-6a6cbaf9-5b0e-49cf-a6bc-8035c45c2c4f",
                            caid: 17, fullName: "Dieu Dieu",
                            phone: "0344355127",
                            email: "dieudieu127@gmail.com",
                            isAccessLocation: true)
TripiMyfresh.shared.openOrderList()
```

- Ex: Listen to catch the tracking logevent in MainApp
```swift
TripiMyfresh.shared.addTrackEvent { (eventName, body) in
    //eventName: String 
    //body: [String: Any]
}
```

- Ex: Get Order Controller
```swift
TripiMyfresh.shared.getOrderListVC()
```

- Ex: Incognito
Configure:
```swift
TripiMyfresh.shared.authenticateUser { [weak self] in
    //Please authenticate user
}
```

- After authenticated:
```swift
TripiMyfresh.shared.configSDK(appId: "mytour-food-ios",
                              secretKey: "kasdhasdhakdjkad",
                              token: "uzkr8avw21fp66rxiu9f-6a6cbaf9-5b0e-49cf-a6bc-8035c45c2c4f",
                              caid: 17, fullName: "Dieu Dieu",
                              phone: "0344355127",
                              email: "dieudieu127@gmail.com",
                              isAccessLocation: true)
TripiMyfresh.shared.syncData()
```


- Ex: Log out
```swift
TripiMyfresh.shared.logOut()
```

- Ex: Handle reload detailOrder or OrderList when receiver noti update from MainApp
```swift
TripiMyfresh.shared.updateOrder(with bookingId: Int? = nil)
```

## Dependency Framework

```ruby
pod 'SDWebImage', '5.1.1'
pod 'Alamofire', '5.3.0'
pod 'GoogleMaps', '5.1.0'
pod 'Cosmos', '23.0'
pod 'GooglePlaces', '5.1.0'
pod 'IQKeyboardManagerSwift', '6.5.9'
pod 'SVProgressHUD', '1.1.3'
pod 'SVPullToRefresh', '0.4.1'
pod 'CallAppSDK', :git => 'https://bitbucket.org/chodulich/vnpay-callappsdk.git', :branch => 'master'
```

## Author

Tripi

## License

TripiMyfreshKit is available under the MIT license. See the LICENSE file for more info.
