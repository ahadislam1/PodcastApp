//
//  PodcastTabBarViewController.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class PodcastTabBarController: UITabBarController {
    
    lazy var searchVC: UINavigationController = {
        let vc = SearchViewController(delegate: self)
        return UINavigationController(rootViewController: vc)
    }()
    
    lazy var favoritesVC: UINavigationController = {
        let vc = FavoritesViewController(delegate: self)
        return UINavigationController(rootViewController: vc)
    }()
    
    internal var favorites = [Favorite]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFavorites()
        configureView()
    }
    
    private func configureView() {
        searchVC.tabBarItem = UITabBarItem(title: "Podcasts", image: UIImage(systemName: "play.circle"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        self.viewControllers = [searchVC, favoritesVC]
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension PodcastTabBarController: FavoritesDelegate {
    func updateFavorites() {
        let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        GenericCoderService.manager.getJSON(objectType: [Favorite].self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print("Error occurred getting JSON: \(error)")
            case .success(let favoritesFromAPI):
                self.favorites = favoritesFromAPI.filter({$0.favoritedBy == "Ahad"})
                print(self.favorites.count)
            }
        }
    }
}
