//
//  UIImageView+Extensions.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 30/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    func loadThumbnail(urlSting: String) {
        
        guard let url = MovieServices.imageBaseURL?.appendingPathComponent(urlSting) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
