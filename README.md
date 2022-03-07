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
```
struct Student: ZHCodable {
    var name: String?
    var age: Int?
    var weight: Float? = 0
    var school: [School]? = []
}

struct School: ZHCodable {
    var name: String? = ""
    var address: String? = ""
}

let json = "{\"name\":\"小明\",\"school\":[{\"name\":\"市第一中学11\",\"address\":\"XX市人民中路 66 号11\"},{\"name\":\"市第一中学22\",\"address\":\"XX市人民中路 66 号22\"}],\"weight\":43.200000762939453}"
let student = Student.zh.deserialize(from: json11)

```
## Author

hao, manonghao@gmail.com

## License

ZHCodable is available under the MIT license. See the LICENSE file for more info.
