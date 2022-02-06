//
//  ZHCodable.swift
//  ZHCodable
//
//  Created by 张淏 on 2021/11/13.
//

import UIKit

public typealias ZHCodableString = String
public typealias ZHCodableArray = Array
private let decoder = JSONDecoder()

public struct ZHCodableWrapper<Base> {
    public var base: Base?
    public init(_ base: Base?) {
        self.base = base
    }
}

public protocol ZHCodable: Codable {}

public extension ZHCodable {
    
    var zh: ZHCodableWrapper<Self> {
        get { return ZHCodableWrapper(self) }
    }
    
    static var zh: ZHCodableWrapper<Self> {
        get { return ZHCodableWrapper(nil) }
    }
}

// MARK: - 字典、json转模型
public extension ZHCodableWrapper where Base: ZHCodable {
    
    // json 转模型
    func deserialize(_ json: String?) -> Base? {
        guard let data = json?.data(using: .utf8) else { return nil }
        do {
            return try decoder.decode(Base.self, from: data)
        } catch {
            print(error.localizedDescription)
            print("json 转模型失败:\(error)")
            return nil
        }
    }
    
    // 字典转模型
    func deserialize(_ dict: [String : Any]?) -> Base? {
        guard let dict = dict else { return nil }
        do {
            let opt: JSONSerialization.WritingOptions
            if #available(iOS 13.0, *) {
                opt = .withoutEscapingSlashes
            } else {
                opt = .prettyPrinted
            }
            let data = try JSONSerialization.data(withJSONObject: dict, options: opt)
            return try decoder.decode(Base.self, from: data)
            
        } catch {
            print("字典转模型失败:\(error)")
            return nil
        }
    }
    
    // data 转模型
    func deserialize(_ data: Data?) -> Base? {
        guard let data = data else { return nil }
        do {
            return try decoder.decode(Base.self, from: data)
        } catch {
            print("字典转模型失败:\(error)")
            return nil
        }
    }
}

// MARK: - 模型转字典、json
public extension ZHCodableWrapper where Base: ZHCodable {
    
    // 模型转字典
    func toDict() -> [String : Any]? {
        guard let base = base else {
            print("模型转字典 base 为空")
            return nil
        }
        guard let json = base.zh.toJSONString() else {
            print("模型转字典失败")
            return nil
        }
        return json.zh.toDict()
    }
    
    // 模型转 json
    func toJSONString() -> String? {
        guard let base = base else {
            print("模型转json base 为空")
            return nil
        }
        do {
            let encoder = JSONEncoder()
            if #available(iOS 13, *) {
                encoder.outputFormatting = .withoutEscapingSlashes
            } else {
                encoder.outputFormatting = .prettyPrinted
            }
            let data = try encoder.encode(base)
            return String(data: data, encoding: .utf8)
        } catch {
            print("模型转 json 失败:\(error)")
            return nil
        }
    }
}

// MARK: - String
extension ZHCodableString: ZHCodable {}
public extension ZHCodableWrapper where Base == ZHCodableString {
    func toDict() -> [String : Any]? {
        guard let base = base else {
            print("String 转字典 base 为空")
            return nil
        }
        guard let jsonData:Data = base.data(using: .utf8) else { print("json 转 dict 失败")
            return nil
        }
        do {
            let dict = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            return dict as? [String : Any] ?? ["":""]
        } catch {
            print("json 转 dict 失败:\(error)")
            return nil
        }
    }
}

// MARK: - Array
public struct ZHCodableArrayWrapper<Base, Element> {
    public var base: Base?
    public init(_ base: Base?) {
        self.base = base
    }
}

public extension ZHCodableArray where Element: ZHCodable {
    var zh: ZHCodableArrayWrapper<Self, Element> {
        get {
            return ZHCodableArrayWrapper(self)
        }
    }
    static var zh: ZHCodableArrayWrapper<Self, Element> {
        get {
            return ZHCodableArrayWrapper(nil)
        }
    }
}

// MARK: - 数组方法
public extension ZHCodableArrayWrapper where Element: ZHCodable {
    
    // 数组实例转 json
    func toJSONString() -> String? {
        guard let base = base as? [Element] else {
            print("数组转 json base 为空")
            return nil
        }
        do {
            let encoder = JSONEncoder()
            if #available(iOS 13.0, *) {
                encoder.outputFormatting = .withoutEscapingSlashes
            } else {
                encoder.outputFormatting = .prettyPrinted
            }
            let data = try encoder.encode(base)
            return String(data: data, encoding: .utf8)
        } catch {
            print("模型转 json 失败:\(error)")
            return nil
        }
    }
    
    // 数组实例转 [[String : Any]]
    func toDicts() -> [[String : Any]]? {
        guard let base = base as? [Element] else {
            print("数组转 dict 数组 base 为空")
            return nil
        }
        return base.compactMap {
            $0.zh.toDict()
        }
    }
    
    // json 转模型数组
    func deserialize(_ json: String?) -> [Element]? {
        guard let data = json?.data(using: .utf8) else { return nil }
        do {
            return try decoder.decode([Element].self, from: data)
        } catch {
            print("json 转模型数组失败:\(error)")
            return nil
        }
    }
    
    // array 转模型数组
    func deserialize(_ array: [Any]?) -> [Element]? where Element: ZHCodable {
        if let _array = array as? [[String : Any]] {
            return _array.compactMap { item in
                return Element.zh.deserialize(item)
            }
        } else if let _array = array as? [String] {
            return _array.compactMap { json in
                return Element.zh.deserialize(json)
            }
        }
        return nil
    }
    
    // NSArray 转模型数组
    func deserialize(_ array: NSArray?) -> [Element]? {
        guard let _array = array as? [Any] else { return nil }
        return deserialize(_array)
    }
    
    func deserialize(_ array: [Data]?) -> [Element]? {
        guard let _array = array else { return nil }
        return _array.compactMap { data in
            return Element.zh.deserialize(data)
        }
    }
}
