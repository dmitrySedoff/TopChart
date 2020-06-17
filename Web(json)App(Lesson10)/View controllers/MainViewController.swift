//
//  MainViewController.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 01.05.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class MainViewController: UICollectionViewController {
    
    let image = UIImage()
    
    // MARK: - Массивы с данными наполняемые из json
    
    private var artistList: [Artist] = []
    private var filteredArtistList = [Artist]()
    
    private var networkManager = NetworkManager()
    
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

        collectionView.backgroundColor = UIColor(hexString: "0779e4")
        setupNavigationBar()
        setupSearchController()
        
        //заполняем таблицу артистами
        networkManager.fetchCH(completionHandler: { artists in
            self.artistList = artists?.artists?.artist ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArtistList.count
        }
        return artistList.count - 40
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor(hexString: "4cbbb9")
        cell.label.textColor = UIColor(hexString: "eff3c6")
        
        var artist: Artist
        if isFiltering {
            artist = filteredArtistList[indexPath.row]
        } else {
            artist = artistList[indexPath.row]
        }
        
        cell.label.text = artist.name
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var name = ""
        if filteredArtistList.count == 0 {
            name = artistList[indexPath.row].name ?? ""
        } else {
            name = filteredArtistList[indexPath.row].name ?? ""
        }
        self.performSegue(withIdentifier: "showInfo", sender: name)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showInfo" else { return }
        let infoVC = segue.destination as! ArtistInfoViewController
        infoVC.artistName = sender as? String
    }
    
    // MARK: - Setup navBar with code
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(hexString: "0779e4")
        navBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredArtistList = artistList.filter({ (artistList: Artist) -> Bool in
            return (artistList.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        
        if filteredArtistList.count == 0 {
            networkManager.fetchS(artistName: searchText) { SearchResult in
                guard let searchResult = SearchResult?.results?.artistmatches?.artist else { return }
                self.filteredArtistList += searchResult
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        collectionView.reloadData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
