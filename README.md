# YYSwift

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/Asura19/YYSwift/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;


YYSwift is a collection of native Swift extensions, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes for iOS, macOS, tvOS and watchOS.

## Requirements:
- **iOS** 10.0+ / **tvOS** 10.0+ / **watchOS** 4.0+ / **macOS** 10.10+
- Xcode 10.2.1+
- Swift 5.0+

## Installation

#### Carthage
Add ```github "Asura19/YYSwift"``` to your Cartfile
#### Swift Package Manager
```
dependencies: [
    .package(url: "https://github.com/Asura19/YYSwift.git", from: "2.0.0")
]
```
#### Manually
Add the <a href="https://github.com/Asura19/YYSwift/tree/master/Sources">extensions</a> folder to your Xcode project to use all extensions, or a specific extension.

## Notice
I try to write a pure Swift library of [YYKit](https://github.com/ibireme/YYKit), but after a few days of work, I found this excellent project - [SwifterSwift](https://github.com/SwifterSwift/swifterSwift), it had implemented many functions of [YYKit](https://github.com/ibireme/YYKit). Should I continue? To do, or not to do, that is the question. OK, finally, I carried on this, because there are some differences between them, I combined them together, some extentions were copied directly from [SwifterSwift](https://github.com/SwifterSwift/swifterSwift) and I rewrited part of [YYKit](https://github.com/ibireme/YYKit) in Swift. In addition, I found some issues in [SwifterSwift](https://github.com/SwifterSwift/swifterSwift) and contributed to the project. During this time I also practiced a lot and improved my ability of Swift.


