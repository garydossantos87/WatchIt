//
//  MovieCell.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 24/2/22.
//

import UIKit


public extension Home.View.TitleCollectionView {
    final class MovieCell: UICollectionViewCell {
        private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = Constansts.View.cornerRadius
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalToConstant: Constansts.View.height).isActive = true
            return view
        }()
        
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: Constansts.ImageView.height).isActive = true
            return imageView
        }()
        
        private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            return stackView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .gray
            label.font = .boldSystemFont(ofSize: Constansts.Label.titelFontSize)
            return label
        }()
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: Constansts.Label.descriptionFontSize)
            return label
        }()
        
        // MARK: - Init
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        // MARK: - Private func 🔒
        
        private func setup() {
            addSubview(containerView)
            containerView.addSubview(imageView)
            containerView.addSubview(stackView)
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(descriptionLabel)
            setupConstraint()
        }
        
        private func setupConstraint() {
            // Container
            containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            containerView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: Constansts.View.spacing).isActive = true
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: Constansts.View.spacing).isActive = true
            // Background Image
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            // StackView
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        }
        
        // MARK: - Public func 🔒
        
        func configure(model: Model) {
            imageView.image = model.backgroundImage
            titleLabel.text = model.title
            descriptionLabel.text = model.description
        }
    }
}

extension Home.View.TitleCollectionView.MovieCell {
    public struct Model: Equatable {
        var title: String
        var description: String
        var backgroundImage: UIImage
    }
    
    enum Constansts {
        public static let reuseIdentifier: String = "MovieCell"
        enum View {
            static let cornerRadius: CGFloat = 4.0
            static let height: CGFloat = 80.0
            static let spacing: CGFloat = 10.0
        }
        enum ImageView {
            static let height: CGFloat = 60.0
        }
        enum Label {
            static let titelFontSize: CGFloat = 16.0
            static let descriptionFontSize: CGFloat = 15.0
        }
    }
}
