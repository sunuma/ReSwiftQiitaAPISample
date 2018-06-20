//
//  GetArticleStockStatusEndPoint.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/19.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import Alamofire

struct GetArticleStockStatusEndPoint: QiitaAPIRequest {
    typealias Response = String
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "api/v2/items/\(articleId)/stock"
    }
    var parameters: [String: Any]?
    private(set) var articleId = ""
    
    init(id: String) {
        self.articleId = id
    }
}
