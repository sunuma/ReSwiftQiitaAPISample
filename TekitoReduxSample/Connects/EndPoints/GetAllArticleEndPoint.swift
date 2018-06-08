//
//  GetAllArticleEndPoint.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import Alamofire


struct GetAllArticleEndPoint: QiitaAPIRequest {
    typealias Response = ArticleListModel
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "/api/v2/items"
    }
    var parameters: [String: Any]?
    
    init(param: GetArticleEndpointParam) {
        self.parameters = param.getParameter()
    }
    
}
