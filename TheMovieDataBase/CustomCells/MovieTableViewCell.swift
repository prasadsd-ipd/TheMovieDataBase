//
//  MovieTableViewCell.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 28/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Properties
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(with representable: MovieRepresentable, imageData: Data) {
        
        movieTitle.text = representable.title
        movieReleaseDate.text = representable.releaseDate
        movieDescription.text = representable.overview
        movieImageView?.image = UIImage(data: imageData)
    }
}
