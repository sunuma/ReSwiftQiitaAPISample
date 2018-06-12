//
//  GetUserArticleEndPoint.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import Alamofire

struct GetUserArticleEndpoint: QiitaAPIRequest {
    typealias Response = ArticleListModel
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "/api/v2/users/\(userId)/items"
    }
    var parameters: [String: Any]?
    private(set) var userId: String
    
    init(userId: String, param: GetArticleEndpointParam) {
        self.userId = userId
        self.parameters = param.getParameter()
    }
}

struct GetArticleEndpointParam: BaseParam {
    private(set) var perPage: Int
    private(set) var page: Int
    
    init(perPage: Int, page: Int) {
        self.perPage = perPage
        self.page = page
    }
    
    func getParameter() -> [String: Any] {
        var param: [String: Any] = [:]
        param["per_page"] = perPage
        param["page"] = page
        return param
    }
}
