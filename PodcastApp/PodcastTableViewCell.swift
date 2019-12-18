//
//  PodcastTableViewCell.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {
    
    let podcastImageView = UIImageView()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        podcastImageView.image = nil
    }
    
    private func configureView() {
        contentView.addSubview(podcastImageView)
        
        podcastImageView.layer.cornerRadius = 5
        
        podcastImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            podcastImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            podcastImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            podcastImageView.widthAnchor.constraint(equalToConstant: 100),
            podcastImageView.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    private func configureLabels() {
        let labelView = UIView()
        contentView.addSubview(labelView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelView.leadingAnchor.constraint(equalTo: podcastImageView.trailingAnchor),
            labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: labelView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor)])
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)])
    }
}
