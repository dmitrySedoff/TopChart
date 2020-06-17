//
//  ArtistInfoViewController.swift
//  Web(json)App(Lesson10)
//
//  Created by iD on 21.04.2020.
//  Copyright © 2020 DmitrySedov. All rights reserved.
//

import UIKit

class ArtistInfoViewController: UIViewController {

    var myScrollView = UIScrollView()
    var infoLabel = UILabel()
    let networkManager = NetworkManager()
    
    var artistName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "0779e4")
        
        networkManager.fetchAF(artistName: artistName) { artistBiography in
            DispatchQueue.main.async {
                self.infoLabel.text = artistBiography?.artist?.bio?.content
            }
        }
        
        //Создаем и наполняем скролл вью через код
        
        myScrollView = UIScrollView(frame: self.view.bounds)
        
        infoLabel = UILabel(frame: self.view.bounds)
        infoLabel.numberOfLines = 0
        
        myScrollView.addSubview(infoLabel)
        myScrollView.contentSize = self.infoLabel.bounds.size
        self.view.addSubview(myScrollView)
    }
}
