//
//  File.swift
//  AppYapo
//
//  Created by Claus on 31/7/17.
//  Copyright © 2017 Claus. All rights reserved.
//

import UIKit

class SpotifyPhoto : Equatable {
    var thumbnail : UIImage?
    var largeImage : UIImage?
    let photoID : String
    
    init (photoID:String) {
        self.photoID = photoID
    }
    
    func spotifyImageURL(_ size:String = "m") -> URL? {
        
        //url caratula de artista
        if let url =  URL(string: ".jpg") {
            return url
        }
        return nil
    }
    
    func loadLargeImage(_ completion: @escaping (_ spotifyPhoto:SpotifyPhoto, _ error: NSError?) -> Void) {
        guard let loadURL = flickrImageURL("b") else {
            DispatchQueue.main.async {
                completion(self, nil)
            }
            return
        }
        
        let loadRequest = URLRequest(url:loadURL)
        
        URLSession.shared.dataTask(with: loadRequest, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(self, error as NSError?)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(self, nil)
                }
                return
            }
            
            let returnedImage = UIImage(data: data)
            self.largeImage = returnedImage
            DispatchQueue.main.async {
                completion(self, nil)
            }
        }).resume()
    }
    
    func sizeToFillWidthOfSize(_ size:CGSize) -> CGSize {
        
        guard let thumbnail = thumbnail else {
            return size
        }
        
        let imageSize = thumbnail.size
        var returnSize = size
        
        let aspectRatio = imageSize.width / imageSize.height
        
        returnSize.height = returnSize.width / aspectRatio
        
        if returnSize.height > size.height {
            returnSize.height = size.height
            returnSize.width = size.height * aspectRatio
        }
        
        return returnSize
    }
    
}

func == (lhs: SpotifyPhoto, rhs: SpotifyPhoto) -> Bool {
    return lhs.photoID == rhs.photoID
}

