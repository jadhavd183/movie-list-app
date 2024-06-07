//
//  ViewController.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 05/06/24.
//

import UIKit
import Combine

protocol MovieListDelegate: AnyObject {
    func goDetailsScreen(forMovieId movieId: Int)
}

class AllMoviesVeiwController: UIViewController {
    // ui
    let segmentBar: UISegmentedControl = {
        let sb = UISegmentedControl(items: [MovieConstants.Tab.popularTab, MovieConstants.Tab.latestTab])
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = .white
        sb.selectedSegmentTintColor = UIColor(hex: "133663")
        sb.setTitleTextAttributes([.foregroundColor: UIColor(hex: "93E4BD")], for: .selected)
        sb.layer.cornerRadius = 25
        sb.setSize(height: 50)
        return sb
    }()
    
    let containerView = UIView()
    var pageViewController: UIPageViewController!
    var pages = [UIViewController]()
    var popularMoviesViewController: MovieListViewController!
    var latestMoviesViewController: MovieListViewController!
    
    let vm = MovieViewModel()
    var anyCancellables = Set<AnyCancellable>()
    let input: PassthroughSubject<MovieViewModel.Input, Never> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        setupViews()
        input.send(.viewDidLoad)
    }
    
    private func bind() {
        vm.transform(input: input.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink { [weak self]  event in
                guard let self = self else { return }
                switch event {
                case .onReceivedData(movies: let movies):
                    switch vm.currentTab {
                    case .popular:
                        self.popularMoviesViewController.movies += movies
                    case .latest:
                        self.latestMoviesViewController.movies += movies
                    }
                case .onErrorOccurred(error: let error):
                    self.showApiErrorAlert(message: error.localizedDescription)
                }
            }.store(in: &anyCancellables)
    }
    
    private func setupViews() {
        navigationItem.title = MovieConstants.NavaigationTitle.moviesList
        view.addSubview(segmentBar)

        segmentBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        segmentBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: segmentBar.bottomAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        popularMoviesViewController = MovieListViewController(input: input)
        latestMoviesViewController = MovieListViewController(input: input)
        
        // set delegate for navigating details screen for respective movie
        popularMoviesViewController.delegate = self
        latestMoviesViewController.delegate = self
            
        pages = [popularMoviesViewController, latestMoviesViewController]
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.view.frame = containerView.bounds
        
        // Set the initial view controller
        pageViewController.setViewControllers([popularMoviesViewController], direction: .forward, animated: true, completion: nil)
        segmentBar.selectedSegmentIndex = 0
        
        // add action to segment bar
        segmentBar.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
        
        // set delegate for pageViewController
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    @objc func tabChanged(_ sender: UISegmentedControl) {
        if let changedTab = TabType(rawValue: segmentBar.selectedSegmentIndex) {
            input.send(.tabChanged(to: changedTab))
        }
        let selectedVC = pages[sender.selectedSegmentIndex]
        let direction: UIPageViewController.NavigationDirection = sender.selectedSegmentIndex > (pageViewController.viewControllers?.first?.view.tag ?? 0) ? .forward : .reverse
        pageViewController.setViewControllers([selectedVC], direction: direction, animated: true, completion: nil)
    }
}

extension AllMoviesVeiwController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}

extension AllMoviesVeiwController: MovieListDelegate {
    func goDetailsScreen(forMovieId movieId: Int) {
        let detailsVC = MovieDetailsViewController(movieId: movieId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
