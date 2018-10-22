//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Jonathan T. Miles on 9/19/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

public enum DigitAccumulatorError: Error {
    case extraDecimalPoint
    case invalidDigitNumberValue
}

public struct DigitAccumulator {
    
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    
    
    public init() { }
    
    public mutating func add(digit: Digit) throws {
        switch digit {
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        case .number(let value):
            if value < 0 || value > 9 {
                throw DigitAccumulatorError.invalidDigitNumberValue
            }
        }
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits.removeAll()
    }
    
    public func value() -> Double? {
//        var value = 0.0
//        var indexOfDecimal: Int?
//        for i in digits {
//            if i == .decimalPoint {
//                indexOfDecimal = digits.index(of: i)
//            }
//        }
//        var count = 0
//        for i in digits {
//            if indexOfDecimal != nil {
//                if indexOfDecimal == digits.index(of: i) {
//                    break
//                }
//            }
//            if value > 0 {
//                value * 10 + digits.first
//                digits.remove(at: 0)
//
//                count += 1
//            }
//        }
        
        let string = digits.map { (digit) -> String in
            switch digit {
            case let .number(x): return String(x)
            case .decimalPoint: return "."
            }
        }.joined()
        
        return Double(string)
    }
    
    private var digits = [Digit]()
    
}
