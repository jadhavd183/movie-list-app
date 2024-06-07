//
//  MovieAttributesCell.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 07/06/24.
//

import UIKit

class MovieAttributesCell: UITableViewCell {
    let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.numberOfLines = 0
        return l
    }()
    
    let subTitleOrDescriptionLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14)
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
    
    private func setupViews() {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleOrDescriptionLabel)
    }
    
    func setupData(title: String, subTitleOrDescription: String) {
        titleLabel.text = title
        subTitleOrDescriptionLabel.text = subTitleOrDescription
    }
}
