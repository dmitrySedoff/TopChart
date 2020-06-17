//
//  SearchResultModel.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 23.04.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//

import Foundation

// MARK: - Empty
struct SearchResult: Codable {
    let results: Results?
}

// MARK: - Results
struct Results: Codable {
    let artistmatches: Artistmatches?
}

// MARK: - Artistmatches
struct Artistmatches: Codable {
    let artist: [Artist]?
}

// MARK: - Artist
struct ArtistFounded: Codable {
    let name: String?

}
