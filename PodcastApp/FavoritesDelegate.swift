//
//  FavoritesDelegate.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/18/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

protocol FavoritesDelegate: AnyObject {
    var favorites: [Favorite] { get }
    func updateFavorites()
}
