//
//  MusicView.swift
//  YapoTunes
//
//  Created by Claus on 10/8/17.
//  Copyright © 2017 Claus. All rights reserved.
//

import UIKit

class MusicView: UIView {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    func addDataToMusicView (_ album:Album) {
    
        artworkImageView.image = UIImage(data: try! Data(contentsOf: URL(string: album.artworkURL)!))
        titleLabel.text = album.title
        artistLabel.text = album.artist
        genreLabel.text = album.genre
    }
    

}
