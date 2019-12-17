//
//  PodcastTabBarViewController.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class PodcastTabBarController: UITabBarController {
    
    lazy var searchVC = UINavigationController(rootViewController: SearchViewController())
    
    lazy var favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
