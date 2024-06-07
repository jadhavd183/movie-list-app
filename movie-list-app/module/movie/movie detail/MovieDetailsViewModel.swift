//
//  MovieDetailsViewModel.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation
import Combine
import http_client

class MovieDetailsViewModel {
    
    enum Input {
        case viewDidLoad
        case pullToRefreshed
    }
    
    enum Output {
        case onReceivedData(movies: MovieDetail)
        case onErrorOccurred(error: ApiError)
    }
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private var anyCancellables = Set<AnyCancellable>()
    
    private let service: MovieDetailsType
    private let movieId: Int
    
    init(movieId: Int, service: MovieService = MovieService()) {
        self.movieId = movieId
        self.service = service
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink {[weak self]  input in
            guard let self = self else { return }
            switch input{
            case .viewDidLoad, .pullToRefreshed:
                self.getMovieDetails()
            }
        }.store(in: &anyCancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    func getMovieDetails() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let movieDetails = try await service.callMovieDetailsByIdApi(movieId: String(describing: self.movieId))
                output.send(.onReceivedData(movies: movieDetails))
            }catch let apiError as ApiError {
                output.send(.onErrorOccurred(error: apiError))
            }
            
        }
    }
}
