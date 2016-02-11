//
//  ModelManager.swift
//  calculator
//
//  Created by 山口智生 on 2016/02/11.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

class ModelManager {
    static let manager = ModelManager()
    
    private var _calcController: CalcController!
    var calcController: CalcController {
        if _calcController == nil {
            _calcController = CalcController()
        }
        return _calcController
    }
}