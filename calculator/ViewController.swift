//
//  ViewController.swift
//  calculator
//
//  Created by 山口智生 on 2016/02/10.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

extension Double {
    func isInteger() -> Bool {
        if ceil(self) == floor(self) {
            return true
        } else {
            return false
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var panel: UILabel!
    
    var inputNums: [Double] = [0.0, 0.0]
    var ope: MyOperator? = nil
    var resultNum: Double = 0.0
    
    // どこに入力するか
    var inputTargetIndex: Int = 0
    var inputPlace: Double = 1.0
    
    enum MyOperator: Int {
        case Plus = 0
        case Minus = 1
        case Multiply = 2
        case Devide = 3
        
        func toString() -> String {
            switch self {
            case .Plus:
                return "+"
            case .Minus:
                return "-"
            case .Multiply:
                return "×"
            case .Devide:
                return "÷"
            }
        }
        
        func process(num0: Double, num1: Double) -> Double {
            switch self {
            case .Plus:
                return num0 + num1
            case .Minus:
                return num0 - num1
            case .Multiply:
                return num0 * num1
            case .Devide:
                return num0 / num1
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressedNumber(button: UIButton!) {
        if inputTargetIndex >= 2 {
            return
        }
        
        let number = Double(button.tag - 10)
        if inputPlace == 1 {
            inputNums[inputTargetIndex] = inputNums[inputTargetIndex] * 10 + number
        } else {
            inputNums[inputTargetIndex] += number * inputPlace
            inputPlace /= 10
        }
        
        updateView()
    }
    
    @IBAction func onPressedOperand(button: UIButton!) {
        let tag = button.tag - 5
        guard (tag >= 0) && (tag < 4) else {
            return
        }
        
        self.ope = MyOperator(rawValue: tag)
        
        if inputTargetIndex == 0 {
            inputPlace = 1.0
            inputTargetIndex = 1
        }
        
        if inputTargetIndex == 2 {
            inputNums[0] = resultNum
            inputNums[1] = 0.0
            resultNum = 0.0
            inputTargetIndex = 1
        }
        
        updateView()
    }
    
    @IBAction func onPressedDot() {
        guard inputTargetIndex < 2 else {
            return
        }
        
        if inputPlace == 1.0 {
            inputPlace = 0.1
        }
        updateView()
    }
    
    func clear() {
        inputTargetIndex = 0
        inputNums = [0.0, 0.0]
        resultNum = 0.0
        ope = nil
        inputPlace = 1.0
    }
    
    @IBAction func onPressedClear() {
        clear()
        updateView()
    }
    
    @IBAction func onPressedPercent() {
        inputNums[inputTargetIndex] /= 100
        updateView()
    }
    
    @IBAction func onPressedEnter(button: UIButton!) {
        guard let ope = self.ope else {
            return
        }
        
        if inputTargetIndex == 1 {
            inputTargetIndex = 2
            inputPlace = 1.0
            resultNum = ope.process(inputNums[0], num1: inputNums[1])
        }
        
        updateView()
    }
    
    func DoubleToString(number: Double) -> String {
        if number.isInteger() {
            return String(format: "%g", number)
        } else {
            return String(number)
        }
    }
    
    func composePanelString() -> String {
        var string = DoubleToString(inputNums[0])
        
        guard let ope = self.ope else {
            return string
        }
        
        string += " " + ope.toString() + " "
        
        if inputTargetIndex < 1 {
            return string
        }
        string += (inputNums[1] == 0 ?  "" : DoubleToString(inputNums[1]))
        if inputTargetIndex < 2 {
            return string
        }
        string += " = " + DoubleToString(resultNum)
        return string
    }
    
    func updateView() {
        panel.text = composePanelString()
    }

}

