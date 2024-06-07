//
//  MovieDetailsViewController.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    let tableView = UITableView()
    
    let vm: MovieDetailsViewModel
    var anyCancellables = Set<AnyCancellable>()
    let input: PassthroughSubject<MovieDetailsViewModel.Input, Never> = .init()
    
    //data
    var movieDetail: MovieDetail?
    
    init(movieId: Int) {
        self.vm = MovieDetailsViewModel(movieId: movieId)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // regiser cell
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieConstants.CellId.movieCellId)
        tableView.register(MovieAttributesCell.self, forCellReuseIdentifier: MovieConstants.CellId.movieAttributeCellId)
        
        bind()
        
        input.send(.viewDidLoad)
    }
    
    private func bind() {
        vm.transform(input: input.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink { [weak self]  event in
                guard let self = self else { return }
                switch event {
                case .onReceivedData(movies: let movieDetail):
                    self.movieDetail = movieDetail
                    self.navigationItem.title = movieDetail.title
                    self.tableView.reloadData()
                case .onErrorOccurred(error: let error):
                    self.showApiErrorAlert(message: error.localizedDescription)
                }
            }.store(in: &anyCancellables)
    }
    
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieDetail = movieDetail else { return 0 }
        return 1 + movieDetail.getAttributes().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movieDetail = movieDetail else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieConstants.CellId.movieCellId, for: indexPath) as! MovieTableViewCell
            cell.setupData(title: movieDetail.title, releaseDate: movieDetail.releaseDate, voteAverage: movieDetail.voteAverage, posterPath: movieDetail.posterPath)
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieConstants.CellId.movieAttributeCellId, for: indexPath) as! MovieAttributesCell
            let attribute = movieDetail.getAttributes()[indexPath.row - 1]
            cell.setupData(title: attribute.title, subTitleOrDescription: attribute.subtitleOrDescription)
            cell.selectionStyle = .none
            return cell
        }
    }
}
