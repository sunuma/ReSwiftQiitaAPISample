//
//  StockStatus.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/19.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit

struct StockStatus {
    let isStock: Bool
    
    func fetchBackgroundColor() -> UIColor {
        return isStock ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func fetchTextColor() -> UIColor {
        return isStock ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func fetchStockStatusTitle() -> String {
        return isStock ? "ストック済み" : "ストック"
    }
}
