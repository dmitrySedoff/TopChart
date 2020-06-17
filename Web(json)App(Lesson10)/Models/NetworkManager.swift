//
//  NetworkWeatherManager.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 17.04.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    // MARK: - Get data functions
    /*
    func fetchCurrentCharts(completionHandler: @escaping([Artist]) -> Void) {
        guard let url = URL(string: "https://ws.audioscrobbler.com/2.0/?method=\(ApiMethod.getTopArtist.rawValue)&api_key=\(apikey)&format=json" ) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            if let currentCharts = self.parseJSONcurrentCharts(withData: data) {
                guard let temp = currentCharts.artists?.artist else { return }
                completionHandler(temp)
            }
        }.resume()
    }
    
    func fetchArtistInfo(artistName: String, completionHandler: @escaping(ArtistInfo) -> Void) {
        let name = artistName.split(separator: " ").joined(separator: "%20")
        guard let url = URL(string: "https://ws.audioscrobbler.com/2.0/?method=\(ApiMethod.getArtistInfo.rawValue)&artist=\(name)&api_key=\(apikey)&format=json" ) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            if let artistInfo = self.parseJSONartistInfo(withData: data) {
                completionHandler(artistInfo)
            }
        }.resume()
    }
    
    func fetchSearchArtist(artistName: String, completionHandler: @escaping(SearchResult) -> Void) {
        let name = artistName.capitalized.split(separator: " ").joined(separator: "%20")
        guard let url = URL(string: "https://ws.audioscrobbler.com/2.0/?method=\(ApiMethod.artistSearch.rawValue)&artist=\(name)&api_key=\(apikey)&format=json" ) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            if let currentSearchResult = self.parseJSONsearchResults(withData: data) {
                completionHandler(currentSearchResult)
            }
        }.resume()
    }
    
    // MARK: - Parse functions
    
    func parseJSONsearchResults(withData data: Data) -> SearchResult? {
        do {
            let currentSearchResult = try JSONDecoder().decode(SearchResult.self, from: data)
            
            return currentSearchResult
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parseJSONcurrentCharts(withData data: Data) -> CurrentCharts? {
        do {
            let currentChartsData = try JSONDecoder().decode(CurrentCharts.self, from: data)
            
            return currentChartsData
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parseJSONartistInfo(withData data: Data) -> ArtistInfo? {
        do {
            let artistInfoData = try JSONDecoder().decode(ArtistInfo.self, from: data)
            
            return artistInfoData
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    */
    //generics
    
    func decodeJSON<T: Decodable>(type: T.Type, withData data: Data) -> T? {
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            
            return data
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func parseJSON<T: Decodable>(url: URL, completionHandler: @escaping(T) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            if let currentSearchResult = self.decodeJSON(type: T.self, withData: data) {
            completionHandler(currentSearchResult)
            }
        }.resume()
    }
    
    func fetchCH(completionHandler: @escaping(CurrentCharts?) -> Void) {
        guard let urlCH = URL(string: "https://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=745accf8e61b58d0054c066a6070ee88&format=json") else { return }
        parseJSON(url: urlCH, completionHandler: completionHandler)
    }
    
    func fetchAF(artistName: String, completionHandler: @escaping(ArtistInfo?) -> Void) {
        let name = artistName.split(separator: " ").joined(separator: "%20")
        guard let urlAF = URL(string: "https://ws.audioscrobbler.com/2.0/?method=artist.getInfo&artist=\(name)&api_key=745accf8e61b58d0054c066a6070ee88&format=json") else { return }
        parseJSON(url: urlAF, completionHandler: completionHandler)
    }
    
    func fetchS(artistName: String, completionHandler: @escaping(SearchResult?) -> Void) {
        let name = artistName.capitalized.split(separator: " ").joined(separator: "%20")
        guard let urlS = URL(string: "https://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(name)&api_key=745accf8e61b58d0054c066a6070ee88&format=json")
            else { return }
        parseJSON(url: urlS, completionHandler: completionHandler)
    }
}
