//
//  ArticleAPIActionCreator.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import RxSwift
import ReSwift

struct ArticleAPIActionCreator {
    func call<T: QiitaAPIRequest>(request: T,
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
    
    func fetchArticleListActionObservable<T: QiitaAPIRequest>(request: T) -> Observable<ArticleListModel> {
        return Observable.create({ (observer) -> Disposable in
            HttpsClient().request(request, success: { decodable in
                if let model = decodable as? ArticleListModel { observer.on(.next(model)) }
                observer.on(.completed)
            }, failure: { error in
                observer.on(.error(error))
            })
            return Disposables.create()
        })
    }
}

extension ArticleAPIActionCreator {
    func fetchArticleDetailActionObservable(articleId: String) -> Observable<ArticleModel> {
        return Observable.create { observer in
            let request = GetArticleDetailEndPoint(id: articleId)
            HttpsClient().request(request, success: { result in
                if let model = result as? ArticleModel { observer.on(.next(model)) }
                observer.on(.completed)
            }, failure: { error in
                observer.on(.error(error))
            })
            return Disposables.create()
        }
    }
}
