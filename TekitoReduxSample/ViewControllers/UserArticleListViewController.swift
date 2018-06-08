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
    
    func inject(listState:ArticleListScreenStateProtocol,
                listActionCreator: ListStateActionCreatorProtocol) {
        self.listState = listState
        self.listActionCreator = listActionCreator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupUI() {
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
        
    }
    
    private func articleEndPointHandler(error: ApiError) {
        
    }
    
    // MARK: -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listState.fetchArticleListCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserArticleListCell", for: indexPath) as? ArticleListCell {
            cell.updateCell(article: listState.fetchArticle(index: indexPath.row))
            return cell
        }
        return ArticleListCell()
    }
}
