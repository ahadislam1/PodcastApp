//
//  FavoritesViewController.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(PodcastTableViewCell.self, forCellReuseIdentifier: "Podcast Cell")
        return tv
    }()
    
    private weak var delegate: FavoritesDelegate?
    
    private var podcasts = [Podcast]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let stupidPointURL = "https://itunes.apple.com/lookup?id="
    
    init(delegate: FavoritesDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
    }
    
    private func loadData() {
        guard let delegate = delegate else { return }
        
        let numbers = delegate.favorites
            .map({String($0.trackId)})
            .joined(separator: ",")
        
        GenericCoderService.manager.getJSON(objectType: PodcastWrapper.self, with: stupidPointURL + numbers) { result in
            switch result {
            case .failure(let error):
                print("Error occured getting JSON: \(error)")
            case .success(let wrapper):
                self.podcasts = wrapper.results
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray2
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemGroupedBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(podcast: podcasts[tableView.indexPathForSelectedRow!.row], delegate: delegate!), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Podcast Cell", for: indexPath) as? PodcastTableViewCell else {
            print("Cell could not be formed as pocastviewcell.")
            return UITableViewCell()
        }
        
        let podcast = podcasts[indexPath.row]
        cell.titleLabel.text = podcast.collectionName
        cell.authorLabel.text = podcast.artistName
        
        cell.podcastImageView.getImage(with: podcast.artworkUrl600) { result in
            switch result {
            case .failure(let error):
                print("Error occurred getting image :\(error)")
                cell.podcastImageView.image = UIImage(systemName: "xmark.fill")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.podcastImageView.image = image
                }
            }
        }
        return cell
    }
    
}
