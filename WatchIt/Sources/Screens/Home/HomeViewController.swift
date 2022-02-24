//
//  HomeViewController.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 23/2/22.
//

import Foundation
import UIKit
import Combine

public extension Home {
    final class ViewController: UIViewController {
        
        private var cancellables: [AnyCancellable] = []
        private let viewDidAppear = PassthroughSubject<Void, Never>()
        private let viewModel: HomeViewModelType
        private let homeView: Home.View
        
        required init(viewModel: HomeViewModelType) {
            self.viewModel = viewModel
            homeView = Home.View()
            super.init(nibName: nil, bundle: nil)
        }
        
        @available(*, unavailable)
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            preconditionFailure("Error")
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        public override func loadView() {
            self.view = homeView
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isHidden = true
        }
        
        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            viewDidAppear.send()
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            configure(viewModel: viewModel)
        }
        
        // MARK: - Private Func 🔒
        
        private func configure(viewModel: HomeViewModelType) {
            cancellables.forEach { $0.cancel() }
            cancellables.removeAll()
            let input = HomeViewModel.Input(viewDidAppear: viewDidAppear.eraseToAnyPublisher())
            let output = viewModel.transform(input: input)
            output.sink(receiveValue: {[unowned self] state in
                self.render(state)
            }).store(in: &cancellables)
        }
        
        private func render(_ state: HomeViewModel.State) {
            switch state {
            case .idle:
                //            alertViewController.view.isHidden = false
                //            alertViewController.showStartSearch()
                //            loadingView.isHidden = true
                //            update(with: [], animate: true)
                homeView.configure(model: Home.View.Model(movieModel: Home.View.TitleCollectionView.Model(title: "IDLE", collectionModel: [])))
            case .loading:
                //            alertViewController.view.isHidden = true
                //            loadingView.isHidden = false
                //            update(with: [], animate: true)
                homeView.configure(model: Home.View.Model(movieModel: Home.View.TitleCollectionView.Model(title: "LOADING", collectionModel: [])))
            case .failure:
                //            alertViewController.view.isHidden = false
                //            alertViewController.showDataLoadingError()
                //            loadingView.isHidden = true
                //            update(with: [], animate: true)
                homeView.configure(model: Home.View.Model(movieModel: Home.View.TitleCollectionView.Model(title: "FAILURE", collectionModel: [])))
            case .success(let model):
                //            alertViewController.view.isHidden = true
                //            loadingView.isHidden = true
                homeView.configure(model: model)
            }
        }
    }
}
