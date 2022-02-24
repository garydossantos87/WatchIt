//
//  TitleCollectionView.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 24/2/22.
//

import Foundation
import UIKit

public extension Home.View {
    final class TitleCollectionView: UIView {
        private var model: Model?
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.Constansts.reuseIdentifier)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.heightAnchor.constraint(equalToConstant: Constansts.CollectionView.height).isActive = true
            return collectionView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: Constansts.Label.fontSize)
            return label
        }()
                
        //MARK: - Init
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        // MARK: - Private func 🔒
        
        private func setup() {
            collectionView.dataSource = self
            collectionView.delegate = self
            addSubview(titleLabel)
            addSubview(collectionView)
            setupConstraint()
        }
        
        private func setupConstraint() {
            // TitleLabel
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            // CollectionView
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Constansts.CollectionView.topSpace).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        // MARK: - Public func 🔓
        
        func configure(model: Model) {
            self.model = model
            collectionView.reloadData()
            titleLabel.text = model.title
        }
    }
}

// MARK: - CollectionView delegate/Datasource

extension Home.View.TitleCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 80)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.collectionModel.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.Constansts.reuseIdentifier,
                                                            for: indexPath) as? Home.View.TitleCollectionView.MovieCell,
              let rowModel = model?.collectionModel[indexPath.row] else {
                  assertionFailure("Failed to dequeue \(Home.View.TitleCollectionView.MovieCell.self)!")
                  return UICollectionViewCell()
              }
        cell.configure(model: rowModel)
        return cell
    }
}

extension Home.View.TitleCollectionView {
    struct Model {
        var title: String
        var collectionModel: [Home.View.TitleCollectionView.MovieCell.Model]
    }
        
    enum Constansts {
        enum CollectionView {
            static let height: CGFloat = 100.0
            static let topSpace: CGFloat = 10.0
        }
        enum Label {
            static let fontSize: CGFloat = 18.0
        }
    }
}

extension Home.View.TitleCollectionView.Model: Equatable {
    static func == (lhs: Home.View.TitleCollectionView.Model, rhs: Home.View.TitleCollectionView.Model) -> Bool {
        return lhs.collectionModel == rhs.collectionModel
    }
}
