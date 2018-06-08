//
//  MoreLoadingFooterView.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit

class MoreLoadingFooterView: UIView {
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    func updateIndicatorView(showIndicator: Bool) {
        showIndicator ? showIndicatorView() : hideIndicatorView()
    }
    
    private func showIndicatorView() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        frame.size.height = 44.0
    }
    
    private func hideIndicatorView() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        frame.size.height = 0.0
    }
}
