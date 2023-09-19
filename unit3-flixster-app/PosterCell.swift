//
//  PosterCell.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/19/23.
//

import UIKit
import Nuke

class PosterCell: UICollectionViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    func configure(with poster : Poster ) {
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300/" + poster.poster_path.absoluteString)
        // let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w300/" + movie.backdrop_path.absoluteString)
        
        // Load image async via Nuke library image loading helper method
        // Nuke.loadImage(with: movie.poster_path, into: moviePosterImage)
        Nuke.loadImage(with: imageUrl, into: posterImageView)
        
    }
}
