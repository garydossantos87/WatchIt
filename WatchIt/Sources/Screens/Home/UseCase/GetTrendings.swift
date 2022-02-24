//
//  GetTrendings.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 24/2/22.
//

import Combine

extension Home.UseCase {
    typealias GetTrendings = () -> AnyPublisher<Result<Home.View.Model, Error>, Never>
    static func getTrendings() -> GetTrendings {
        return {
            let titleCollection = [
                Home.View.TitleCollectionView.MovieCell.Model(title: "title", description: "description", backgroundImage: .add),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title2", description: "description2", backgroundImage: .checkmark),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title3", description: "description3", backgroundImage: .actions),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title4", description: "description4", backgroundImage: .remove),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title5", description: "description5", backgroundImage: .strokedCheckmark),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title6", description: "description6", backgroundImage: .checkmark),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title7", description: "description7", backgroundImage: .strokedCheckmark),
                Home.View.TitleCollectionView.MovieCell.Model(title: "title8", description: "description8", backgroundImage: .remove)
            ]
            
            let modelMocks = Home.View.Model(movieModel: Home.View.TitleCollectionView.Model(title: "Trending",
                                                                                             collectionModel: titleCollection))
            
            let result = Result<Home.View.Model, Error>.success(modelMocks)
            return Just<Result<Home.View.Model, Error>>(result).eraseToAnyPublisher()
        }
    }
}
