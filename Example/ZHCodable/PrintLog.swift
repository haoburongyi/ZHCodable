//
//  PrintLog.swift
//  ZHCodable_Example
//
//  Created by 张淏 on 2022/1/12.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

func printLog<T>(_ message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
//    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method):\n \(message)")
//    #endif
}
