//
//  CurrentArtistInfo.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 21.04.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//

import Foundation

struct ArtistInfo: Codable {
    let artist: Detail?
}

struct Detail: Codable {
    let bio: Bio?
    let url: String?
}

struct Bio: Codable {
    let published, summary, content: String?
}
