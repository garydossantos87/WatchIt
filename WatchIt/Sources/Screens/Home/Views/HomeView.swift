//
//  HomeView.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 23/2/22.
//

import Foundation
import UIKit

public extension Home {
    final class View: UIView {
        private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.bounces = false
            scrollView.indicatorStyle = .default
//            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
//                                            height: UIScreen.main.bounds.height)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.contentInsetAdjustmentBehavior = .never
            return scrollView
        }()
        private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private let containerStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 10.0
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
                
        private let trending: TitleCollectionView = {
            let trending = TitleCollectionView()
            trending.translatesAutoresizingMaskIntoConstraints = false
            trending.heightAnchor.constraint(equalToConstant: TitleCollectionView.Constansts.CollectionView.height +
                                             TitleCollectionView.Constansts.CollectionView.topSpace * 2).isActive = true
            return trending
        }()
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        private func setup() {
            scrollView.backgroundColor = .lightGray
            containerView.backgroundColor = .blue
            containerStackView.backgroundColor = .yellow
            setupViews()
            setupConstraint()
        }
        
        private func setupViews() {
            addSubview(scrollView)
            scrollView.addSubview(containerStackView)
            containerStackView.addArrangedSubview(trending)
            let button = UIButton()
            button.setTitle("CHUPALO", for: .normal)
            button.backgroundColor = .brown
            containerStackView.addArrangedSubview(button)
        }
        
        private func setupConstraint() {
            scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            containerStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            containerStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10.0).isActive = true
        }
        
        func configure(model: Home.View.Model) {
            trending.configure(model: model.movieModel)
        }
    }
}

extension Home.View {
    struct Model {
        var movieModel: Home.View.TitleCollectionView.Model
    }
}

extension Home.View.Model: Equatable {
    static func == (lhs: Home.View.Model, rhs: Home.View.Model) -> Bool {
        return lhs.movieModel.collectionModel == rhs.movieModel.collectionModel &&
        lhs.movieModel.title == rhs.movieModel.title
    }
}
