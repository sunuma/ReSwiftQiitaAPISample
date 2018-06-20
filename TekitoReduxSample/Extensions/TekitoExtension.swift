//
//  TekitoExtension.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/20.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

extension String {
    func toBool() -> Bool? {
        switch self {
        case "TRUE", "True", "true", "YES", "Yes", "yes", "1":
            return true
        case "FALSE", "False", "false", "NO", "No", "no", "0":
            return false
        default:
            return nil
        }
    }
}
