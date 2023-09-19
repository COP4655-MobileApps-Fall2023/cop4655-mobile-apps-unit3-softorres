//
//  MovieCell.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/18/23.
//

import Nuke
import UIKit

class MovieCell : UITableViewCell{
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    func configure(with movie : Movie ) {
        movieNameLabel.text = movie.original_title
        DescriptionLabel.text = movie.overview
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300/" + movie.poster_path.absoluteString)
        
        // Load image async via Nuke library image loading helper method
       // Nuke.loadImage(with: movie.poster_path, into: moviePosterImage)
        Nuke.loadImage(with: imageUrl, into: moviePosterImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
