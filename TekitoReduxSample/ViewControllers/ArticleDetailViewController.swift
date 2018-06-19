//
//  ArticleDetailViewController.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/18.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift
import UIKit

class ArticleDetailViewController: UITableViewController {
    private var webViewHeight: CGFloat = 0.0
    private var detailState: ArticleDetailState {
        return mainStore.state.articleDetail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
        fetchArticleDetail()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ArticleDetailViewController: StoreSubscriber {
    func newState(state: AppState) {
        
        tableView.reloadData()
    }
}

extension ArticleDetailViewController {
    private func fetchArticleDetail() {
        let creator = ArticleAPIActionCreator()
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: true))
        let observer = creator.fetchArticleDetailActionObservable(articleId: detailState.articleId)
        _ = observer.subscribe { event in
            mainStore.dispatch(LoadingState.LoadingAction(isLoading: false))
            switch event {
            case .next(let articleDetail):
                let action = ArticleDetailState.ArticleDetailAction(articleDetail: articleDetail)
                mainStore.dispatch(action)
                //self?.fetchStockStatus()
            case .completed:
                print("fetchArticleDetailActionObservable subscribe complete")
            case .error(let error):
                mainStore.dispatch(LoadingState.LoadingAction(isLoading: false))
                let action = ArticleDetailState.ArticleDetailErrorAction(error: .resultError(error))
                mainStore.dispatch(action)
            }
        }//.disposed(by: DisposeBag())
    }
    
    private func fetchStockStatus() {
        mainStore.dispatch(LoadingState.LoadingAction(isLoading: true))
    }
}

extension ArticleDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailState.fetchTableSectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailState.fetchTableSectionRowCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.row == 0 ? createTopInfoCell(indexPath: indexPath) : createBodyCell(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? UITableViewAutomaticDimension : webViewHeight
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? UITableViewAutomaticDimension : webViewHeight
    }
    
    private func createTopInfoCell(indexPath: IndexPath) -> ArticleDetailTopInfoCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleDetailTopInfoCell, for: indexPath)!
        cell.update(info: detailState.fetchArticleDetailTopInfo())
        cell.selectedUserAction = { ueserId in
            
        }
        cell.updateStockButtonAction = {
            
        }
        return cell
    }
    
    private func createBodyCell(indexPath: IndexPath) -> ArticleDetailBodyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleDetailBodyCell, for: indexPath)!
        cell.htmlWebView.delegate = self
        cell.loadRenderHtmlBody(html: detailState.fetchHtmlBody())
        return cell
    }
}

extension ArticleDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = webView.scrollView.contentSize.height
        if webViewHeight == height { return }
        webViewHeight = height
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
    }
}
