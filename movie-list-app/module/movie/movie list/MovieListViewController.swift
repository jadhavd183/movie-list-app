//
//  MovieListViewController.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit
import Combine

class MovieListViewController: UIViewController {
    // ui
    let tableView = UITableView()
    
    // data
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: MovieListDelegate?
    
    let input: PassthroughSubject<MovieViewModel.Input, Never>
    
    init(input: PassthroughSubject<MovieViewModel.Input, Never>) {
        self.input = input
        super.init(nibName: nil, bundle: nil) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieConstants.CellId.movieCellId)
    }
}

// MARK: - Extension for UITableViewDelegate and Datasource

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieConstants.CellId.movieCellId, for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.setupData(title: movie.title, releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, posterPath: movie.posterPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = movies[indexPath.row].id
        delegate?.goDetailsScreen(forMovieId: movieId)
    }
    
    // know when user scrolls to end
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            input.send(.pageDidScrollToEnd)
        }
    }
}
