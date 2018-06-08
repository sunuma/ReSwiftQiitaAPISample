//
//  BaseRequest.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRequest {
    associatedtype Response
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var httpHeaderFields: [String: String]? { get }
    func response(from data: Data, response: HTTPURLResponse) -> Response?
}

///　リクエストパラメータープロトコル
protocol BaseParam {
    func getParameter() -> [String: Any]
}

struct APIParam: BaseParam {
    func getParameter() -> [String: Any] {
        let param: [String: Any] = [:]
        return param
    }
}
