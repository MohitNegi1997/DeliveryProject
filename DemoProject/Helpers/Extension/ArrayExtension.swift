//
//  ArrayExtension.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
    
    ///Removes a given object from array if present. otherwise does nothing
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
        }
    }
    
    ///Removes an array of objects
    mutating func removeObjects(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
    
    ///Removes all null values present in an Array
    mutating func removeNullValues(){
        self = self.compactMap { $0 }
    }
    
    ///Returns a sub array within the range
    subscript(range: Range<Int>) -> Array {
        
        var array = Array<Element>()

        let min = range.lowerBound
        let max = range.upperBound
        
        for i in min..<max {
            array = array+[self[i]]
        }
        return array
    }
    
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
    
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}

extension Array where Element: Numeric {
    /// Returns the total sum of all elements in the array
    var total: Element { return reduce(0, +) }
}

extension Array where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    var average: Double {
        return isEmpty ? 0 : Double(Int(total)) / Double(count)
    }
}

extension Array where Element: FloatingPoint {
    /// Returns the average of all elements in the array
    var average: Element {
        return isEmpty ? 0 : total / Element(count)
    }
}

extension Array {
    func toJSONString() -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString
    }
}
