//
//  ZHNumber.swift
//  ZHCodable
//
//  Created by 张淏 on 2022/2/10.
//  兼容数字类型

public struct ZHNumber: ZHCodable {
    
    public var intValue: Int
    public var stringValue: String
    public var doubleValue: Double
    
    public init(_ intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
        self.doubleValue = Double(intValue)
    }
    
    public init(_ stringValue: String) {
        self.intValue = Int(stringValue) ?? 0
        self.stringValue = stringValue
        self.doubleValue = Double(stringValue) ?? 0
    }
    
    public init(_ doubleValue: Double) {
        self.intValue = Int(doubleValue)
        self.stringValue = String(doubleValue)
        self.doubleValue = doubleValue
    }
    
    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        
        if let stringValue = try? singleValueContainer.decode(String.self) {
            if let intValue = Int(stringValue) {
                self.intValue = intValue
                self.stringValue = String(intValue)
                self.doubleValue = Double(intValue)
            } else {
                self.intValue = 0
                self.stringValue = String(0)
                self.doubleValue = Double(0)
            }
            
        } else if let stringValue = try? singleValueContainer.decode(Int.self) {
            self.intValue = stringValue
            self.stringValue = String(stringValue)
            self.doubleValue = Double(stringValue)
        } else if let doubleValue = try? singleValueContainer.decode(Double.self) {
            self.intValue = Int(doubleValue)
            self.stringValue = String(doubleValue)
            self.doubleValue = doubleValue
        } else {
            self.intValue = 0
            self.stringValue = String(0)
            self.doubleValue = Double(0)
        }
    }
}

/*
 * 兼容 Bool
 */
public struct ZHBoolean: Codable {
    
    public var value: Bool
    
    public init(_ value: Bool) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        
        if let stringValue = try? singleValueContainer.decode(String.self) {
            
            switch stringValue.lowercased() {
            case "0", "false":
                self.value = false
            case "1", "true":
               self.value = true
            default:
                self.value = false
            }
        } else if let intValue = try? singleValueContainer.decode(Int.self) {
            self.value = intValue == 1 ? true : false
        } else if let boolValue = try? singleValueContainer.decode(Bool.self) {
            self.value = boolValue
        } else {
            self.value = false
        }
    }
}
