//
//  UIViewController+Helper.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 25/2/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    private var overlayContainerView: UIView {
        if let navigationView: UIView = navigationController?.view {
            return navigationView
        }
        return view
    }
    
    func showLoadingView() {
        overlayContainerView.showLoading()
    }
    
    func hideAnimatedActivityIndicatorView() {
        overlayContainerView.hideLoading()
    }
}
