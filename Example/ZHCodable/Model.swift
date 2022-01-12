//
//  Model.swift
//  ZHCodable_Example
//
//  Created by 张淏 on 2022/1/12.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ZHCodable

// class School: ZHCodable {
struct School: ZHCodable {
    var name: String? = ""
    var address: String? = ""
}

// class Student: ZHCodable {
struct Student: ZHCodable {
    var name: String?
    var age: Int?
    var weight: Float? = 0
    var school: [School]? = []
}

/* 自定义字段
 * 原理：
 * 在编译代码时根据类型的属性，自动生成了一个 CodingKeys 的枚举类型定义
 * 这是一个以 String 类型作为原始值的枚举类型，对应每一个属性的名称。
 * 然后再给每一个声明实现 Codable 协议的类型自动生成
 * init(from:) 和 encode(to:)
 * 两个函数的具体实现，最终完成了整个协议的实现
 * 我们自己实现 CodingKeys 枚举，编译时就会直接使用我们自己实现的枚举
 */
// class Person: ZHCodable {
struct Person: ZHCodable {
    
    var firstName: String?
    var age: Int?
    
    // 自定义实现 CodingKeys 枚举，需要自定义的枚举赋值，如 "first_name"，不需要自定义的枚举也要进行 case，如 case age，我们自定义实现了枚举，系统就会使用我们实现的枚举，而不会继续生成枚举，如果我没不写 case age，在 decode 时 age 将无法进行赋值
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"// 后台返回字段为 first_name
        case age
    }
}
