//
//  QiitaAPIRequest.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

protocol QiitaAPIRequest: BaseRequest {
}

extension QiitaAPIRequest {
    var baseUrl: URL {
        return URL(string: "https://qiita.com/" + path)!
    }
    
    var httpHeaderFields: [String: String]? {
        let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let secretDict = NSDictionary(contentsOfFile: filePath)
        if let secretDic = secretDict, let accessToken = secretDic["AccessToken"] as? String {
            return ["Authorization": "Bearer \(accessToken)"]
        }
        return nil
    }
}

extension QiitaAPIRequest where Response: Decodable {
    func response(from data: Data, response: HTTPURLResponse) -> Response? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Response.self, from: data)
            //appDump(data)
            return decodeData
        } catch {
            appPrint("request error = \(error.localizedDescription)")
            fatalError()
        }
        return nil
    }
}
