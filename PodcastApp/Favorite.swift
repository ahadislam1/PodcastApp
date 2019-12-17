//
//  Favorite.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

let example = """
"favoriteId": "19",
"createdAt": 1546546921,
"trackId": 37,
"collectionName": "Swiftcast: The #1 Taylor Swift Podcast",
"artworkUrl600": "https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/b0/0f/fe/b00ffe70-7182-b670-bb58-d889efceb892/source/600x600bb.jpg",
"favoritedBy": "Aaron Cabreja",
"trackID": 634257561
"""

struct Favorite: Codable {
    let favoriteId: String?
    let createdAt: Int?
    let trackId: Int
    let collectionName: String
    let artworkUrl600: String
    let favoritedBy: String
}

