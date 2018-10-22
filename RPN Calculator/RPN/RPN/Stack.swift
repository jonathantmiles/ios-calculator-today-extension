//
//  Stack.swift
//  RPN
//
//  Created by Jonathan T. Miles on 9/19/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

// nice typical stack, with generics
struct Stack<T>: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        items = elements
    }
    
    init(_ initialItems: [T] = [T]()) {
        items = initialItems
    }
    
    mutating func push(_ value: T) {
        items.append(value)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    
    func peek() -> T? {
        return items.last
    }
    
    // private(set) means still internal (default) for getting, but now private for setting values
    private(set) var items: [T]
}
