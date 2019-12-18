//
//  DetailViewController.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "title"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "authoer"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(buttonPressed(_:)))
        return button
    }()
    
    private let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
    
    private let podcast: Podcast
    
    private weak var delegate: FavoritesDelegate?
    
    init(podcast: Podcast, delegate: FavoritesDelegate) {
        self.podcast = podcast
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    @objc private func buttonPressed(_ sender: UIBarButtonItem) {
        print("Button pressed.")
        sender.isEnabled = false
        let favorite = Favorite(favoriteId: nil, createdAt: nil, trackId: podcast.trackId, collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600, favoritedBy: "Ahad")
        GenericCoderService.manager.postJSON(object: favorite, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print("Error occured posting JSON: \(error)")
            case .success:
                self.delegate?.updateFavorites()
            }
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray3
        setupImageView()
        setupTitleLabel()
        setupAuthorLabel()
        setupBarButton()

        titleLabel.text = podcast.collectionName
        authorLabel.text = podcast.artistName
        imageView.getImage(with: podcast.artworkUrl600) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image

                }
            case .failure(let error):
                print("error occured: \(error)")
            }
        }
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 5
        imageView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.height / 3),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    private func setupTitleLabel() {
        let view2 = UIView()
        view.addSubview(view2)
        view.addSubview(titleLabel)
        
        view2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            view2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: view2.centerYAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)])
    }
    
    private func setupAuthorLabel() {
        view.addSubview(authorLabel)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)])
    }
    
    private func setupBarButton() {
        navigationItem.setRightBarButton(barButton, animated: true)
        
        if let favorites = delegate?.favorites {
            if favorites.map({$0.trackId}).contains(podcast.trackId) {
                barButton.isEnabled = false
            } else {
                barButton.isEnabled = true
            }
        }
    }

}
