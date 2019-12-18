//
//  ViewController.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search your podcasts here..."
        return sb
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(PodcastTableViewCell.self, forCellReuseIdentifier: "Podcast Cell")
        return tv
    }()
    
    private var searchQuery: String? = nil
    
    private var podcasts = [Podcast]() {
        didSet {
            tableView.reloadData()
        }
    }
        
    private let url = "https://itunes.apple.com/search?media=podcast&limit=200&term="
    
    private weak var delegate: FavoritesDelegate?
    
    init(delegate: FavoritesDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupView()
    }
    
    private func loadData() {
        let urlString = url + searchQuery!
        
        GenericCoderService.manager.getJSON(objectType: PodcastWrapper.self, with: urlString) { result in
            switch result {
            case .failure(let error):
                print("Error occurred getting JSON: \(error)")
            case .success(let wrapper):
                DispatchQueue.main.async {
                self.podcasts = wrapper.results
                }
            }
        }
    }
    
    private func setupView() {
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }


}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(podcast: podcasts[tableView.indexPathForSelectedRow!.row], delegate: delegate!), animated: true)
    }
}
extension SearchViewController: UITableViewDataSource {
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = searchBar.text?.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        loadData()
    }
}
