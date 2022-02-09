//
//  ViewController.swift
//  ZHCodable
//
//  Created by hao on 01/12/2022.
//  Copyright (c) 2022 hao. All rights reserved.
//

import UIKit
@_exported import ZHCodable

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 拿 json
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { fatalError("路径错误") }
        guard let json = try? String.init(contentsOfFile: path) else { return }
        printLog(json)
        
        // json 转模型
        let model = Student.zh.deserialize(json)
        printLog(model)
        
        // 模型转 json
        let modelJSON = model?.zh.toJSONString()
        printLog(modelJSON)
        
        // json 转字典
        let modelDict = modelJSON?.zh.toDict()
        printLog(modelDict)
        
        // 模型转字典
        let modelDict1 = model?.zh.toDict()
        printLog(modelDict1)
        
        // 字典转模型
        let model1 = Student.zh.deserialize(modelDict!)
        printLog(model1)
        
        // json 转模型
        let model2 = Student.zh.deserialize(modelJSON!)
        printLog(model2)
        // 字典转模型
        let model3 = Student.zh.deserialize(modelDict1!)
        printLog(model3)

        // Array
        let array: [Student] = [model!, model1!, model2!, model3!]
        printLog(array)
        // 数组转 json
        let arrayJSON = array.zh.toJSONString()
        printLog(arrayJSON)
        // 数组转元素是字典的数组 [[String : Any]]
        let arrayDicts = array.zh.toDicts()
        printLog(arrayDicts)
        
        // 根据 json 转模型的数组
        let array1 = [Student].zh.deserialize(arrayJSON!)
        printLog(array1)
        
        let schoolDict1 = ["name" : "北京市第一中学", "address" : "北京市大兴区"]
        let schoolDict2 = ["name" : "深圳市第六中学", "address" : "深圳市南山区"]
        let schoolArray = [schoolDict1, schoolDict2]
        let dict1: [String : Any] = ["age" : 10, "name" : "zhangsan", "weight" : 100, "school" : schoolArray]
        let dict2: [String : Any] = ["age" : 16, "name" : "lisi", "weight" : 200, "school" : schoolArray]
        let dict3: [String : Any] = ["age" : 20, "name" : "wangwu", "weight" : 300, "school" : schoolArray]
        let schoolJSON1 = Student.zh.deserialize(dict1)!.zh.toJSONString()!
        let schoolJSON2 = Student.zh.deserialize(dict2)!.zh.toJSONString()!
        let schoolJSON3 = Student.zh.deserialize(dict3)!.zh.toJSONString()!
        let jsonArray = [schoolJSON1, schoolJSON2, schoolJSON3] as [Any]
        let jsonDictArray = NSArray.init(array: jsonArray as [Any])
        let dictArray = [dict1, dict2, dict3]
        let dictNSArray = NSArray.init(array: dictArray)
        
        // 根据元素是 json 的 array 转模型数组
        let array2 = [Student].zh.deserialize(jsonArray)
        printLog(array2)
        
        // 根据元素是 json 的 NSArray 转模型数组
        let array3 = [Student].zh.deserialize(jsonDictArray)
        printLog(array3)
        
        // 根据元素是字典的 array 转模型数组
        let array4 = [Student].zh.deserialize(dictArray)
        printLog(array4)
        
        // 根据元素是字典的 NSArray 转模型数组
        let array5 = [Student].zh.deserialize(dictNSArray)
        printLog(array5)
        
        // 自定义字段
        let personDict: [String : Any] = ["first_name" : "zhang", "age" : 10]
        let person = Person.zh.deserialize(personDict)
        printLog("person.age: \(person?.age?.intValue ?? 0), person.firstName: \(person?.firstName ?? "none")")
        printLog(person?.age?.stringValue)
        printLog(person?.age?.doubleValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

