//
//  PostersViewController.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/19/23.
//

import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a collection view cell (based in the identifier you set in storyboard) and cast it to our custom AlbumCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell

        // Use the indexPath.item to index into the albums array to get the corresponding album
        let movie = movies[indexPath.item]

        // Get the artwork image url
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300/" + movie.poster_path.absoluteString)
            // Set the image on the image view of the cell
   
        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: imageUrl, into: cell.posterImageView)

        return cell
    }
    
    

    
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        
        collectionView.dataSource = self
        super.viewDidLoad()
        // Create a search URL for fetching albums (`entity=movie`)
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=bc5cd9c1a05098330cdba7dd04ec08f6")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
     
            
            // Create a JSON Decoder
            let decoder = JSONDecoder()
            do {
                // Try to parse the response into our custom model
                let response = try decoder.decode(PosterSearchResponse.self, from: data)
                let movies = response.results
                
               
                DispatchQueue.main.async {
                    self?.movies = movies
                    self?.collectionView.reloadData()
                }
                
                print(movies)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
//        layout.minimumInteritemSpacing = 1
//
//        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
//        // Set this to taste.
//        layout.minimumLineSpacing = 1
//
//        // Set this to however many columns you want to show in the collection.
//     //let numberOfColumns: CGFloat = 3
//
//        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 4
//                layout.itemSize = CGSize(width: width, height: width * 1.5)
        

                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 5
                let numberOfColumns: CGFloat = 3
                let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
                layout.itemSize = CGSize(width: width, height: width*3/2)

        // Calculate the height based on the aspect ratio of your images or set it to a fixed value as needed.
  

        // Set the size that each item/cell should display at
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if let cell = sender as? PosterCell,
               // Get the index path of the cell from the table view
               let indexPath = collectionView.indexPath(for: cell),
               // Get the detail view controller
               let detailViewController = segue.destination as? DetailViewController {

                // Use the index path to get the associated track
                let movie = movies[indexPath.item]

                // Set the track on the detail view controller
                detailViewController.movie = movie
            }
        }
 
}
