//
//  GetArticleDetailEndPoint.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/18.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import Alamofire

struct GetArticleDetailEndPoint: QiitaAPIRequest {
    typealias Response = ArticleModel
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "/api/v2/items/\(articleId)"
    }
    var parameters: [String: Any]?
    private(set) var articleId = ""
    
    init(id: String) {
        self.articleId = id
    }
}
