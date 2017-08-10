//
//  ItunesConnection.swift
//  YapoTunes
//
//  Created by Claus on 10/8/17.
//  Copyright © 2017 Claus. All rights reserved.
//

import UIKit

class ItunesConnection: NSObject {
    
    class func getAlbumForString(_ searchString:String, completionHandler:@escaping (Album)->()) {

        let escapedString = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")
        
        
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data:Data!, response:URLResponse!, error:NSError!) -> Void in
            if error == nil {
                //let itunesDict = JSONSerialization.jsonObject(with: data, options: .AllowFragments) as! NSDictionary
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let itunesDict = jsonObject as! NSDictionary
                
                let resultsArray = itunesDict.object(forKey: "results") as! [Dictionary<String,AnyObject>]
                
                
                
                
                
                if resultsArray.count > 0 {
                    if let resultsDict = resultsArray.first {
                        let artist = resultsDict["artistName"] as! String
                        let artworkURL = resultsDict["artworkUrl100"] as! String
                        let albumTitle = resultsDict["collectionName"] as! String
                        let genre = resultsDict["primaryGenreName"] as! String
                        
                        let album = Album(title: albumTitle, artist: artist, genre: genre, artworkURL: artworkURL)
                        
                        DispatchQueue.main.async {
                            completionHandler(album)
                        }
                        
                    }

                    
                }
                
                
                
                
            }
        }as! (Data?, URLResponse?, Error?) -> Void)
        
        task.resume()  
    }
    
}
