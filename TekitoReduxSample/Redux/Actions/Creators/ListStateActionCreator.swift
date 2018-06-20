//
//  ListStateActionCreator.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

protocol ListStateActionCreatorProtocol {
    func generateListUserIdAction() -> Store<AppState>.ActionCreator
    func generateRefreshAction(_ page: Int, isRefresh: Bool) -> Store<AppState>.ActionCreator
    func generateResultAction(_ result: Decodable) -> Store<AppState>.ActionCreator
    func generateResultErrorAdtion(_ error: ApiError) -> Store<AppState>.ActionCreator
    func generateShowMoreLoadingAction(_ isLoading: Bool) -> Store<AppState>.ActionCreator
    func generateMoreListResultAction(_ result: Decodable) -> Store<AppState>.ActionCreator
    func generateFinishMoreListAction(_ isFinish: Bool) -> Store<AppState>.ActionCreator
    func generateResetListAction() -> Store<AppState>.ActionCreator
}
