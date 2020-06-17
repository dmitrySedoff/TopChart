//
//  TopChartsModel.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 15.04.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//

import Foundation

struct CurrentCharts: Codable {
    let artists: Artists?
}

struct Artists: Codable {
    let artist: [Artist]?
}

struct Artist: Codable {
    let name: String?
}


