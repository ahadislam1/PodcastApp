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
        return sb
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(PodcastTableViewCell.self, forCellReuseIdentifier: "Podcast Cell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupView()
    }
    
    private func setupView() {
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        
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
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Podcast Cell", for: indexPath) as! PodcastTableViewCell
        cell.podcastImageView.image = UIImage(systemName: "xmark")
        cell.titleLabel.text = "text"
        cell.authorLabel.text = "text1"
        return cell
    }
    
}
