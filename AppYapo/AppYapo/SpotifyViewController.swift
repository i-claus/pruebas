//
//  SpotifyViewController.swift
//  AppYapo
//
//  Created by Claus on 31/7/17.
//  Copyright © 2017 Claus. All rights reserved.
//

import UIKit

final class SpotifyViewController: UICollectionViewController {
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "SpotifyCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    fileprivate var searches = [SpotifySearchResults]()
    
    fileprivate let itemsPerRow: CGFloat = 3
}

// MARK: - Private

private extension SpotifyViewController {
    func photoForIndexPath(_ indexPath: IndexPath) -> SpotifyPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
    }
}

extension SpotifyViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        activityIndicator.removeFromSuperview()
        
        /*
        if let error = error {
            // 2
            print("Error searching : \(error)")
            return
        }
        
        if let results = results {
            // 3
            print("Found \(results.searchResults.count) matching \(results.searchTerm)")
            self.searches.insert(results, at: 0)
            
            // 4
            self.collectionView?.reloadData()
        }
        */

        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}


