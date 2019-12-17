//
//  Podcast.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct PodcastWrapper: Codable {
    let results: [Podcast]
}

struct Podcast: Codable {
    let trackId: Int
    let collectionName: String
    let artistName: String
    let artworkUrl100: String
    let artworkUrl600: String
}
