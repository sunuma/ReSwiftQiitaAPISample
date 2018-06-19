//
//  UserArticleListViewController.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit
import ReSwift

enum ListLoadType {
    case refresh
    case more
}

class UserArticleListViewController: UITableViewController {
    @IBOutlet weak var loadingFooterView: MoreLoadingFooterView!
    private let refreshUI = UIRefreshControl()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI() {
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
            requestArticleList(request: request)
        } else {
            let request = GetAllArticleEndPoint(param: param)
            requestArticleList(request: request)
        }
    }
    
    private func requestArticleList<T: QiitaAPIRequest>(request: T, type: ListLoadType = .refresh) {
        let observer = ArticleAPIActionCreator().fetchArticleListActionObservable(request: request)
        _ = observer.subscribe { [weak self] event in
            switch event {
            case .next(let result):
                if type == .refresh {
                    self?.refreshDataHandler(result: result)
                } else {
                    self?.moreListResponseHandler(result: result)
                }
            case .error(let error):
                self?.articleEndPointHandler(error: .resultError(error))
            case .completed:
                appPrint("fetchArticleListActionObservable subscribe completed")
            }
        }
    }
    
    private func refreshDataHandler(result: ArticleListModel) {
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: false))
        let pageNumber = listState.pageNumber
        mainStore.dispatch(listActionCreator.generateRefreshAction(pageNumber, isRefresh: false))
        mainStore.dispatch(listActionCreator.generateResultAction(result))
    }
    
    private func articleEndPointHandler(error: ApiError) {
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: false))
        mainStore.dispatch(listActionCreator.generateShowMoreLoadingAction(false))
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = listState.fetchArticle(index: indexPath.row)
        let action = ArticleDetailState.ArticleDetailIdAction(articleId: article.fetchId())
        mainStore.dispatch(action)
        let vc = R.storyboard.articleDetail.instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserArticleListViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maxOffsetY = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maxOffsetY - currentOffsetY
        if distanceToBottom < 300 && !mainStore.state.loading.isLoading {
            loadMoreListData()
        }
    }
    
    private func loadMoreListData() {
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: true))
        let pageNumber = listState.pageNumber
        appPrint("___________ loadMoreListData pageNumber = \(pageNumber)")
        let param = GetArticleEndpointParam(perPage: 20, page: pageNumber)
        if let userId = listState.userId {
            let request = GetUserArticleEndpoint(userId: userId, param: param)
            requestArticleList(request: request, type: .more)
        } else {
            let request = GetAllArticleEndPoint(param: param)
            requestArticleList(request: request, type: .more)
        }
    }
    
    private func moreListResponseHandler(result: ArticleListModel) {
        if let artileList = result.articleModels, artileList.count != 0 {
            let action = listActionCreator.generateMoreListResultAction(artileList)
            mainStore.dispatch(action)
        } else {
            let action = listActionCreator.generateFinishMoreListAction(true)
            mainStore.dispatch(action)
        }
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: false))
    }
}

extension UserArticleListViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    func newState(state: AppState) {
        if let _ = listState.userId {
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
        let info = AlertInfo()
        let alert = UIAlertController(title: info.titleError, message:
            info.messageEmpty, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: info.titleOK, style: .default, handler: nil))
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
