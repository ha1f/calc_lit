//
//  Util.swift
//  calculator
//
//  Created by 山口智生 on 2016/02/11.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

extension Double {
    func isInteger() -> Bool {
        if ceil(self) == floor(self) {
            return true
        } else {
            return false
        }
    }
}
