//
//  TableViewController.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 15.04.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//
/*
import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Массивы с данными наполняемые из json
    
    var artistList: [Artist] = []
    private var filteredArtistList = [Artist]()
    
    // MARK: - Свойства search
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchArtistList = [SearchResult]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        
        //заполняем таблицу артистами
        NetworkManager.fetchCurrentCharts(apiMethod: getTopArtist, completionHandler: { currentCharts in
            guard let temp = currentCharts.artists?.artist else { return }
            self.artistList = temp
            
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArtistList.count
        }
        return artistList.count - 40
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var artist: Artist
        if isFiltering {
            artist = filteredArtistList[indexPath.row]
        } else {
            artist = artistList[indexPath.row]
        }
        
        cell.textLabel?.text = artist.name
        
        return cell
    }
    
    // програмный переход
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var name = ""
        if filteredArtistList.count == 0 {
            name = artistList[indexPath.row].name ?? ""
        } else {
            name = filteredArtistList[indexPath.row].name ?? ""
        }
        self.performSegue(withIdentifier: "123", sender: name)
    }
    
    // Отправляем имя на второй экран, чтобы по нему поулчить биографию артиста
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "123" {
            let infoVC = segue.destination as! ArtistInfoViewController
            infoVC.artistName = sender as? String
        }
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension MainTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredArtistList = artistList.filter({ (artistList: Artist) -> Bool in
            return (artistList.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        
        if filteredArtistList.count == 0 {
            NetworkManager.fetchSearchArtist(apiMethod: artistSearch, artistName: searchText) { SearchResult in
                guard let searchResult = SearchResult.results?.artistmatches?.artist else { return }
                self.filteredArtistList += searchResult

                DispatchQueue.main.async {
                   self.tableView.reloadData()
                }
            }
        }        
        tableView.reloadData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
*/
