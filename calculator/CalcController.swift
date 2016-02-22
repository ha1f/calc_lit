//
//  CalcController.swift
//  calculator
//
//  Created by 山口智生 on 2016/02/11.
//  Copyright © 2016年 ha1f. All rights reserved.
//

class CalcController {
    // 1.0なら整数入力モード、0.0*1なら小数入力モード
    private var inputPlace: Double = 1.0
    
    var phase: Int = 0
    
    static let PHASE_NUM0 = 0
    static let PHASE_NUM1 = 1
    static let PHASE_RESULT = 2
    
    var calc = Calc()
    
    func doubleToString(number: Double) -> String {
        var stringData = ""
        if number.isInteger() {
            stringData = String(format: "%g", number)
        } else {
            stringData = String(number)
        }
        
        if inputPlace == 0.1 {
            stringData += "."
        }
        return stringData
    }
    
    func composePanelString() -> String {
        var string = doubleToString(calc.inputNums[0]!)
        
        guard let ope = calc.ope else {
            return string
        }
        
        string += " " + ope.toString()
        
        guard let num1 = calc.inputNums[1] else {
            return string
        }
        string += " " + doubleToString(num1)
        
        guard let result = calc.result else {
            return string
        }
        string += " = " + doubleToString(result)
        return string
    }
    
    func clear() {
        calc.clear()
        inputPlace = 1.0
        phase = CalcController.PHASE_NUM0
    }
    
    func pressedEnter() {
        guard phase == CalcController.PHASE_NUM1 else {
            return
        }
        
        calc.calculate()
        phase = CalcController.PHASE_RESULT
    }
    
    func pressedDot() {
        guard phase < CalcController.PHASE_RESULT else {
            return
        }
        // 小数入力モードへ
        if inputPlace == 1.0 {
            inputPlace = 0.1
        }
    }
    
    func pressedOperator(ope: Calc.CalcOperator) {
        guard let _ = calc.inputNums[0] else {
            return
        }
        
        calc.ope = ope
        
        if calc.inputNums[1] == nil {
            // ふたつ目の数字の入力へ
            inputPlace = 1.0
            phase = CalcController.PHASE_NUM1
        } else {
            // つづけて計算モードへ
            if calc.result == nil {
                calc.calculate()
            }
            continueCalc()
            phase = CalcController.PHASE_NUM1
        }
    }
    
    func pressedPercent() {
        guard phase < CalcController.PHASE_RESULT else {
            return
        }
        calc.inputNums[phase] = calc.inputNums[phase]! / 100
    }
    
    func pressedPlusMinus() {
        guard phase < CalcController.PHASE_RESULT else {
            return
        }
        calc.inputNums[phase] = -calc.inputNums[phase]!
    }
    
    func pressedNumber(number: Int) {
        guard phase < CalcController.PHASE_RESULT else {
            return
        }
        if inputPlace == 1.0 {
            // 整数入力モード
            if let currentNum = calc.inputNums[phase] {
                calc.inputNums[phase] = currentNum * 10 + Double(number)
            } else {
                calc.inputNums[phase] = Double(number)
            }
        } else {
            // 小数入力モード
            calc.inputNums[phase] = calc.inputNums[phase]! + Double(number) * inputPlace
            inputPlace /= 10
            
        }
    }
    
    func continueCalc() {
        // opは維持
        calc.inputNums[0] = calc.result
        calc.inputNums[1] = nil
        calc.result = nil
        inputPlace = 1.0
    }
}
