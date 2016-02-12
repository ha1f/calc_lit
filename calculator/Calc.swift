//
//  Calc.swift
//  calculator
//
//  Created by 山口智生 on 2016/02/11.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

struct Calc {
    enum CalcOperator: Int {
        case Plus = 0
        case Minus = 1
        case Multiply = 2
        case Devide = 3
        
        static let OPERATOR_STRING = ["+", "-", "×", "÷"]
        
        func toString() -> String {
            return Calc.CalcOperator.OPERATOR_STRING[self.rawValue]
        }
        
        var operate: (Double, Double) -> Double {
            switch self {
            case .Plus:
                return {$0 + $1}
            case .Minus:
                return {$0 - $1}
            case .Multiply:
                return {$0 * $1}
            case .Devide:
                return {$0 / $1}
            }
        }
        
    }
    
    var inputNums: [Double?] = [0.0, nil]
    var result: Double? = nil
    var ope: CalcOperator? = nil
    
    mutating func clear() {
        inputNums = [0.0, nil]
        result = nil
        ope = nil
    }
    
    mutating func calculate() {
        guard let ope = ope, num0 = inputNums[0], num1 = inputNums[1] else {
            return
        }
        result = ope.operate(num0, num1)
    }
}