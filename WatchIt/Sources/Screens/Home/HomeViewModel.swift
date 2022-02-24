//
//  HomeViewModel.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 24/2/22.
//

import Foundation
import Combine

final class HomeViewModel: HomeViewModelType {
    private var cancellables: [AnyCancellable] = []
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
    
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let movies = input.viewDidAppear
            .flatMap { [unowned self] _ in self.context.getTrendings() }
            .map({ result -> HomeViewModel.State in
                switch result {
                case .success(let homeViewModel): return .success(homeViewModel)
                default: return .loading
                }
            })
            .eraseToAnyPublisher()
        
        let initialState: HomeViewModel.Output = Just(.idle).eraseToAnyPublisher()
        return Publishers.Merge(initialState, movies)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
}
