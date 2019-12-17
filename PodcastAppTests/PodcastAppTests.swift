//
//  PodcastAppTests.swift
//  PodcastAppTests
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import XCTest
@testable import PodcastApp

class PodcastAppTests: XCTestCase {

    func testPodcast() {
        let endpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=swift"
        let count = 123
        var podcasts = [Podcast]()
        let exp = XCTestExpectation(description: "Succesfully decoded JSON")
        
        GenericCoderService.manager.getJSON(objectType: PodcastWrapper.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error occured: \(error)")
            case .success(let wrapper):
                podcasts = wrapper.results
                XCTAssertEqual(count, podcasts.count)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 20)
    }
    
    func testGetFavorites() {
        let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        var favorites = [Favorite]()
        let exp = XCTestExpectation(description: "Successfully decoded JSON")
        
        GenericCoderService.manager.getJSON(objectType: [Favorite].self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error occured: \(error)")
            case .success(let favoritesFromAPI):
                favorites = favoritesFromAPI
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 20)
    }
    
    func testPostFavorites() {
        let endpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        let favorite = Favorite(favoriteId: nil, createdAt: nil, trackId: 1315130780, collectionName: "Developing iOS 11 Apps with Swift", artworkUrl600: "https://is5-ssl.mzstatic.com/image/thumb/Music118/v4/ea/f6/88/eaf68894-0e28-354b-19d0-ff4d05c18539/source/600x600bb.jpg", favoritedBy: "Ahad")
        let exp = XCTestExpectation(description: "Succesfully uploaded my favorite.")
        
        GenericCoderService.manager.postJSON(object: favorite, with: endpointURL) { (result) in
            switch result {
            case .failure(let error):
                XCTFail("Error encoding object: \(error)")
            case .success:
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 20)
    }

}
