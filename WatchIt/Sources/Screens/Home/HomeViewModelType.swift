//
//  HomeViewModelType.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 24/2/22.
//

import Combine

extension HomeViewModel {
        typealias Output = AnyPublisher<HomeViewModel.State, Never>
        
        struct Input {
            let viewDidAppear: AnyPublisher<Void, Never>
//            let selected: AnyPublisher<Int, Never>
        }
        
        enum State {
            case idle
            case loading
            case success(Home.View.Model)
            case failure(Error)
        }
    
    struct Context {
        let getTrendings: Home.UseCase.GetTrendings
    }
}

extension HomeViewModel.State: Equatable {
    static func == (lhs: HomeViewModel.State, rhs: HomeViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success(let lhsModel), .success(let rhsModel)): return lhsModel == rhsModel
        case (.failure, .failure): return true
        default: return false
        }
    }
}

protocol HomeViewModelType {
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output
}
