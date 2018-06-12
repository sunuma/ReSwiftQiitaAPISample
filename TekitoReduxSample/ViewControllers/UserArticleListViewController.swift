//
//  UserArticleListViewController.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit
import ReSwift

class UserArticleListViewController: UITableViewController {
    @IBOutlet weak var loadingFooterView: MoreLoadingFooterView!
    let refreshUI = UIRefreshControl()
    // Reswift protocol
    var listState: ArticleListScreenStateProtocol!
    var listActionCreator: ListStateActionCreatorProtocol!
    
    func inject(listState: ArticleListScreenStateProtocol,
                listActionCreator: ListStateActionCreatorProtocol) {
        self.listState = listState
        self.listActionCreator = listActionCreator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        mainStore.subscribe(self)
        refreshData()
    }
    
    private func setupUI() {
        tableView.prefetchDataSource = self
        tableView.rowHeight = CellHeightType.articleList.rawValue
        tableView.addSubview(refreshUI)
        refreshUI.addTarget(self, action: #selector(UserArticleListViewController.refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: true))
        mainStore.dispatch(listActionCreator.generateRefreshAction(1, isRefresh: true))
        let param = GetArticleEndpointParam(perPage: 20, page: listState.pageNumber)
        if let userId = listState.userId {
            let request = GetUserArticleEndpoint(userId: userId, param: param)
            let actionCreator = ArticleAPIActionCreator.call(request: request, success: { [weak self] result in
                self?.refreshDataHandler(result: result)
            }, failed: { [weak self] error in
                self?.articleEndPointHandler(error: error)
            })
            mainStore.dispatch(actionCreator)
        } else {
            let request = GetAllArticleEndPoint(param: param)
            let actionCreator = ArticleAPIActionCreator.call(request: request, success: { [weak self] result in
                self?.refreshDataHandler(result: result)
            }, failed: { [weak self] error in
                self?.articleEndPointHandler(error: error)
            })
            mainStore.dispatch(actionCreator)
        }
    }
    
    private func refreshDataHandler(result: ArticleListModel) {
        let loadingAction = LoadingState.LoadingAction(isLoading: false)
        mainStore.dispatch(loadingAction)
        let pageNumber = listState.pageNumber
        let actionCreator = listActionCreator.generateRefreshAction(pageNumber, isRefresh: false)
        mainStore.dispatch(actionCreator)
        let resultAction = listActionCreator.generateResultAction(result)
        mainStore.dispatch(resultAction)
    }
    
    private func articleEndPointHandler(error: ApiError) {
    }
}

extension UserArticleListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listState.fetchArticleListCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userArticleListCell, for: indexPath) {
            cell.updateCell(article: listState.fetchArticle(index: indexPath.row))
            return cell
        }
        return ArticleListCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}

extension UserArticleListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("___________ prefetchRowsAt")
        let param = GetArticleEndpointParam(perPage: 20, page: listState.pageNumber)
        if let userId = listState.userId {
            let request = GetUserArticleEndpoint(userId: userId, param: param)
            let actionCreator = ArticleAPIActionCreator.call(request: request, success: { result in
                self.moreListResponseHandler(result: result)
            }, failed: { [weak self] error in
                self?.articleEndPointHandler(error: error)
            })
            mainStore.dispatch(actionCreator)
        } else {
            let request = GetAllArticleEndPoint(param: param)
            let actionCreator = ArticleAPIActionCreator.call(request: request, success: { result in
                self.moreListResponseHandler(result: result)
            }, failed: { [weak self] error in
                self?.articleEndPointHandler(error: error)
            })
            mainStore.dispatch(actionCreator)
        }
    }
    
    private func moreListResponseHandler(result: ArticleListModel) {
        mainStore.dispatch(listActionCreator.generateShowMoreLoadingAction(false))
        if let artileList = result.articleModels, artileList.count != 0 {
            let action = listActionCreator.generateMoreListResultAction(artileList)
            mainStore.dispatch(action)
        } else {
            let action = listActionCreator.generateFinishMoreListAction(true)
            mainStore.dispatch(action)
        }
    }
}

extension UserArticleListViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    func newState(state: AppState) {
        if let userId = listState.userId {
            //listState = state.userArticleList
        } else {
            listState = state.home
        }
//        if listState.hasError() {
//            showErrorDialog()
//            return
//        }
//        if listState.isRefresh && listState.pageNumber == 0 {
//            expireCache()
//        }
        reloadView()
    }
}

extension UserArticleListViewController {
    private func showErrorDialog() {
        let alert = UIAlertController(title: "エラー", message:
            "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    private func updateMoreLoadingIndicator() {
        loadingFooterView.updateIndicatorView(showIndicator: listState.showMoreLoading)
    }
    
    private func reloadView() {
        updateMoreLoadingIndicator()
        guard listState.fetchArticleListCount() > 0 else { return }
        if listState.showMoreLoading || listState.isRefresh { return }
        tableView.reloadData()
        refreshUI.endRefreshing()
    }
}
