//
//  MovieTableViewCell.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    // UI elements
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addCornerRadius(radius: 10)
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let userScoreView: DonutProgressBar = {
        let db = DonutProgressBar()
        db.translatesAutoresizingMaskIntoConstraints = false
        db.setSize(CGSize(width: 60, height: 60))
        db.clipsToBounds = false
        return db
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.numberOfLines = 0
        return l
    }()
    
    let releaseLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 18)
        l.numberOfLines = 0
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [movieImageView, titleLabel, releaseLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        // Constraints for stackView to fill the contentView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Constraints for movieImageView to maintain aspect ratio
        movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 16.0/9.0).isActive = true
        
        // Constraints for userScoreView on movieImageView
        movieImageView.addSubview(userScoreView)
        NSLayoutConstraint.activate([
            userScoreView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -10),
            userScoreView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 10)
        ])
    }
    
    func setupData(title: String,
                   releaseDate: String,
                   voteAverage: Double,
                   posterPath: String?) {
        // Set data
        titleLabel.text = title
        releaseLabel.text = releaseDate.convertToStandardDateFormat()
        userScoreView.progress = CGFloat(floatLiteral: voteAverage / 10)
        
        // Set image
        if let url = URL(string: AppUrl.imageBaseUrl.rawValue + (posterPath ?? "")) {
            UIImage.from(url: url) {[weak self] image in
                self?.movieImageView.image = image
            }
        }
    }
}
