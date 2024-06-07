//
//  MovieViewModel.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 05/06/24.
//

import Foundation
import Combine

enum TabType: Int {
    case popular = 0
    case latest = 1
}

class MovieViewModel {
    enum Input {
        case viewDidLoad
        case pageDidScrollToEnd
        case tabChanged(to: TabType)
        case pullToRefreshed
    }
    
    enum Output {
        case onReceivedData(movies: [Movie])
        case onErrorOccurred(error: ApiError)
    }
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private var anyCancellables = Set<AnyCancellable>()
    
    private let service: MovieListType
    var currentPage: (popular: Int, latest: Int) = (1, 1)
    var currentTab: TabType = .popular
    
    var isLoadingNextData: Bool = false
    
    init(service: MovieService = MovieService()) {
        self.service = service
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink {[weak self]  input in
            guard let self = self else { return }
            switch input{
            case .viewDidLoad:
                self.fetchMovieList()
            case .tabChanged(to: let tab):
                self.currentTab = tab
                self.fetchMovieList()
            case .pageDidScrollToEnd:
                guard !isLoadingNextData else { return }
                // update page index
                switch currentTab {
                case .popular:
                    currentPage = (currentPage.popular + 1, currentPage.latest)
                case .latest:
                    currentPage = (currentPage.popular, currentPage.latest + 1)
                }
                self.isLoadingNextData = true
                self.fetchMovieList()
            case .pullToRefreshed:
                self.currentPage = (1, 1)
                self.fetchMovieList()
            }
        }.store(in: &anyCancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func fetchMovieList() {
        switch currentTab {
        case .popular:
            fetchPopularMovies()
        case .latest:
            fetchLatestMovies()
        }
    }
    
    private func fetchPopularMovies() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let movies = try await service.callPopularMoviesApi(page: currentPage.popular)
                output.send(.onReceivedData(movies: movies))
                self.isLoadingNextData = false
            }catch let apiError as ApiError {
                output.send(.onErrorOccurred(error: apiError))
            }
        }
    }
    
    private func fetchLatestMovies() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let movies = try await service.callLatestMoviesApi(page: currentPage.popular)
                output.send(.onReceivedData(movies: movies))
            }catch let apiError as ApiError {
                output.send(.onErrorOccurred(error: apiError))
            }
        }
    }
}
