//
//  ArticleAPIActionCreator.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

struct ArticleAPIActionCreator {
    static func call<T: QiitaAPIRequest>(request: T,
                                         success: @escaping ((ArticleListModel) -> Void),
                                         failed: @escaping (ApiError) -> Void) -> Store<AppState>.ActionCreator {
        return { state, store in
            HttpsClient().request(request, success: { decodable in
                if let model = decodable as? ArticleListModel { success(model) }
            }, failure: { error in
                failed(error)
            })
            return nil
        }
    }
}
