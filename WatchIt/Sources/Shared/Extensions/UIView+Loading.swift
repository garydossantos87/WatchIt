//
//  UIView+Helper.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 25/2/22.
//

import Foundation
import UIKit

extension UIView {
    
    enum Constansts {
        static let containerTag: Int = 0001
        static let indicatorTag: Int = 0002
    }
        
    private var indicatorView: UIActivityIndicatorView {
        let loading = UIActivityIndicatorView()
        loading.color = .black
        loading.tag = Constansts.indicatorTag
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.style = .medium
        return loading
    }
    
    private var containerView: UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.tag = Constansts.containerTag
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange70
        return view
    }
        
    // MARK: - Public func 🔓
    
    public func showLoading() {
        addLoading()
    }
    
    public func hideLoading() {
        removeLoading()
    }
    
    // MARK: - Private func 🔒
    
    private func addLoading() {
        guard !isActivityIndicatorShown() else { return }
        let containerView: UIView = self.containerView
        let indicatorView: UIActivityIndicatorView = self.indicatorView
        
        // addSubiews
        containerView.addSubview(indicatorView)
        addSubview(containerView)

        //add containerView constraints
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        //add indicator constraints
        indicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        indicatorView.startAnimating()
    }
    
    private func removeLoading() {
        guard let containerView = getContainerView(), let indicatorView = getActivityIndicatorView() else { return }
        UIView.animate(withDuration: 0.2, animations: {
            containerView.alpha = 0.0
            indicatorView.stopAnimating()
        }) { _ in
            containerView.removeFromSuperview()
            indicatorView.removeFromSuperview()
        }
    }
    
    private func isActivityIndicatorShown() -> Bool {
        getActivityIndicatorView() != nil && getContainerView() != nil
    }
    
    private func getActivityIndicatorView() -> UIActivityIndicatorView? {
        viewWithTag(Constansts.indicatorTag) as? UIActivityIndicatorView
    }
    
    private func getContainerView() -> UIView? {
        viewWithTag(Constansts.containerTag)
    }
}

