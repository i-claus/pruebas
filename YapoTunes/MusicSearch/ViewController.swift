//
//  ViewController.swift
//  YapoTunes
//
//  Created by Claus on 10/8/17.
//  Copyright © 2017 Claus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    
    var numberOfItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pageIndicator.numberOfPages = 0
        
        scrollView.delegate = self
        
        
        
    }

    @IBAction func searchForMusic(_ sender: AnyObject) {
        searchTextField.resignFirstResponder()
        
        if searchTextField.text != "" {
            ItunesConnection.getAlbumForString(searchTextField.text!, completionHandler: { (album:Album) -> () in
                
                self.numberOfItems += 1
                self.pageIndicator.numberOfPages = self.numberOfItems
                //var numPag = CGFloat(self.numberOfItems) * self.scrollView.frame.size.width
                
                // tengo un error aqui
                //self.scrollView.contentSize = CGRect(origin: CGFloat(self.numberOfItems) * self.scrollView.frame.size.width, size: self.scrollView.frame.height)
                
                let musicView = Bundle.main.loadNibNamed("MusicView", owner: self, options: nil)?.last as! MusicView
                
                musicView.frame = CGRect(x: CGFloat(self.numberOfItems - 1) * self.scrollView.frame.size.width, y:0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
                musicView.updateConstraints()

                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    musicView.addDataToMusicView(album)
                    self.scrollView.addSubview(musicView)
                    
                    self.scrollView.scrollRectToVisible(musicView.frame, animated: true)
                })
                
                
                
                
                
            })
            

        }
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageIndicator.currentPage = page
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

