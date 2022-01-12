# ZHCodable

[![CI Status](https://img.shields.io/travis/hao/ZHCodable.svg?style=flat)](https://travis-ci.org/hao/ZHCodable)
[![Version](https://img.shields.io/cocoapods/v/ZHCodable.svg?style=flat)](https://cocoapods.org/pods/ZHCodable)
[![License](https://img.shields.io/cocoapods/l/ZHCodable.svg?style=flat)](https://cocoapods.org/pods/ZHCodable)
[![Platform](https://img.shields.io/cocoapods/p/ZHCodable.svg?style=flat)](https://cocoapods.org/pods/ZHCodable)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

ZHCodable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZHCodable',:git =>"https://github.com/haoburongyi/ZHCodable.git"
```

## Sample Code

### Deserialization
```struct Student: ZHCodable {
    var name: String?
    var age: Int?
    var weight: Float? = 0
    var school: [School]? = []
}

```
## Author

hao, manonghao@gmail.com

## License

ZHCodable is available under the MIT license. See the LICENSE file for more info.
