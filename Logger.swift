//
//  Logger.swift
//  ZHCodable
//
//  Created by 张淏 on 2022/2/10.
//

import Foundation

struct InternalLogger {
    
    static func logDebug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
            print(items, separator: separator, terminator: terminator)
#endif
    }
}

//        print("\((file as NSString).lastPathComponent)[\(line)], \(method):\n \(message)")

