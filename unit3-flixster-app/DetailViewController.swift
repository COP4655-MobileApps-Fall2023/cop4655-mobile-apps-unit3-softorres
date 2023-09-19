//
//  DetailViewController.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/18/23.
//subclass of UIViewController

import UIKit
import Nuke

class DetailViewController: UIViewController {
    var movie: Movie!
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var popular: UILabel!
    
    
    @IBOutlet weak var VoteA: UILabel!
    
    @IBOutlet weak var VoteC: UILabel!
    
 
    @IBOutlet weak var shortDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            //to load backdrop append url 
            let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w300/" + movie.backdrop_path.absoluteString)
            
            Nuke.loadImage(with: backdropUrl, into: movieImageView)
        
        // Set labels with the associated track values.
        movieTitleLabel.text = movie.original_title
        shortDescription.text = movie.overview
        popular.text = String(movie.popularity) + " Popularity"
        VoteA.text = String(movie.vote_average) + " VoteAverage"
        VoteC.text = String(movie.vote_count) + " Votes"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
